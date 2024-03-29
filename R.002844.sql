/*
R.002844

----------

Name: GHW - Deleted borrowers count - date range
Created by: George H Williams

----------

Group: Borrowers
     Patron Statistics

Created on: 2016-12-02 14:56:53
Modified on: 2018-04-16 11:05:22
Date last run: 2021-07-22 14:28:11

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Count of patrons deleted during the specified date range<br />(between the beginning of the day on the specified "START DATE" to the end of the day on the specified "END DATE")</p>
<ul><li>Looks at patrons who were manually deleted - does not include patrons that were deleted in batch processes</li>
<li>Allows you to specify a patron home branch and patron category if you wish</li>
<li>grouped by patron home branch and patron category - includes total count by home branch and a total for the entire table</li>
<li>sorted by patron home branch and patron category</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Report created at the request of Paola Free Library.</p>
<p>This report can only look back to the previous 60 days because we are purging data from the action logs that is more than 60 days old.</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2844&phase=Run this report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  deletedborrowers.branchcode AS PATRON_HOME_LIBRARY,
  deletedborrowers.categorycode AS PATRON_CATEGORY,
  Count(deletedborrowers.borrowernumber) AS COUNT_OF_PATRONS_DELETED
FROM
  action_logs JOIN
  deletedborrowers
    ON deletedborrowers.borrowernumber = action_logs.object
WHERE
  action_logs.module = 'MEMBERS' AND
  deletedborrowers.branchcode LIKE <<Choose patron home library|LBRANCH>> AND
  deletedborrowers.categorycode LIKE <<Choose patron category|LBORROWERCAT>> AND
  (action_logs.timestamp BETWEEN <<between the beginning of the day on "START DATE"|date>>  AND (<<and the end of the day on "END DATE"|date>>+ INTERVAL 1 DAY)) AND
  action_logs.action LIKE 'DELET%'
GROUP BY
  PATRON_HOME_LIBRARY, PATRON_CATEGORY
  WITH ROLLUP

























