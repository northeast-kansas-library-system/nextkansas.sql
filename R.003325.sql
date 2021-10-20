/*
R.003325

----------

Name: GHW - New requests report
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-05-04 13:02:22
Modified on: 2020-05-04 13:02:22
Date last run: 2020-05-04 13:02:33

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  reserves.branchcode,
  GROUP_CONCAT(items.barcode SEPARATOR "<br />") AS Group_Concat_barcode
FROM
  reserves JOIN
  items ON reserves.itemnumber = items.itemnumber
WHERE
  reserves.found = 'W' AND
  reserves.borrowernumber = <<Enter borrowernumber>>
GROUP BY
  reserves.branchcode

























