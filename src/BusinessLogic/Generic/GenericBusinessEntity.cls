/*------------------------------------------------------------------------
    File        : GenericBusinessEntity
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : marko
    Created     : Tue Oct 15 15:26:20 CEST 2019
    Notes       : 
  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Progress.Lang.*.
USING OERA.* FROM PROPATH.

CLASS BusinessLogic.Generic.GenericBusinessEntity 
    INHERITS BusinessEntity: 

    DEFINE VARIABLE hDataSource AS HANDLE NO-UNDO.
        
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC GenericBusinessEntity ():
        SUPER ().
        
        
    END CONSTRUCTOR.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD OVERRIDE PROTECTED VOID AttachDataSource ():
        
        THIS-OBJECT:DatasetHandle:get-buffer-handle (1):ATTACH-DATA-SOURCE (hDataSource).
        
    END.
        
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD OVERRIDE PROTECTED VOID DetachDataSource ():
        
        THIS-OBJECT:DatasetHandle:get-buffer-handle (1):DETACH-DATA-SOURCE ().
        
    END.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD OVERRIDE PUBLIC Ccs.BusinessLogic.IGetDataResponse getData (poRequest AS Ccs.BusinessLogic.IGetDataRequest, 
                                                                       OUTPUT DATASET-HANDLE phDataset):
        
        DEFINE VARIABLE hTempTable        AS HANDLE NO-UNDO.
        DEFINE VARIABLE hBuffer           AS HANDLE NO-UNDO.
        DEFINE VARIABLE hBufferDataSource AS HANDLE NO-UNDO.
        
        IF VALID-HANDLE (THIS-OBJECT:DatasetHandle) THEN DO:
            THIS-OBJECT:DatasetHandle:empty-dataset ().
            DELETE OBJECT THIS-OBJECT:DatasetHandle.
        END.
        
        IF VALID-HANDLE (THIS-OBJECT:hDataSource) THEN DO:
            DELETE OBJECT THIS-OBJECT:hDataSource.
        END.
        
        CREATE BUFFER hBufferDataSource FOR TABLE poRequest:TableRequests[1]:TableName.

        CREATE DATASET THIS-OBJECT:DatasetHandle.
        
        CREATE TEMP-TABLE hTempTable.
        hTempTable:CREATE-LIKE(hBufferDataSource).
        hTempTable:TEMP-TABLE-PREPARE("e" + poRequest:TableRequests[1]:TableName).

        CREATE BUFFER hBuffer FOR TABLE hTempTable.
        THIS-OBJECT:DatasetHandle:ADD-BUFFER (hBuffer).
        
        CREATE DATA-SOURCE THIS-OBJECT:hDataSource.
        CREATE BUFFER hBufferDataSource FOR TABLE poRequest:TableRequests[1]:TableName.
        THIS-OBJECT:hDataSource:ADD-SOURCE-BUFFER (hBufferDataSource, THIS-OBJECT:getPUK (hBufferDataSource)).
        
        RETURN SUPER:getData(poRequest, OUTPUT DATASET-HANDLE phDataset).
        
    END.
    
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PRIVATE CHARACTER getPUK (phBuffer AS HANDLE):
        
        DEFINE VARIABLE iIndex AS INTEGER NO-UNDO.
        
        IndexLoop:
        DO iIndex = 1 TO 20:
            IF phBuffer:INDEX-INFORMATION (iIndex) = ? THEN 
                LEAVE IndexLoop.
            
            IF ENTRY (1, phBuffer:INDEX-INFORMATION (iIndex)) = phBuffer:PRIMARY THEN DO:

                RETURN phBuffer:KEYS[iIndex].

            END.
        END.
        
        RETURN ?.

    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD OVERRIDE PROTECTED VOID ValidateData ():
        
    END METHOD.

END CLASS.