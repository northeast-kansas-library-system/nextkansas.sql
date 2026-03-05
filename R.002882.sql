/*
R.002882

----------

Name: GHW - Patrons with multiple holds on 1 biblio
Created by: George Williams

----------

Group: Administrative Reports
     Testing

Created on: 2017-01-10 11:28:21
Modified on: 2024-01-17 11:46:26
Date last run: 2026-01-28 16:33:07

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Generates a list of all items where 1 patron has more than 1 hold on 1 bibliographic record&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows current multiple holds&lt;/li&gt;
&lt;li&gt;at all NExpress libraries&lt;/li&gt;
&lt;li&gt;grouped by biblionumber, patron barcode, and borrowernumber&lt;/li&gt;
&lt;li&gt;sorted by biblionumber, patron barcode, and borrowernumber&lt;/li&gt;
&lt;li&gt;contains links to the request record and the patron record&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2882&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  Concat('',
  reserves.biblionumber, '') AS LINK_TO_REQUESTS,
  reserves.biblionumber AS BIBLIO,
  borrowers.cardnumber AS CARD_NUMBER,
  Count(reserves.borrowernumber) AS Count_borrowernumber,
  Concat('', borrowers.borrowernumber, '') AS LINK_TO_PATRON
FROM
  reserves
  JOIN borrowers ON reserves.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.categorycode &lt;&gt; 'BOOKCLUB'  AND
  reserves.found IS NULL   
GROUP BY
  reserves.biblionumber,
  borrowers.cardnumber,
  borrowers.borrowernumber
HAVING
  Count(reserves.borrowernumber) &gt; 1

























