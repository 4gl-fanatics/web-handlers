/*------------------------------------------------------------------------
    File        : BusinessEntity
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : marko
    Created     : Tue Oct 15 13:05:08 CEST 2019
    Notes       : 
  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Progress.Lang.*.
USING Ccs.BusinessLogic.* FROM PROPATH.
USING OERA.* FROM PROPATH.

CLASS OERA.BusinessEntity
    ABSTRACT
    IMPLEMENTS IBusinessEntity,
               IUpdatableBusinessEntity: 

    DEFINE PUBLIC PROPERTY DatasetHandle AS HANDLE NO-UNDO 
    GET.
    SET. 

    DEFINE PROTECTED PROPERTY TableRequest AS IGetDataTableRequest NO-UNDO 
    GET.
    SET. 

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PROTECTED ABSTRACT VOID AttachDataSource ():
        
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID DatasetBeforeFill (DATASET-HANDLE phDataset):
        
        phDataset:GET-BUFFER-HANDLE (THIS-OBJECT:TableRequest:TableName):RESTART-ROW = ABSOLUTE (INTEGER (THIS-OBJECT:TableRequest:PagingContext) + 1).

    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PROTECTED ABSTRACT VOID DetachDataSource ():
        
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID dispose ():
        
    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PRIVATE Ccs.BusinessLogic.IGetDataResponse GetDataInternal (poRequest AS Ccs.BusinessLogic.IGetDataRequest):
        
        DEFINE VARIABLE cQuery           AS CHARACTER             NO-UNDO.
        DEFINE VARIABLE iTable           AS INTEGER               NO-UNDO.
        DEFINE VARIABLE hTempTableBuffer AS HANDLE                NO-UNDO.
        DEFINE VARIABLE hQuery           AS HANDLE                NO-UNDO.
        DEFINE VARIABLE oTableRequest    AS IGetDataTableRequest  NO-UNDO.

        DEFINE VARIABLE oResponse        AS GetDataResponse       NO-UNDO.
        DEFINE VARIABLE oTableResponses  AS IGetDataTableResponse NO-UNDO EXTENT.
        DEFINE VARIABLE oTableResponse   AS GetDataTableResponse  NO-UNDO.
        
        EXTENT (oTableResponses) = EXTENT (poRequest:TableRequests).
        
        THIS-OBJECT:DatasetHandle:EMPTY-DATASET ().
        
        TableLoop:
        DO iTable = 1 TO EXTENT (poRequest:TableRequests) ON ERROR UNDO, THROW: 

            oTableRequest = poRequest:TableRequests[iTable].
            
            IF NOT VALID-OBJECT (oTableRequest) THEN 
                NEXT TableLoop.
            
            hTempTableBuffer = THIS-OBJECT:DatasetHandle:GET-BUFFER-HANDLE (SUBSTITUTE ("e&1", oTableRequest:TableName)).

            IF SESSION:BATCH-MODE THEN 
                MESSAGE  "Fetching data: FOR EACH" oTableRequest:TableName oTableRequest:QueryString
                VIEW-AS ALERT-BOX.
        
            CREATE QUERY hQuery.
            hQuery:ADD-BUFFER (hTempTableBuffer:DATA-SOURCE:GET-SOURCE-BUFFER (1)).
            hTempTableBuffer:DATA-SOURCE:QUERY = hQuery.

            cQuery = SUBSTITUTE ("for each &1 &2",
                                 oTableRequest:TableName,
                                 oTableRequest:QueryString).
                                 
            MESSAGE "Executing Query: " cQuery
            VIEW-AS ALERT-BOX.

            hQuery:QUERY-PREPARE (cQuery).
            
            hTempTableBuffer:BATCH-SIZE = ABSOLUTE (oTableRequest:NumRecords).
            
            IF oTableRequest:PagingContext = "NNN" THEN DO:
                oTableResponse = NEW GetDataTableResponse (oTableRequest:TableName,
                                                           "NNN":U,
                                                           "":U).
                oTableResponses[iTable] = oTableResponse.

                NEXT TableLoop.
            END.

            IF oTableRequest:PagingContext <> "" AND oTableRequest:PagingContext <> ? THEN DO:
                hQuery:QUERY-OPEN ().
                hTempTableBuffer:DATA-SOURCE:RESTART-ROW = ABSOLUTE (INTEGER (oTableRequest:PagingContext) + 1).
                hQuery:GET-NEXT () .
            END.


            THIS-OBJECT:DatasetHandle:FILL ().

            IF hTempTableBuffer:LAST-BATCH THEN DO:
                oTableResponse = NEW GetDataTableResponse (oTableRequest:TableName,
                                                           "NNN",
                                                           "":U).
                oTableResponses[iTable] = oTableResponse.
            END.
            ELSE DO:
                oTableResponse = NEW GetDataTableResponse (oTableRequest:TableName,
                                                           STRING (INTEGER (oTableRequest:PagingContext) + oTableRequest:NumRecords),
                                                           "":U).
                oTableResponses[iTable] = oTableResponse.
            END.
            
            THIS-OBJECT:TableRequest = oTableRequest.
            
            FINALLY:
                hTempTableBuffer = ?.
                oTableRequest = ?.
            END FINALLY.

        END.

        oResponse = NEW GetDataResponse (oTableResponses).
            
        RETURN oResponse.

    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC Ccs.BusinessLogic.IGetDataResponse getData (poRequest AS Ccs.BusinessLogic.IGetDataRequest, 
                                                              OUTPUT DATASET-HANDLE phDataset):

        DEFINE VARIABLE oResponse AS Ccs.BusinessLogic.IGetDataResponse NO-UNDO.

        THIS-OBJECT:AttachDataSource ().
                
        oResponse = THIS-OBJECT:GetDataInternal (poRequest).

        IF VALID-HANDLE (phDataset) THEN DO:
            phDataset:EMPTY-DATASET ().
            phDataset:COPY-DATASET (THIS-OBJECT:DatasetHandle, TRUE).
        END.
        ELSE
            ASSIGN phDataset = THIS-OBJECT:DatasetHandle.

        RETURN oResponse .

        FINALLY:
            THIS-OBJECT:DetachDataSource ().
        END FINALLY.
        
    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID getDataset (OUTPUT DATASET-HANDLE phDataset):
        
        UNDO, THROW NEW Progress.Lang.AppError("METHOD NOT IMPLEMENTED").

    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC Ccs.BusinessLogic.IGetResultCountResponse getResultCount (poRequest AS Ccs.BusinessLogic.IGetDataRequest):
        
        UNDO, THROW NEW Progress.Lang.AppError("METHOD NOT IMPLEMENTED").

    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID initialize ():
        
        UNDO, THROW NEW Progress.Lang.AppError("METHOD NOT IMPLEMENTED").

    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC Progress.Lang.Object updateData (INPUT-OUTPUT DATASET-HANDLE phDataset, 
                                                   poUpdateDataRequest AS Ccs.BusinessLogic.IUpdateDataRequest):
        
        DEFINE VARIABLE iTable   AS INTEGER NO-UNDO.
        DEFINE VARIABLE hBuffer  AS HANDLE  NO-UNDO.
        DEFINE VARIABLE hBefore  AS HANDLE  NO-UNDO.
        DEFINE VARIABLE hQuery   AS HANDLE  NO-UNDO.
        DEFINE VARIABLE hDataset AS HANDLE  NO-UNDO.

        THIS-OBJECT:DatasetHandle:EMPTY-DATASET ().
        
        hDataset = THIS-OBJECT:DatasetHandle.

        IF hDataset <> phDataset THEN
            hDataset:COPY-DATASET (phDataset) .
        
        THIS-OBJECT:AttachDataSource ().

        TransactionLoop:
        DO iTable = 1 TO hDataset:NUM-BUFFERS TRANSACTION:
            
            hBuffer = hDataset:GET-BUFFER-HANDLE (iTable).

            hBefore = hBuffer:BEFORE-BUFFER.
            CREATE QUERY hQuery.
            hQuery:ADD-BUFFER (hBefore).
            hQuery:QUERY-PREPARE (SUBSTITUTE ("FOR EACH &1", hBefore:NAME)).
            hQuery:QUERY-OPEN ().
            hQuery:GET-NEXT ().
            
            TableLoop:
            DO WHILE NOT hQuery:QUERY-OFF-END:
                
                THIS-OBJECT:ValidateData ().

                hBefore:SAVE-ROW-CHANGES ().
                MESSAGE "Record saved"
                VIEW-AS ALERT-BOX.
                
                hQuery:GET-NEXT ().
            END.
            
            FINALLY:
                hQuery:QUERY-CLOSE ().
                DELETE OBJECT hQuery.
            END FINALLY.
            
        END.
        
        FINALLY:
            THIS-OBJECT:DetachDataSource ().
        END FINALLY.
        
    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PROTECTED ABSTRACT VOID ValidateData ().

END CLASS.