/*------------------------------------------------------------------------
    File        : GetDataRequest
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : marko
    Created     : Wed Oct 16 14:40:30 CEST 2019
    Notes       : 
  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Progress.Lang.*.
USING Ccs.BusinessLogic.*.

CLASS OERA.GetDataRequest 
    IMPLEMENTS IGetDataRequest: 

    DEFINE PUBLIC PROPERTY CustomParameter AS Progress.Lang.Object NO-UNDO 
    GET.
    SET. 

    DEFINE PUBLIC PROPERTY NamedQuery AS Ccs.BusinessLogic.INamedQuery NO-UNDO 
    GET.
    SET. 

    DEFINE PUBLIC PROPERTY TableRequests AS Ccs.BusinessLogic.IGetDataTableRequest EXTENT NO-UNDO 
    GET.
    SET. 

END CLASS.