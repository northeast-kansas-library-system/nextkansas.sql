/*
R.003641

----------

Name: GHW - Basic counts for cleanup
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-01-10 16:26:23
Modified on: 2022-01-10 16:26:23
Date last run: 2022-02-15 21:57:28

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  items.itype,
  items.ccode,
  Count(DISTINCT items.itemnumber) AS Count_itemnumber
FROM
  items
GROUP BY
  items.itype,
  items.ccode

























