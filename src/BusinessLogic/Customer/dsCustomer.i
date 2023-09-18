/*------------------------------------------------------------------------
    File        : dsCustomer.i
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : marko
    Created     : Wed Oct 16 14:32:57 CEST 2019
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

   DEFINE TEMP-TABLE eCustomer NO-UNDO 
        LIKE Customer
        BEFORE-TABLE eCustomerBefore
        .

    DEFINE DATASET dsCustomer 
        FOR eCustomer
        .