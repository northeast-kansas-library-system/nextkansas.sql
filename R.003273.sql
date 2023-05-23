/*
R.003273

----------

Name: GHW - Miss labeled discovery ADMINREPORT
Created by: George H Williams

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
  Concat('<a href=\"/cgi-bin/koha/reports/guided_reports.pl?reports=3272&phase=Run+this+report&param_name=Transfer+ID&sql_params=', branchtransfers.branchtransfer_id, '&param_name=Library+receiving+miss-labeled+item%7Cbranches&sql_params=', reportingbranch.branchcode, ' " target="_blank">Report 3272</a>') AS REPORT
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
      branches.branchcode LIKE <<Choose your library|branches>>
  ) reportingbranch
WHERE
  items.barcode LIKE Concat("%", <<item barcode>>, "%")
GROUP BY
  branchtransfers.branchtransfer_id,
  reportingbranch.branchcode
ORDER BY
  branchtransfers.datesent DESC

























