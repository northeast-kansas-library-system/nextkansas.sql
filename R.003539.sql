/*
R.003539

----------

Name: GHW - Monthly Borrower count by category
Created by: George H Williams

----------

Group: Statistics
     Last month's statistics - Next-wide

Created on: 2021-08-03 09:12:55
Modified on: 2021-08-29 21:38:34
Date last run: 2021-09-01 00:42:02

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  branches_categories.branchname,
  branches_categories.description,
  total.Count_borrowernumber AS "TOTAL BORROWERS",
  renewed_lm.Count_borrowernumber AS "BORROWERS RENEWED",
  added_lm.Count_borrowernumber AS "BORROWERS ADDED",
  deleted_lm.Count_borrowernumber AS "BORROWERS DELETED",
  If(limitationss.categorycode <> "", "Yes", "") AS "THIS LIB CAN USE/MAKE"
FROM
  (SELECT
     branches.branchcode,
     branches.branchname,
     categories.categorycode,
     categories.description
   FROM
     branches,
     categories) branches_categories LEFT JOIN
  (SELECT
     borrowers.branchcode,
     borrowers.categorycode,
     Count(borrowers.borrowernumber) AS Count_borrowernumber
   FROM
     borrowers
   GROUP BY
     borrowers.branchcode,
     borrowers.categorycode) total ON
      total.branchcode = branches_categories.branchcode AND
      total.categorycode = branches_categories.categorycode LEFT JOIN
  (SELECT
     borrowers.branchcode,
     borrowers.categorycode,
     Count(borrowers.borrowernumber) AS Count_borrowernumber
   FROM
     borrowers
   WHERE
     Year(borrowers.dateenrolled) = Year(Now() - INTERVAL 1 MONTH) AND
     Month(borrowers.dateenrolled) = Month(Now() - INTERVAL 1 MONTH)
   GROUP BY
     borrowers.branchcode,
     borrowers.categorycode) added_lm ON added_lm.branchcode =
      branches_categories.branchcode AND
      added_lm.categorycode = branches_categories.categorycode LEFT JOIN
  (SELECT
     borrowers.branchcode,
     borrowers.categorycode,
     Count(borrowers.borrowernumber) AS Count_borrowernumber
   FROM
     borrowers
   WHERE
     Year(borrowers.date_renewed) = Year(Now() - INTERVAL 1 MONTH) AND
     Month(borrowers.date_renewed) = Month(Now() - INTERVAL 1 MONTH)
   GROUP BY
     borrowers.branchcode,
     borrowers.categorycode) renewed_lm ON renewed_lm.branchcode =
      branches_categories.branchcode AND
      renewed_lm.categorycode = branches_categories.categorycode LEFT JOIN
  (SELECT
     deletedborrowers.branchcode,
     deletedborrowers.categorycode,
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
     deletedborrowers.categorycode) deleted_lm ON deleted_lm.branchcode =
      branches_categories.branchcode AND
      deleted_lm.categorycode = branches_categories.categorycode LEFT JOIN
  (SELECT
     categories_branches.categorycode,
     categories_branches.branchcode
   FROM
     categories_branches) limitationss ON limitationss.branchcode =
      branches_categories.branchcode AND
      limitationss.categorycode = branches_categories.categorycode
GROUP BY
  branches_categories.branchname,
  branches_categories.description
ORDER BY
  branches_categories.branchname,
  branches_categories.description



