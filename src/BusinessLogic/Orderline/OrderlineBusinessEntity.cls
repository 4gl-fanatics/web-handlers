/*------------------------------------------------------------------------
    File        : OrderlineBusinessEntity
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

CLASS BusinessLogic.Orderline.OrderlineBusinessEntity 
    INHERITS BusinessEntity: 

    {BusinessLogic\Orderline\dsOrderline.i}
    
    DEFINE DATA-SOURCE srcOrderline FOR Orderline. 
        
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC OrderlineBusinessEntity ():
        SUPER ().
        
        THIS-OBJECT:DatasetHandle = DATASET dsOrderline:HANDLE.
        
    END CONSTRUCTOR.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD OVERRIDE PROTECTED VOID AttachDataSource ():
        
        BUFFER eOrderline:ATTACH-DATA-SOURCE (DATA-SOURCE srcOrderline:HANDLE).
        
    END.
        
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD OVERRIDE PROTECTED VOID DetachDataSource ():
        
        BUFFER eOrderline:DETACH-DATA-SOURCE ().
        
    END.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD OVERRIDE PROTECTED VOID ValidateData ():
        
    END METHOD.

END CLASS.