/*------------------------------------------------------------------------
    File        : dsSalesrep.i
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : marko
    Created     : Wed Oct 16 14:32:57 CEST 2019
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

   DEFINE TEMP-TABLE eSalesrep NO-UNDO 
        LIKE Salesrep
        BEFORE-TABLE eSalesrepBefore
        .

    DEFINE DATASET dsSalesrep 
        FOR eSalesrep
        .