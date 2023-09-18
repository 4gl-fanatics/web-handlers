/*------------------------------------------------------------------------
    File        : SalesrepBusinessEntity
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : marko
    Created     : Tue Oct 22 14:08:17 CEST 2019
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OERA.BusinessEntity.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS BusinessLogic.Salesrep.SalesrepBusinessEntity 
    INHERITS BusinessEntity: 

    {BusinessLogic\Salesrep\dsSalesrep.i}
    
    DEFINE DATA-SOURCE srcSalesrep FOR Salesrep. 
        
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC SalesrepBusinessEntity ():
        SUPER ().
        
        THIS-OBJECT:DatasetHandle = DATASET dsSalesrep:HANDLE.
        
    END CONSTRUCTOR.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD OVERRIDE PROTECTED VOID AttachDataSource ():
        
        BUFFER eSalesrep:ATTACH-DATA-SOURCE (DATA-SOURCE srcSalesrep:HANDLE).
        
    END.
        
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD OVERRIDE PROTECTED VOID DetachDataSource ():
        
        BUFFER eSalesrep:DETACH-DATA-SOURCE ().
        
    END.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD OVERRIDE PROTECTED VOID ValidateData ():
        
    END METHOD.

END CLASS.