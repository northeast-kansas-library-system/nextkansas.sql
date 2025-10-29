/*
R.002779

----------

Name: GHW - Count of current un-expired borrowers at a branch
Created by: George Williams

----------

Group: Borrowers
     -

Created on: 2016-09-27 10:16:31
Modified on: 2024-01-17 11:36:31
Date last run: 2024-07-23 15:34:05

----------

Public: 0
Expiry: 0

----------

<div class="reportinfo noprint"> 
<p>Counts un-expired borrowers with a specified homebranch</p>
<ul><li>Counts borrowers currently in NExpress</li>
<li>with a specified homebranch</li>
<li>grouped and sorted by borrower's home library</li>
</ul><br />
</div>

----------
*/



SELECT
  borrowers.branchcode AS BORROWER_HOME_LIBRARY,
  Count(borrowers.borrowernumber) AS COUNT_OF_BORROWERS
FROM
  borrowers
WHERE
  borrowers.dateexpiry > Now() AND
  borrowers.branchcode LIKE <>
GROUP BY
  borrowers.branchcode WITH ROLLUP

























