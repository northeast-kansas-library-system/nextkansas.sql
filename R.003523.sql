/*
R.003523

----------

Name: GHW - Non-BASEHOR patrons with BASEHOR Kanopy access 
Created by: George Williams

----------

Group:  BASEHOR
     -

Created on: 2021-06-14 11:44:12
Modified on: 2025-04-04 15:30:14
Date last run: 2025-12-05 09:47:43

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Shows patrons with a "Kanopy (BASEHOR): Allowed . . ." patron attribute but without a BASEHOR homebranch&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows borrwoers that currently have this attribute&lt;/li&gt;
&lt;li&gt;grouped by categorycode and borrowernumber&lt;/li&gt;
&lt;li&gt;sorted by library card number&lt;/li&gt;
&lt;li&gt;links to the borrower account&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Should be run monthly at BASEHOR so the attribute can be removed from those accounts&lt;/p&gt;
&lt;p&gt;&lt;a href="https://northeast-kansas-library-system.github.io/next/branches/BASEHOR/kanopy.html#running-reports-to-manually-update-kanopy-permission" target="_blank"&gt;Go to the training information for the Kanopy (BASEHOR) extended borrower attribute.&lt;/a&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p class= "notetags" style="display: none;"&gt;kanopy; patron-extended-attributes; BASEHOR;&lt;/p&gt;
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
      borrower_attributes.code = 'BASEKANOPY'
  ) kanopy
    ON kanopy.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode &lt;&gt; 'BASEHOR' AND
  kanopy.attribute = 'BASEHOR' AND
  borrowers.othernames &lt;&gt; 'SIP2 test account'
GROUP BY
  borrowers.categorycode,
  borrowers.borrowernumber
ORDER BY
  borrowers.cardnumber

























