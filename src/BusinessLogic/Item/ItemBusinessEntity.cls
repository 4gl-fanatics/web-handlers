/*------------------------------------------------------------------------
    File        : ItemBusinessEntity
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

CLASS BusinessLogic.Item.ItemBusinessEntity 
    INHERITS BusinessEntity: 

    {BusinessLogic\Item\dsItem.i}
    
    DEFINE DATA-SOURCE srcItem FOR Item. 
        
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC ItemBusinessEntity ():
        SUPER ().
        
        THIS-OBJECT:DatasetHandle = DATASET dsItem:HANDLE.
        
    END CONSTRUCTOR.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD OVERRIDE PROTECTED VOID AttachDataSource ():
        
        BUFFER eItem:ATTACH-DATA-SOURCE (DATA-SOURCE srcItem:HANDLE).
        
    END.
        
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD OVERRIDE PROTECTED VOID DetachDataSource ():
        
        BUFFER eItem:DETACH-DATA-SOURCE ().
        
    END.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD OVERRIDE PROTECTED VOID ValidateData ():
        
        FOR EACH eItem WHERE ROW-STATE (eItem) = ROW-CREATED :
            
            IF eItem.Itemnum = 0 OR eItem.Itemnum = ? THEN 
                eItem.Itemnum = NEXT-VALUE (NextOrdNum).
            
        END.
        
    END METHOD.

END CLASS.