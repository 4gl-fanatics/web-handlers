/*------------------------------------------------------------------------
    File        : StateBusinessEntity
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : marko
    Created     : Tue Oct 15 15:26:20 CEST 2019
    Notes       : 
  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Progress.Lang.*.
USING OERA.* FROM PROPATH.

CLASS BusinessLogic.State.StateBusinessEntity 
    INHERITS BusinessEntity: 

    {BusinessLogic\State\dsState.i}
    
    DEFINE DATA-SOURCE srcState FOR State. 
        
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC StateBusinessEntity ():
        SUPER ().
        
        THIS-OBJECT:DatasetHandle = DATASET dsState:HANDLE.
        
    END CONSTRUCTOR.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD OVERRIDE PROTECTED VOID AttachDataSource ():
        
        BUFFER eState:ATTACH-DATA-SOURCE (DATA-SOURCE srcState:HANDLE).
        
    END.
        
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD OVERRIDE PROTECTED VOID DetachDataSource ():
        
        BUFFER eState:DETACH-DATA-SOURCE ().
        
    END.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD OVERRIDE PROTECTED VOID ValidateData ():
        
    END METHOD.

END CLASS.