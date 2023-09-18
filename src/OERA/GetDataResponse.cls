/*------------------------------------------------------------------------
    File        : GetDataResponse
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : marko
    Created     : Wed Oct 16 16:43:24 CEST 2019
    Notes       : 
  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Progress.Lang.*.
USING Ccs.BusinessLogic.IGetDataResponse.

CLASS OERA.GetDataResponse 
    IMPLEMENTS IGetDataResponse: 

    DEFINE PUBLIC PROPERTY CustomResponse AS Progress.Lang.Object NO-UNDO 
    GET.

    DEFINE PUBLIC PROPERTY TableResponses AS Ccs.BusinessLogic.IGetDataTableResponse EXTENT NO-UNDO 
    GET.
    PRIVATE SET.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC GetDataResponse (poTableResponses AS Ccs.BusinessLogic.IGetDataTableResponse EXTENT):
        SUPER ().
        THIS-OBJECT:TableResponses = poTableResponses.
    END CONSTRUCTOR.

END CLASS.