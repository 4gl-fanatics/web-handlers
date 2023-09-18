/*------------------------------------------------------------------------
    File        : dsState.i
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : marko
    Created     : Wed Oct 16 14:32:57 CEST 2019
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

   DEFINE TEMP-TABLE eState NO-UNDO 
        LIKE State
        BEFORE-TABLE eStateBefore
        .

    DEFINE DATASET dsState 
        FOR eState
        .