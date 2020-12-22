/*
R.003347

----------

Name: GHW - Active holds queue count
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-08-19 09:11:07
Modified on: 2020-08-19 09:11:07
Date last run: 2020-11-19 13:00:44

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  branches.branchcode,
  beshipped.Count_itemnumber AS REQUESTS_TO_SHIP,
  bepickedup.Count_itemnumber AS REQUESTS_TO_RECEIVE
FROM
  branches LEFT JOIN
  (SELECT
      tmp_holdsqueue.holdingbranch,
      Count(tmp_holdsqueue.itemnumber) AS Count_itemnumber
    FROM
      tmp_holdsqueue
    GROUP BY
      tmp_holdsqueue.holdingbranch) beshipped ON beshipped.holdingbranch =
      branches.branchcode LEFT JOIN
  (SELECT
      tmp_holdsqueue.pickbranch,
      Count(tmp_holdsqueue.itemnumber) AS Count_itemnumber
    FROM
      tmp_holdsqueue
    GROUP BY
      tmp_holdsqueue.pickbranch) bepickedup ON bepickedup.pickbranch =
      branches.branchcode
ORDER BY
  branches.branchcode



