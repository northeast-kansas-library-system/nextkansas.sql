/*
R.003570

----------

Name: GHW - BPE ADMINREPORT
Created by: George Williams

----------

Group: -
     -

Created on: 2021-10-05 18:00:59
Modified on: 2024-01-17 11:28:47
Date last run: 2024-04-30 08:25:30

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
<p>Outputs borrower address in a way that can be easily imported back into Koha via the patron import tool</p>
<ul><li>Shows current borrowers</li>
<li>at the library you specify</li>
<li>designed to be flexible</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Notes go here.</p>
<p></p>
<p class= "notetags" style="display: none;">hidden flexible openrefine</p>
</div>

----------
*/



SELECT
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.firstname,
  borrowers.address,
  borrowers.address2,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  borrowers.country,
  borrowers.branchcode,
  borrowers.categorycode
FROM
  borrowers
WHERE
  borrowers.branchcode LIKE &lt;&gt; AND
  borrowers.address LIKE Concat(&lt;&gt; ,"%") AND
  borrowers.city LIKE Concat(&lt;&gt;, "%") AND
  borrowers.state LIKE Concat(&lt;&gt;, "%") AND
  borrowers.zipcode LIKE Concat(&lt;&gt;, "%") AND 
  borrowers.zipcode &lt;&gt; Concat(&lt;&gt;)
ORDER BY
  borrowers.zipcode

























