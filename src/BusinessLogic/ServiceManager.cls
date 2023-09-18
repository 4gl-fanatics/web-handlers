/*------------------------------------------------------------------------
    File        : ServiceManager
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : marko
    Created     : Thu Oct 17 16:56:42 CEST 2019
    Notes       : 
  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Progress.Lang.*.

CLASS BusinessLogic.ServiceManager: 

    DEFINE PRIVATE STATIC TEMP-TABLE ttService NO-UNDO
        FIELD ServiceName AS CHARACTER
        FIELD Instance AS Progress.Lang.Object
        INDEX idxMain IS PRIMARY UNIQUE ServiceName
        .

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC STATIC Progress.Lang.Object GetService (pcServiceName AS CHARACTER):
        
        DEFINE VARIABLE oService AS Progress.Lang.Object NO-UNDO.
        
        FIND FIRST ttService WHERE ttService.ServiceName = pcServiceName NO-LOCK NO-ERROR.
        
        IF SEARCH ( REPLACE (pcServiceName, ".","/") + ".r") = ? AND 
           SEARCH ( REPLACE (pcServiceName, ".","/") + ".cls") = ? THEN 
           MESSAGE "Error could not find class: " REPLACE (pcServiceName, ".","/") + ".cls"
           VIEW-AS ALERT-BOX.           
        
        IF NOT AVAILABLE ttService THEN DO: 
            oService = DYNAMIC-NEW pcServiceName ().
            
            CREATE ttService.
            ASSIGN 
                ttService.ServiceName = pcServiceName
                ttService.Instance    = oService
                .
        END.
        ELSE DO:
            IF NOT VALID-OBJECT (ttService.Instance) THEN 
                ttService.Instance    = DYNAMIC-NEW pcServiceName ().
            oService = ttService.Instance.
        END.    
        RELEASE ttService NO-ERROR.
        
        RETURN oService. 

    END METHOD.

END CLASS.