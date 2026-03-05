/*
R.003369

----------

Name: GHW - SABETHA patrons without Kanopy access 
Created by: George Williams

----------

Group:  SABETHA
     -

Created on: 2020-11-13 13:57:14
Modified on: 2025-04-04 15:53:55
Date last run: 2025-04-04 15:53:56

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Shows patrons with a SABETHA home library but without a "Kanopy (SABETHA): Allowed . . ." borrower attribute.&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows borrwoers that currently lack this attribute&lt;/li&gt;
&lt;li&gt;grouped by categorycode and borrowernumber&lt;/li&gt;
&lt;li&gt;sorted by library card number&lt;/li&gt;
&lt;li&gt;links to the borrower account&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Should be run monthly at SABETHA so the attribute can be added to those accounts&lt;/p&gt;
&lt;p&gt;&lt;a href="https://northeast-kansas-library-system.github.io/next/branches/SABETHA/kanopy.html#running-reports-to-manually-update-kanopy-permission" target="_blank"&gt;Go to the training information for the Kanopy (SABETHA) extended borrower attribute.&lt;/a&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3369&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;p class= "notetags" style="display: none;"&gt;kanopy; patron-extended-attributes; SABETHA;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  Concat(
    'Go to patron account'
  ) AS LINK,
  borrowers.cardnumber AS CARD_NUMBER
FROM
  borrowers
  LEFT JOIN (
    SELECT
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute
    FROM
      borrower_attributes
    WHERE
      borrower_attributes.code = 'SABEKANOPY'
  ) kanopy
    ON kanopy.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode = 'SABETHA' AND
  kanopy.attribute IS NULL AND
  borrowers.categorycode &lt;&gt; 'STAFF' AND
  borrowers.categorycode &lt;&gt; "ILL" AND
  borrowers.categorycode &lt;&gt; "INHOUSE" AND
  borrowers.categorycode &lt;&gt; "STATISTIC" AND 
  borrowers.categorycode &lt;&gt; "S_SIP" AND 
  borrowers.othernames &lt;&gt; 'SIP2 test account'
GROUP BY
  borrowers.categorycode,
  borrowers.borrowernumber
ORDER BY
  borrowers.cardnumber

























