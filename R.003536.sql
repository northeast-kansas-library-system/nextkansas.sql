/*
R.003536

----------

Name: GHW - Template Toolkit creator - Borrower home library phone
Created by: George H Williams

----------

Group: Administrative Reports
     Template Toolkit

Created on: 2021-07-28 16:44:03
Modified on: 2021-07-29 15:37:30
Date last run: 2023-02-03 13:17:11

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Creates the Template Toolkit code for inserting a library phone number into a notice for the borrower's home library (in cases where the home library is needed rather than the library that's sending the e-mail notice)</p>
<ul><li>Creates code based on current library information in Koha</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Generates code for Template Toolkit use.</p>
<p></p>
<p class= "notetags" style="display: none;">#TT #templatetoolkit</p>
</div>

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

























