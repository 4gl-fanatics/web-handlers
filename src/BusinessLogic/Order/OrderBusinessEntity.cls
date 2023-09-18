/*------------------------------------------------------------------------
    File        : OrderBusinessEntity
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

CLASS BusinessLogic.Order.OrderBusinessEntity 
    INHERITS BusinessEntity: 

    {BusinessLogic\Order\dsOrder.i}
    
    DEFINE DATA-SOURCE srcOrder FOR Order. 
        
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC OrderBusinessEntity ():
        SUPER ().
        
        THIS-OBJECT:DatasetHandle = DATASET dsOrder:HANDLE.
        
    END CONSTRUCTOR.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD OVERRIDE PROTECTED VOID AttachDataSource ():
        
        BUFFER eOrder:ATTACH-DATA-SOURCE (DATA-SOURCE srcOrder:HANDLE).
        
    END.
        
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD OVERRIDE PROTECTED VOID DetachDataSource ():
        
        BUFFER eOrder:DETACH-DATA-SOURCE ().
        
    END.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD OVERRIDE PROTECTED VOID ValidateData ():
        
        FOR EACH eOrder WHERE ROW-STATE (eOrder) = ROW-CREATED :
            
            IF eOrder.Ordernum = 0 OR eOrder.Ordernum = ? THEN 
                eOrder.Ordernum = NEXT-VALUE (NextOrdNum).
            
            MESSAGE eOrder.CustNum SKIP 
                    eOrder.Ordernum SKIP 
                    eorder.SalesRep
            VIEW-AS ALERT-BOX.
            
        END.
        
    END METHOD.

END CLASS.