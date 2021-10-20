/*
R.003548

----------

Name: GHW - Monthly borrower count by zipcode
Created by: George H Williams

----------

Group: Statistics
     Last month's statistics - Next-wide

Created on: 2021-08-04 16:23:25
Modified on: 2021-08-29 21:37:15
Date last run: 2021-10-01 00:54:01

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  branches.branchname,
  branchcodeszipss.ZIPCODE,
  Coalesce(totals.Count_borrowernumber, 0) AS BORROWER_COUNT,
  renewed_lm.Count_borrowernumber AS RENEWED_LM,
  added_lm.Count_borrowernumber AS ADDED_LM,
  deleted_lm.Count_borrowernumber AS DELETED_LM
FROM
  (SELECT
     borrowers.branchcode AS BRANCHCODE,
     Left(Trim(borrowers.zipcode), 5) AS ZIPCODE
   FROM
     borrowers
   GROUP BY
     borrowers.branchcode,
     Left(Trim(borrowers.zipcode), 5)
   UNION
   SELECT
     deletedborrowers.branchcode AS BRANCHCODE,
     Left(Trim(deletedborrowers.zipcode), 5) AS ZIPCODE
   FROM
     action_logs JOIN
     deletedborrowers ON deletedborrowers.borrowernumber = action_logs.object
   WHERE
     action_logs.module = 'MEMBERS' AND
     Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND
     action_logs.action LIKE 'DELET%'
   GROUP BY
     deletedborrowers.branchcode,
     Left(Trim(deletedborrowers.zipcode), 5)
   ORDER BY
     BRANCHCODE,
     ZIPCODE) branchcodeszipss JOIN
  branches ON branchcodeszipss.BRANCHCODE = branches.branchcode LEFT JOIN
  (SELECT
     borrowers.branchcode,
     Left(Trim(borrowers.zipcode), 5) AS zipcode,
     Count(borrowers.borrowernumber) AS Count_borrowernumber
   FROM
     borrowers
   GROUP BY
     borrowers.branchcode,
     Left(Trim(borrowers.zipcode), 5)) totals ON totals.branchcode =
      branchcodeszipss.BRANCHCODE AND
      totals.zipcode = branchcodeszipss.ZIPCODE LEFT JOIN
  (SELECT
     borrowers.branchcode,
     Left(Trim(borrowers.zipcode), 5) AS zipcode,
     Count(borrowers.borrowernumber) AS Count_borrowernumber
   FROM
     borrowers
   WHERE
     Year(borrowers.dateenrolled) = Year(Now() - INTERVAL 1 MONTH) AND
     Month(borrowers.dateenrolled) = Month(Now() - INTERVAL 1 MONTH)
   GROUP BY
     borrowers.branchcode,
     Left(Trim(borrowers.zipcode), 5)) added_lm ON added_lm.branchcode =
      branchcodeszipss.BRANCHCODE AND
      added_lm.zipcode = branchcodeszipss.ZIPCODE LEFT JOIN
  (SELECT
     deletedborrowers.branchcode,
     Left(Trim(deletedborrowers.zipcode), 5) AS zipcode,
     Count(deletedborrowers.borrowernumber) AS Count_borrowernumber
   FROM
     action_logs JOIN
     deletedborrowers ON deletedborrowers.borrowernumber = action_logs.object
   WHERE
     action_logs.module = 'MEMBERS' AND
     Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND
     action_logs.action LIKE 'DELET%'
   GROUP BY
     deletedborrowers.branchcode,
     Left(Trim(deletedborrowers.zipcode), 5)) deleted_lm ON
      deleted_lm.branchcode = branchcodeszipss.BRANCHCODE AND
      deleted_lm.zipcode = branchcodeszipss.ZIPCODE LEFT JOIN
  (SELECT
     borrowers.branchcode,
     Left(Trim(borrowers.zipcode), 5) AS zipcode,
     Count(borrowers.borrowernumber) AS Count_borrowernumber
   FROM
     borrowers
   WHERE
     Year(borrowers.date_renewed) = Year(Now() - INTERVAL 1 MONTH) AND
     Month(borrowers.date_renewed) = Month(Now() - INTERVAL 1 MONTH)
   GROUP BY
     borrowers.branchcode,
     Left(Trim(borrowers.zipcode), 5)) renewed_lm ON renewed_lm.branchcode =
      branchcodeszipss.BRANCHCODE AND
      renewed_lm.zipcode = branchcodeszipss.ZIPCODE
GROUP BY
  branches.branchname,
  branchcodeszipss.ZIPCODE

























