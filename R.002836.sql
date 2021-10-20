/*
R.002836

----------

Name: GHW - 004 Monthly circulation
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2016-11-28 09:04:33
Modified on: 2016-11-28 12:19:53
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT
  statistics.branch,
  If(items.ccode IS NULL AND deleteditems.ccode IS NULL, ' --',
  Concat(Coalesce(items.ccode, deleteditems.ccode))) AS ITEM_CCODE,
  Count(*) AS CIRC_PLUS_RENEWALS,
  Concat_Ws('.', Year(statistics.datetime), Month(statistics.datetime)) AS DATE
FROM
  statistics LEFT JOIN
  items
    ON statistics.itemnumber = items.itemnumber LEFT JOIN
  deleteditems
    ON statistics.itemnumber = deleteditems.itemnumber
WHERE
  (statistics.type = 'issue' OR statistics.type = 'renew' OR statistics.type = 'localuse') AND
  Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
  Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
GROUP BY
  statistics.branch, 
  ITEM_CCODE
  WITH ROLLUP

























