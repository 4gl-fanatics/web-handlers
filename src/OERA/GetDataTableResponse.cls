/*------------------------------------------------------------------------
    File        : GetDataTableResponse
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : marko
    Created     : Wed Oct 16 16:43:52 CEST 2019
    Notes       : 
  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Progress.Lang.*.
USING Ccs.BusinessLogic.IGetDataTableResponse.

CLASS OERA.GetDataTableResponse 
    IMPLEMENTS IGetDataTableResponse: 

    DEFINE PUBLIC PROPERTY NextPagingContext AS CHARACTER NO-UNDO 
    GET.
    PRIVATE SET. 

    DEFINE PUBLIC PROPERTY PreviousPagingContext AS CHARACTER NO-UNDO 
    GET.
    PRIVATE SET. 

    DEFINE PUBLIC PROPERTY TableName AS CHARACTER NO-UNDO 
    GET.
    PRIVATE SET. 

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC GetDataTableResponse (pcTableName AS CHARACTER,
                                             pcNextPagingContext AS CHARACTER,
                                             pcPreviousPagingContext AS CHARACTER):
        SUPER ().
        
        THIS-OBJECT:TableName = pcTableName.
        THIS-OBJECT:NextPagingContext = pcNextPagingContext.
        THIS-OBJECT:PreviousPagingContext = pcPreviousPagingContext.
    END CONSTRUCTOR.

END CLASS.