/*------------------------------------------------------------------------
    File        : dsOrder.i
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : marko
    Created     : Wed Oct 16 14:32:57 CEST 2019
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

   DEFINE TEMP-TABLE eOrder NO-UNDO 
        LIKE Order
        BEFORE-TABLE eOrderBefore
        .

    DEFINE DATASET dsOrder 
        FOR eOrder
        .