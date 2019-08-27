/*
R.002835

----------

Name: GHW - 003 Monthly circulation
Created by: George H Williams

----------

Group: -
     -

Created on: 2016-11-28 08:58:14
Modified on: 2016-11-28 12:20:22
Date last run: 2017-11-18 06:09:38

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  statistics.branch,
  If(items.homebranch IS NULL AND deleteditems.homebranch IS NULL, ' --',
  Concat(Coalesce(items.homebranch, deleteditems.homebranch))) AS
  ITEM_HOMEBRANCH,
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
  ITEM_HOMEBRANCH
  WITH ROLLUP



