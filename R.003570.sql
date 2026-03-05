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

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Outputs borrower address in a way that can be easily imported back into Koha via the patron import tool&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows current borrowers&lt;/li&gt;
&lt;li&gt;at the library you specify&lt;/li&gt;
&lt;li&gt;designed to be flexible&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Notes go here.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p class= "notetags" style="display: none;"&gt;hidden flexible openrefine&lt;/p&gt;
&lt;/div&gt;

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

























