 
 /*------------------------------------------------------------------------
    File        : QueryBuilder
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Daniel
    Created     : Sat Sep 16 16:27:41 CEST 2023
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS OERA.QueryBuilder: 
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC STATIC CHARACTER SimpleConvertWebQueryToOpenEdgeQuery( phTempTable AS HANDLE,
                                                                    pcWebQuery  AS CHARACTER):
        
        DEFINE VARIABLE i            AS INTEGER   NO-UNDO.
        DEFINE VARIABLE y            AS INTEGER   NO-UNDO.
        DEFINE VARIABLE x            AS INTEGER   NO-UNDO.
        DEFINE VARIABLE cQueyPart    AS CHARACTER NO-UNDO.
        DEFINE VARIABLE cOperators   AS CHARACTER NO-UNDO INITIAL "=,<>,<,>".
        DEFINE VARIABLE cOperator    AS CHARACTER NO-UNDO.
        DEFINE VARIABLE cField       AS CHARACTER NO-UNDO.
        DEFINE VARIABLE cValue       AS CHARACTER NO-UNDO.
        DEFINE VARIABLE cResultQuery AS CHARACTER NO-UNDO.
        DEFINE VARIABLE cAnd         AS CHARACTER NO-UNDO.
        
        DO y = 1 TO NUM-ENTRIES(pcWebQuery):
            
            cQueyPart = ENTRY (y,pcWebQuery ).
            
            _loop: DO x = 1 TO NUM-ENTRIES(cOperators):
               cOperator = ENTRY (x, cOperators).
               IF NUM-ENTRIES(cQueyPart,cOperator) > 1 THEN DO:
                   ASSIGN 
                        cField = ENTRY (1, cQueyPart, cOperator)                       
                        cValue = SUBSTRING (cQueyPart, LENGTH(cField) + LENGTH(cOperator) + 1). 
                   .       
                   LEAVE _loop.
               END.
            END.
           
            DO i = 1 TO phTempTable:DEFAULT-BUFFER-HANDLE:NUM-FIELDS:
            
                IF cField = phTempTable:DEFAULT-BUFFER-HANDLE:BUFFER-FIELD(i):NAME THEN DO:
                    CASE phTempTable:DEFAULT-BUFFER-HANDLE:BUFFER-FIELD(i):DATA-TYPE:
                        WHEN "CHARACTER" THEN cValue = QUOTER(cValue).
                    END.
                END.                        
            END.
        
            IF y = 1 THEN cAnd = "". 
                     ELSE cAnd = "AND".
            cResultQuery = SUBSTITUTE ("&1 &2 &3 &4 &5", cResultQuery, 
                                                      cAnd, 
                                                      cField,
                                                      cOperator,
                                                      cValue).
        
        END.
        
        MESSAGE "Transformed WebQuery" pcWebQuery " in to " cResultQuery
        VIEW-AS ALERT-BOX.
        
        cResultQuery = SUBSTITUTE ("WHERE&1", cResultQuery).
        
        RETURN cResultQuery.

    END METHOD.

END CLASS.