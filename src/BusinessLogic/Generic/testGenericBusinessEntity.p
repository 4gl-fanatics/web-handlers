/*------------------------------------------------------------------------
    File        : testGenericBusinessEntity.p
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

DEFINE VARIABLE iCount AS INTEGER NO-UNDO.

DEFINE VARIABLE cEntityName  AS CHARACTER NO-UNDO INIT "BusinessLogic.Generic.GenericBusinessEntity".
DEFINE VARIABLE cTableName   AS CHARACTER NO-UNDO INIT "Salesrep".
DEFINE VARIABLE cQueryString AS CHARACTER NO-UNDO INIT "where Salesrep.Salesrep = 'sls'".  
DEFINE VARIABLE cNextBatch   AS CHARACTER NO-UNDO.
DEFINE VARIABLE cPrevBatch   AS CHARACTER NO-UNDO.

DEFINE VARIABLE hDataset AS HANDLE NO-UNDO.
DEFINE VARIABLE hQuery   AS HANDLE NO-UNDO.
DEFINE VARIABLE hBuffer  AS HANDLE NO-UNDO.

/* ***************************  Main Block  *************************** */

RUN Backend/proSiGetData.p (cEntityName,
                            cTableName,
                            cQueryString,
                            "",
                            OUTPUT cNextBatch,
                            OUTPUT cPrevBatch,
                            OUTPUT DATASET-HANDLE hDataset).

hBuffer = hDataset:GET-BUFFER-HANDLE (1).
CREATE QUERY hQuery.
hQuery:ADD-BUFFER (hBuffer).
hQuery:QUERY-PREPARE (SUBSTITUTE ("FOR EACH &1", hBuffer:NAME)).
hQuery:QUERY-OPEN ().
hQuery:GET-NEXT ().

DO WHILE NOT hQuery:QUERY-OFF-END:
    MESSAGE hBuffer::Salesrep SKIP hBuffer::RepName
    VIEW-AS ALERT-BOX. 
    hQuery:GET-NEXT ().
END.                            

