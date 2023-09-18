/*------------------------------------------------------------------------
    File        : testCrmBusinessEntity.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : marko
    Created     : Wed Oct 16 14:28:07 CEST 2019
    Notes       :
  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Ccs.BusinessLogic.* FROM PROPATH.
USING OERA.* FROM PROPATH.
USING BusinessLogic.Salesrep.* FROM PROPATH.

/* ***************************  Definitions  ************************** */

DEFINE VARIABLE oBusinessEntity AS SalesrepBusinessEntity NO-UNDO.
DEFINE VARIABLE oRequest        AS GetDataRequest       NO-UNDO.
DEFINE VARIABLE oTableRequests  AS IGetDataTableRequest NO-UNDO EXTENT.
DEFINE VARIABLE oTableRequest   AS GetDataTableRequest  NO-UNDO.

DEFINE VARIABLE oResponse        AS IGetDataResponse      NO-UNDO.
DEFINE VARIABLE oTableResponses  AS IGetDataTableResponse NO-UNDO EXTENT.
DEFINE VARIABLE oTableResponse   AS GetDataTableResponse  NO-UNDO.

DEFINE VARIABLE iCount AS INTEGER NO-UNDO.

{BusinessLogic\Salesrep\dsSalesrep.i}

/* ***************************  Main Block  *************************** */

oTableRequest = NEW GetDataTableRequest ().
oTableRequest:NumRecords = 50.
oTableRequest:TableName  = "Salesrep".
oTableRequest:QueryString = "where salesrep.salesrep = 'sls'".

EXTENT (oTableRequests) = 1.
oTableRequests[1] = oTableRequest.

oRequest = NEW GetDataRequest ().
oRequest:TableRequests = oTableRequests.

oBusinessEntity = NEW SalesrepBusinessEntity ().

oResponse = oBusinessEntity:getData(oRequest, OUTPUT DATASET dsSalesrep).

FOR EACH eSalesrep NO-LOCK:
    iCount = iCount + 1.
    DISPLAY eSalesrep.Salesrep eSalesrep.RepName .
END.

/*        EXTENT (oTableResponses) = 1.                                    */
/*        oTableResponse = NEW GetDataTableResponse ("test table", "", "").*/
/*        oTableResponses[1] = oTableResponse.                             */
/*        oResponse = NEW GetDataResponse (oTableResponses).               */

MESSAGE "iCount" iCount
VIEW-AS ALERT-BOX.

MESSAGE oResponse SKIP 
        EXTENT (oResponse:TableResponses) SKIP 
        oResponse:TableResponses[1]:TableName SKIP
        oResponse:TableResponses[1]:NextPagingContext
VIEW-AS ALERT-BOX.
 
IF oResponse:TableResponses[1]:NextPagingContext = "NNN" THEN 
    RETURN.
 
oTableRequest = ?.
oRequest = ?.

oTableRequest = NEW GetDataTableRequest ().
oTableRequest:NumRecords = 50.
oTableRequest:TableName  = "Salesrep".
oTableRequest:QueryString = "".
oTableRequest:PagingContext = oResponse:TableResponses[1]:NextPagingContext.

oTableRequests[1] = oTableRequest.

oRequest = NEW GetDataRequest ().
oRequest:TableRequests = oTableRequests.

 
 oResponse = ?.
 iCount = 0.
 
 oResponse = oBusinessEntity:getData(oRequest, OUTPUT DATASET dsSalesrep).

FOR EACH eSalesrep NO-LOCK:
    iCount = iCount + 1.
    DISPLAY eSalesrep.SalesRep eSalesrep.RepName.
END.

MESSAGE "iCount" iCount
VIEW-AS ALERT-BOX.

MESSAGE oResponse SKIP 
        EXTENT (oResponse:TableResponses) SKIP 
        oResponse:TableResponses[1]:TableName SKIP
        oResponse:TableResponses[1]:NextPagingContext
VIEW-AS ALERT-BOX.
 