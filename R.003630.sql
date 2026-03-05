/*
R.003630

----------

Name: GHW - Non-BONNERSPGS patrons with BONNERSPGS Kanopy access 
Created by: George Williams

----------

Group:  BONNERSPGS
     -

Created on: 2021-12-21 20:25:19
Modified on: 2025-04-04 15:50:33
Date last run: 2026-01-05 09:33:28

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Shows patrons with a "Kanopy (BONNERSPGS): Allowed . . ." patron attribute but without a BONNERSPGS homebranch&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows borrwoers that currently have this attribute&lt;/li&gt;
&lt;li&gt;grouped by categorycode and borrowernumber&lt;/li&gt;
&lt;li&gt;sorted by library card number&lt;/li&gt;
&lt;li&gt;links to the borrower account&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Should be run monthly at BONNERSPGS so the attribute can be removed from those accounts&lt;/p&gt;
&lt;p&gt;&lt;a href="https://northeast-kansas-library-system.github.io/next/branches/BONNERSPGS/kanopy.html#running-reports-to-manually-update-kanopy-permission" target="_blank"&gt;Go to the training information for the Kanopy (BONNERSPGS) extended borrower attribute.&lt;/a&gt;&lt;/p&gt;
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
      borrower_attributes.code = 'BONKANOPY'
  ) kanopy
    ON kanopy.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode &lt;&gt; 'BONNERSPGS' AND
  kanopy.attribute = 'BONNERSPGS' AND
  borrowers.othernames &lt;&gt; 'SIP2 test account'
GROUP BY
  borrowers.categorycode,
  borrowers.borrowernumber
ORDER BY
  borrowers.cardnumber

























