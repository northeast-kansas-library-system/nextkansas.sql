/*
R.003631

----------

Name: GHW - items received from transfer
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-12-22 15:50:13
Modified on: 2021-12-23 08:41:07
Date last run: 2021-12-23 08:42:48

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  branchtransfers.tobranch,
  Date_Format(branchtransfers.datearrived, "%Y-%m-%d--%H:%i") AS datearrived,
  Count(branchtransfers.branchtransfer_id) AS Count_branchtransfer_id
FROM
  branchtransfers
WHERE
  branchtransfers.tobranch Like <<Choose your library|branches>> AND
  branchtransfers.datearrived BETWEEN <<Between the start of the day on date1|date>> AND (<<the end of the day on date2|date>> + interval 1 day)
GROUP BY
  branchtransfers.tobranch,
  Date_Format(branchtransfers.datearrived, "%Y-%m-%d--%H:%i")
WITH ROLLUP

























