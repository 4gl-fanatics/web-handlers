/**********************************************************************
 * Copyright (C) 2006-2019 by Consultingwerk Ltd. ("CW") -            *
 * www.consultingwerk.de and other contributors as listed             *
 * below.  All Rights Reserved.                                       *
 *                                                                    *
 *  Software is distributed on an "AS IS", WITHOUT WARRANTY OF ANY    *
 *   KIND, either express or implied.                                 *
 *                                                                    *
 *  Contributors:                                                     *
 *                                                                    *
 **********************************************************************/ 
/*------------------------------------------------------------------------
    File        : eItem.i
    Purpose     : 

    Syntax      :

    Description :  

    Author(s)   : Daniel van Doorn / Consultingwerk Ltd.
    Created     : 29.10.2019 12:34:01
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */



DEFINE {&ACCESS} TEMP-TABLE eItem{&SUFFIX} NO-UNDO {&REFERENCE-ONLY} &IF DEFINED (NO-BEFORE) EQ 0 &THEN BEFORE-TABLE eItemBefore{&SUFFIX} &ENDIF
    FIELD Itemnum AS INTEGER FORMAT "zzzzzzzzz9":U INITIAL "0":U LABEL "Item Num":T
    FIELD ItemName AS CHARACTER FORMAT "x(25)":U LABEL "Item Name":T
    FIELD Price AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL "0":U LABEL "Price":T
    FIELD Onhand AS INTEGER FORMAT "->>>>9":U INITIAL "0":U LABEL "On Hand":T
    FIELD Allocated AS INTEGER FORMAT "->>>>9":U INITIAL "0":U LABEL "Allocated":T
    FIELD ReOrder AS INTEGER FORMAT "->>>>9":U INITIAL "0":U LABEL "Re Order":T
    FIELD OnOrder AS INTEGER FORMAT "->>>>9":U INITIAL "0":U LABEL "On Order":T
    FIELD CatPage AS INTEGER FORMAT ">>9":U INITIAL "0":U LABEL "Cat Page":T
    FIELD CatDescription AS CHARACTER FORMAT "X(200)":U LABEL "Cat-Description":T
    FIELD Category1 AS CHARACTER FORMAT "x(30)":U LABEL "Category1":T
    FIELD Category2 AS CHARACTER FORMAT "x(30)":U LABEL "Category2":T
    FIELD Special AS CHARACTER FORMAT "x(8)":U LABEL "Special":T
    FIELD Weight AS DECIMAL FORMAT "->>,>>9.99":U INITIAL "0":U LABEL "Weight":T
    FIELD Minqty AS INTEGER FORMAT "->>>>9":U INITIAL "0":U LABEL "Min Qty":T

    INDEX CatDescription AS WORD-INDEX CatDescription ASCENDING
    INDEX Category2ItemName Category2 ASCENDING ItemName ASCENDING
    INDEX CategoryItemName Category1 ASCENDING ItemName ASCENDING
    INDEX ItemName AS WORD-INDEX ItemName ASCENDING
    INDEX ItemNum AS UNIQUE PRIMARY Itemnum ASCENDING

    .
    
    
    DEFINE DATASET dsItem
        FOR eItem
        .
    

    