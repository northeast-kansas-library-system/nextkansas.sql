/*
R.002462

----------

Name: Holds Queue numbers
Created by: Heather Braum

----------

Group: -
     -

Created on: 2015-02-12 21:15:52
Modified on: 2021-07-16 10:42:19
Date last run: 2021-07-21 13:00:06

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  CURRENT_TIMESTAMP() AS "report time",
  Coalesce(tmp_holdsqueue.holdingbranch, "Total") AS BRANCH,
  count(*)
FROM
  tmp_holdsqueue
GROUP BY
  tmp_holdsqueue.holdingbranch WITH ROLLUP
LIMIT 100



