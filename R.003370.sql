/*
R.003370

----------

Name: GHW - Non-LINWOOD patrons with LINWOOD Kanopy access 
Created by: George Williams

----------

Group:  LINWOOD
     -

Created on: 2020-11-13 14:42:51
Modified on: 2025-04-04 15:54:35
Date last run: 2025-04-04 15:54:35

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Shows patrons with a "Kanopy (LINWOOD): Allowed . . ." patron attribute but without a LINWOOD homebranch&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows borrwoers that currently have this attribute&lt;/li&gt;
&lt;li&gt;grouped by categorycode and borrowernumber&lt;/li&gt;
&lt;li&gt;sorted by library card number&lt;/li&gt;
&lt;li&gt;links to the borrower account&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Should be run monthly at LINWOOD so the attribute can be removed from those accounts&lt;/p&gt;
&lt;p&gt;&lt;a href="https://northeast-kansas-library-system.github.io/next/branches/LINWOOD/kanopy.html#running-reports-to-manually-update-kanopy-permission" target="_blank"&gt;Go to the training information for the Kanopy (LINWOOD) extended borrower attribute.&lt;/a&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3370&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;p class= "notetags" style="display: none;"&gt;kanopy; patron-extended-attributes; LINWOOD;&lt;/p&gt;
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
      borrower_attributes.code = 'LINWKANOPY'
  ) kanopy
    ON kanopy.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode &lt;&gt; 'LINWOOD' AND
  kanopy.attribute = 'LINWOOD' AND
  borrowers.othernames &lt;&gt; 'SIP2 test account'
GROUP BY
  borrowers.categorycode,
  borrowers.borrowernumber
ORDER BY
  borrowers.cardnumber

























