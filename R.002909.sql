/*
R.002909

----------

Name: GHW - Duplicate borrowers at a library
Created by: George Williams

----------

Group: -
     -

Created on: 2017-02-20 16:37:40
Modified on: 2024-01-17 11:49:03
Date last run: 2025-03-29 15:03:59

----------

Public: 0
Expiry: 0

----------

<div class="reportinfo noprint"> 
<p>Report of possible duplicate borrowers at a library</p>
<ul><li>Shows patrons currently in the database</li>
<li>with at least one library account at the library you specify</li>
<li>grouped and sorted by last name/first name</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Updated on 2019.07.22 to filter out middle names - now matches on last name and first name when those two names are spelled exactly.  Ignores everything after the first space between name/initial strings in the borrowers.firstname field.</p>
<p></p>
<p>Report created by George Williams.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2909&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>


----------
*/



SELECT
  surname,
  firstname,
  GROUP_CONCAT(CONCAT(surname, '-', firstname) ORDER BY borrowernumber SEPARATOR '') AS NNAME,
  GROUP_CONCAT(cardnumber ORDER BY borrowernumber SEPARATOR '') as CARD_NUMBER,
  GROUP_CONCAT(dateofbirth ORDER BY borrowernumber SEPARATOR '') as BIRTH_DATE,
  GROUP_CONCAT((Concat('', borrowernumber, '')) ORDER BY borrowernumber SEPARATOR '') as BORROWER_NUMBER,
  GROUP_CONCAT(branchcode ORDER BY borrowernumber SEPARATOR '') as HOME_BRANCH,
  GROUP_CONCAT(Concat(borrowers.borrowernumber, ' // ', borrowers.debarredcomment) ORDER BY borrowernumber SEPARATOR '') AS COMMENTS
FROM borrowers
GROUP BY
  CONCAT(TRIM(surname),'-',TRIM(SUBSTRING_INDEX(firstname, ' ', 1)),'/')
HAVING
  COUNT(CONCAT(TRIM(surname),'-',TRIM(SUBSTRING_INDEX(firstname, ' ', 1)),'/'))>1 AND
  HOME_BRANCH LIKE CONCAT( '%', <>, '%')

























