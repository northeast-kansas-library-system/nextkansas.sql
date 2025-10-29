/*
R.002771

----------

Name: GHW - Card Prefix Report - Part 1
Created by: George Williams

----------

Group: -
     -

Created on: 2016-09-13 18:01:22
Modified on: 2024-12-18 15:46:26
Date last run: 2025-06-11 13:46:35

----------

Public: 0
Expiry: 0

----------

<div class="reportinfo noprint"> 
<p>Attempts to discern which card number ranges are in use at a specified library</p>
<ul><li>reports on current cards in NExpress</li>
<li>Shows card prefixes at a specified patron homebranch<br />with a specified number of prefix digits<br />and where there are more than a specified number of cards with that prefix</li>
<li>grouped and sorted by patron home library and card number prefix</li>
<li>click on links to see if other libraries are using this same prefix identified in the report (report 2773)</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p>Report 2773 is the companion to this report</p>
<p>Report created at the request of Robin Hastings.</p>
<p>Report created by George Williams.</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2771&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  <> AS CARD_PREFIX_LENGTH,
  borrowers.branchcode AS BORROWERS_HOME_BRANCH,
  Left(borrowers.cardnumber, <>) AS LIBRAY_CARD_PREFIX,
  LENGTH(borrowers.cardnumber) AS CARD_NUMBER_LENGTH,
  Count(borrowers.borrowernumber) AS LIBRARY_CARD_COUNT,
  CONCAT(
    'Link to report 2773' 
  ) AS LINK_TO_PREFIX_REPORT_2,
  Concat_WS('',
    'Prefix ',
    Left(borrowers.cardnumber, <>),
    ' / card length ',
    LENGTH(borrowers.cardnumber),
    ' digits (',
    Count(borrowers.borrowernumber),
    ' users) | '
  ) as "PLAIN_ENGLISH"
FROM
  borrowers
WHERE
  borrowers.branchcode LIKE <>
GROUP BY
  borrowers.branchcode, CARD_NUMBER_LENGTH, LIBRAY_CARD_PREFIX
HAVING
  LIBRARY_CARD_COUNT >= <>
ORDER BY
  borrowers.branchcode,
  LIBRAY_CARD_PREFIX

























