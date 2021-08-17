/*
R.003535

----------

Name: GHW - Template Toolkit creator - Borrower home library address
Created by: George H Williams

----------

Group: Administrative Reports
     Template Toolkit

Created on: 2021-07-28 16:42:30
Modified on: 2021-07-29 15:37:44
Date last run: 2021-07-29 15:25:54

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Creates the Template Toolkit code for inserting a library address into a notice for the borrower's home library (in cases where the home library is needed rather than the library that's sending the e-mail notice)</p>
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
    "') %] <p>", 
    branches.branchname, 
    "<br />", 
    branches.branchaddress1, 
    "<br />",
    branches.branchcity, 
    ", ", 
    branches.branchstate, 
    " ", 
    Left(branches.branchzip,5), 
    "</p> [% END %]"
  ) AS TT_HOMELIBRARY_ADDRESS
FROM
  branches



