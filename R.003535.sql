/*
R.003535

----------

Name: GHW - Template Toolkit creator - Borrower home library address
Created by: George Williams

----------

Group: Administrative Reports
     Template Toolkit

Created on: 2021-07-28 16:42:30
Modified on: 2024-01-17 11:28:17
Date last run: 2023-11-07 10:58:56

----------

Public: 0
Expiry: 300

----------

 
Creates the Template Toolkit code for inserting a library address into a notice for the borrower's home library (in cases where the home library is needed rather than the library that's sending the e-mail notice)
Creates code based on current library information in Koha

Notes:

Generates code for Template Toolkit use.

#TT #templatetoolkit


----------
*/



SELECT
  Concat_Ws("", 
    "[% IF (borrower.branchcode == '", 
    branches.branchcode,
    "') %] ", 
    branches.branchname, 
    "", 
    branches.branchaddress1, 
    "",
    branches.branchcity, 
    ", ", 
    branches.branchstate, 
    " ", 
    Left(branches.branchzip,5), 
    " [% END %]"
  ) AS TT_HOMELIBRARY_ADDRESS
FROM
  branches

























