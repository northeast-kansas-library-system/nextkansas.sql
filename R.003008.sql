/*
R.003008

----------

Name: GHW - Patron category count 
Created by: George H Williams

----------

Group: -
     -

Created on: 2017-10-20 11:30:17
Modified on: 2018-12-09 21:16:02
Date last run: 2019-08-21 23:18:30

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Count the number of patrons at a specified library based on patron category.</p>
<ul><li>Shows current total number of patrons plus the number of patrons added last month and the total number of patrons deleted last month</li>
<li>At the library you specify</li>
<li>grouped and sorted by patron category</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Can only be run for one library branch at a time.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3008&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  categories.description,
  If(branchlimits.categorycode IS NOT NULL, "Yes", "") AS THIS_LIB_CAN_CREATE_,
  Coalesce(totalcount.Count_borrowernumber, "-") AS TOTAL_COUNT,
  Coalesce(addcount.Count_borrowernumber, "-") AS ADD_LAST_MONTH,
  Coalesce(delcount.Count_borrowernumber, "-") AS DEL_LAST_MONTH
FROM
    (SELECT
        borrowers.categorycode,
        Count(borrowers.borrowernumber) AS Count_borrowernumber
      FROM
        borrowers
      WHERE
        borrowers.branchcode LIKE @brn := <<Choose your library|ZBRAN>> COLLATE utf8mb4_unicode_ci
      GROUP BY
        borrowers.categorycode) totalcount
  RIGHT JOIN categories ON categories.categorycode = totalcount.categorycode
  LEFT JOIN (SELECT
        borrowers.categorycode,
        Count(borrowers.borrowernumber) AS Count_borrowernumber
      FROM
        borrowers
      WHERE
        borrowers.branchcode = @brn AND
        Month(borrowers.dateenrolled) = Month(Now() - INTERVAL 1 MONTH) AND
        Year(borrowers.dateenrolled) = Year(Now() - INTERVAL 1 MONTH)
      GROUP BY
        borrowers.categorycode) addcount ON categories.categorycode = addcount.categorycode
  LEFT JOIN (SELECT
        deletedborrowers.categorycode,
        Count(deletedborrowers.borrowernumber) AS Count_borrowernumber
      FROM
        deletedborrowers
      WHERE
        deletedborrowers.branchcode = @brn AND
        Month(deletedborrowers.updated_on) = Month(Now() - INTERVAL 1 MONTH) AND
        Year(deletedborrowers.dateenrolled) = Year(Now() - INTERVAL 1 MONTH)
      GROUP BY
        deletedborrowers.categorycode) delcount ON categories.categorycode = delcount.categorycode
  LEFT JOIN (SELECT
        categories_branches.categorycode,
        categories_branches.branchcode
      FROM
        categories_branches
      WHERE
        categories_branches.branchcode LIKE @brn
      GROUP BY
        categories_branches.categorycode,
        categories_branches.branchcode) branchlimits ON categories.categorycode = branchlimits.categorycode
GROUP BY
  categories.description
LIMIT 100



