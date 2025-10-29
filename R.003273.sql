/*
R.003273

----------

Name: GHW - Miss labeled discovery ADMINREPORT
Created by: George Williams

----------

Group: -
     -

Created on: 2019-09-30 22:29:07
Modified on: 2023-03-29 09:58:06
Date last run: 2023-03-29 09:58:19

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  branchtransfers.branchtransfer_id,
  reportingbranch.branchcode,
  Upper(items.barcode) AS ITEM_BC,
  branchtransfers.itemnumber,
  branchtransfers.frombranch,
  branchtransfers.datesent,
  branchtransfers.tobranch,
  branchtransfers.datearrived,
  branchtransfers.comments,
  Concat('Report 3272') AS REPORT
FROM
  items
  JOIN branchtransfers
    ON branchtransfers.itemnumber = items.itemnumber,
  (
    SELECT
      branches.branchcode,
      branches.branchname
    FROM
      branches
    WHERE
      branches.branchcode LIKE <>
  ) reportingbranch
WHERE
  items.barcode LIKE Concat("%", <>, "%")
GROUP BY
  branchtransfers.branchtransfer_id,
  reportingbranch.branchcode
ORDER BY
  branchtransfers.datesent DESC

























