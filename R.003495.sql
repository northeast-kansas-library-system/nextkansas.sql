/*
R.003495

----------

Name: GHW - LANSING patrons without Kanopy access
Created by: George Williams

----------

Group:  LANSING
     -

Created on: 2021-04-22 15:21:41
Modified on: 2025-04-24 13:23:43
Date last run: 2025-11-19 17:38:59

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Shows patrons with a LANSING home library but without a "Kanopy (LANSING): Allowed . . ." borrower attribute.&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows borrwoers that currently lack this attribute&lt;/li&gt;
&lt;li&gt;grouped by categorycode and borrowernumber&lt;/li&gt;
&lt;li&gt;sorted by library card number&lt;/li&gt;
&lt;li&gt;links to the borrower account&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Should be run monthly at LANSING so the attribute can be added to those accounts&lt;/p&gt;
&lt;p&gt;&lt;a href="https://northeast-kansas-library-system.github.io/next/branches/LANSING/kanopy.html#running-reports-to-manually-update-kanopy-permission" target="_blank"&gt;Go to the training information for the Kanopy (LANSING) extended borrower attribute.&lt;/a&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p class= "notetags" style="display: none;"&gt;kanopy; patron-extended-attributes; LANSING;&lt;/p&gt;
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
      borrower_attributes.code = 'LANSKANOPY'
  ) kanopy
    ON kanopy.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode = 'LANSING' AND
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

























