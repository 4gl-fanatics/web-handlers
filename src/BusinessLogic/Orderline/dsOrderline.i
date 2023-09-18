/*------------------------------------------------------------------------
    File        : dsOrderline.i
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : marko
    Created     : Wed Oct 16 14:32:57 CEST 2019
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

   DEFINE TEMP-TABLE eOrderline NO-UNDO 
        LIKE Orderline
        BEFORE-TABLE eOrderlineBefore
        .

    DEFINE DATASET dsOrderline 
        FOR eOrderline
        .