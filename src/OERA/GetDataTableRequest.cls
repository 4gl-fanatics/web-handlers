/*------------------------------------------------------------------------
    File        : GetDataTableRequest
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : marko
    Created     : Wed Oct 16 14:42:20 CEST 2019
    Notes       : 
  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Progress.Lang.*.
USING Ccs.BusinessLogic.*.

CLASS OERA.GetDataTableRequest 
    IMPLEMENTS IGetDataTableRequest: 

    DEFINE PUBLIC PROPERTY NumRecords AS INT64 NO-UNDO 
    GET.
    SET. 

    DEFINE PUBLIC PROPERTY PagingContext AS CHARACTER NO-UNDO 
    GET.
    SET. 

    DEFINE PUBLIC PROPERTY QueryDefinition AS Ccs.BusinessLogic.IQueryDefinition NO-UNDO 
    GET.
    SET. 

    DEFINE PUBLIC PROPERTY QueryString AS CHARACTER NO-UNDO 
    GET.
    SET. 

    DEFINE PUBLIC PROPERTY Skip AS INT64 NO-UNDO 
    GET.
    SET. 

    DEFINE PUBLIC PROPERTY TableName AS CHARACTER NO-UNDO 
    GET.
    SET. 

END CLASS.