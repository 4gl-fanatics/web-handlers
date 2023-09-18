/*------------------------------------------------------------------------
    File        : UpdateDataRequest
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : marko
    Created     : Mon Oct 21 16:59:27 CEST 2019
    Notes       : 
  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Progress.Lang.*.
USING Ccs.BusinessLogic.IUpdateDataRequest.

CLASS OERA.UpdateDataRequest 
    IMPLEMENTS IUpdateDataRequest: 

    DEFINE PUBLIC PROPERTY CommitScope AS Ccs.BusinessLogic.CommitScopeEnum NO-UNDO 
    GET.
    PRIVATE SET. 

    DEFINE PUBLIC PROPERTY CustomRequest AS Progress.Lang.Object NO-UNDO 
    GET.
    PRIVATE SET. 

END CLASS.