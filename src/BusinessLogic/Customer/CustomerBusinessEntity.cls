/*------------------------------------------------------------------------
    File        : CustomerBusinessEntity
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

CLASS BusinessLogic.Customer.CustomerBusinessEntity 
    INHERITS BusinessEntity: 

    {BusinessLogic\Customer\dsCustomer.i}

    DEFINE DATA-SOURCE srcCustomer FOR Customer.
    
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC CustomerBusinessEntity ():
        SUPER ().
        
        THIS-OBJECT:DatasetHandle = DATASET dsCustomer:HANDLE.
        
    END CONSTRUCTOR.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD OVERRIDE PROTECTED VOID AttachDataSource ():
        
        BUFFER eCustomer:ATTACH-DATA-SOURCE (DATA-SOURCE srcCustomer:HANDLE).
        
    END.
        
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD OVERRIDE PROTECTED VOID DetachDataSource ():
        
        BUFFER eCustomer:DETACH-DATA-SOURCE ().
        
    END.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID TestInvoke (INPUT-OUTPUT plcParameter AS LONGCHAR):
        
        plcParameter = "This is the result".

    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD OVERRIDE PROTECTED VOID ValidateData ():
        
        RETURN.

    END METHOD.

END CLASS.