/*
R.003536

----------

Name: GHW - Template Toolkit creator - Borrower home library phone
Created by: George Williams

----------

Group: Administrative Reports
     Template Toolkit

Created on: 2021-07-28 16:44:03
Modified on: 2024-01-17 11:28:20
Date last run: 2023-06-02 13:43:41

----------

Public: 0
Expiry: 300

----------

 
Creates the Template Toolkit code for inserting a library phone number into a notice for the borrower's home library (in cases where the home library is needed rather than the library that's sending the e-mail notice)
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
    "') %]", 
    branches.branchphone, 
    "[% END %]"
  ) AS TT_HOMELIBRARY_ADDRESS
FROM
  branches

























