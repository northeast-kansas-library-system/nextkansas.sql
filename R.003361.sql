/*
R.003361

----------

Name: GHW - Borrower count
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-10-29 13:05:33
Modified on: 2021-09-10 13:08:43
Date last run: 2022-03-15 14:37:48

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Counts borrowers</p>
<ul><li>current count plus added, renewed, and deleted last month</li>
<li>at the library you specify</li>
<li>grouped library code and category code</li>
<li>sorted by (in progress)</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Notes go here.</p>
<p>Replaces:</p>
<ul>
  <li>Report 574 - Monthly 004 New Patrons by Category</li>
  <li>Report 1308 - Count of Patrons by Category</li>
  <li>Report 2843 - GHW - Deleted borrowers count - previous month</li>
  <li>Report 2903 - GHW - Patrons added count by category - previous calendar month</li>
  <li>Report 3008 - GHW - Patron category count</li>
  <li>Report 3077 - GHW - Borrowers count by category</li>
</ul>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3361&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">#borrower #count #ultimate</p>
</div>

----------
*/



SELECT
  branchescategories.branchname,
  If(
    branchescategories.category_type = 'A', 
    'Adult', 
    If(
      branchescategories.category_type = 'C', 
      'Minor', 
      If(
        branchescategories.category_type = 'S', 
        'Staff', 
        If(
          branchescategories.category_type = 'I', 
          'Organization', 
          If(
            branchescategories.category_type = 'P', 
            'Professional', 
            If(
              branchescategories.category_type = 'X', 
              'Statistical', 
              branchescategories.category_type
            )
          )
        )
      )
    )
  ) AS CATEGORY_TYPE,
  
    If(Concat(branchescategories.dateofbirthrequired,
  branchescategories.upperagelimit) = 0999, "Any age",
  If(Concat(branchescategories.dateofbirthrequired,
  branchescategories.upperagelimit) LIKE "1_999",
  Concat(branchescategories.dateofbirthrequired, " or older"), Concat_Ws(" -- ",
  branchescategories.dateofbirthrequired, branchescategories.upperagelimit))) AS
  AGE_RANGE,
  
  branchescategories.description AS DESCRIPTION,
  branchescategories.categorycode,
  If(categories_branches.branchcode IS NULL, '', 'Yes') AS STAFF_CAN_CREATE_NEW,
  TOTAL.Count_borrowernumber AS TOTAL_BORROWERS,
  LM_ADDED.Count_borrowernumber AS ADDED_LM,
  LM_RENEWED.Count_borrowernumber AS RENEWED_LM,
  LM_DELETED.Count_borrowernumber AS DELETED_LM
FROM
  (SELECT
      branches.branchcode,
      branches.branchname,
      categories.categorycode,
      categories.description,
      categories.category_type,
      categories.dateofbirthrequired,
      categories.upperagelimit
    FROM
      branches,
      categories) branchescategories LEFT JOIN
  categories_branches ON categories_branches.branchcode =
      branchescategories.branchcode AND
      categories_branches.categorycode = branchescategories.categorycode
  LEFT JOIN
  (SELECT
      Count(borrowers.borrowernumber) AS Count_borrowernumber,
      borrowers.branchcode,
      borrowers.categorycode
    FROM
      borrowers
    GROUP BY
      borrowers.branchcode,
      borrowers.categorycode) TOTAL ON
      TOTAL.branchcode = branchescategories.branchcode AND
      TOTAL.categorycode = branchescategories.categorycode LEFT JOIN
  (SELECT
      Count(borrowers.borrowernumber) AS Count_borrowernumber,
      borrowers.branchcode,
      borrowers.categorycode
    FROM
      borrowers
    WHERE
      Year(borrowers.dateenrolled) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(borrowers.dateenrolled) = Month(Now() - INTERVAL 1 MONTH)
    GROUP BY
      borrowers.branchcode,
      borrowers.categorycode) LM_ADDED ON LM_ADDED.branchcode =
      branchescategories.branchcode AND
      LM_ADDED.categorycode = branchescategories.categorycode LEFT JOIN
  (SELECT
      deletedborrowers.branchcode,
      deletedborrowers.categorycode,
      Count(deletedborrowers.borrowernumber) AS Count_borrowernumber
    FROM
      deletedborrowers
    WHERE
      Year(deletedborrowers.updated_on) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(deletedborrowers.updated_on) = Month(Now() - INTERVAL 1 MONTH)
    GROUP BY
      deletedborrowers.branchcode,
      deletedborrowers.categorycode) LM_DELETED ON LM_DELETED.branchcode =
      branchescategories.branchcode AND
      LM_DELETED.categorycode = branchescategories.categorycode LEFT JOIN
  (SELECT
      Count(borrowers.borrowernumber) AS Count_borrowernumber,
      borrowers.branchcode,
      borrowers.categorycode
    FROM
      borrowers
    WHERE
      Year(borrowers.date_renewed) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(borrowers.date_renewed) = Month(Now() - INTERVAL 1 MONTH)
    GROUP BY
      borrowers.branchcode,
      borrowers.categorycode) LM_RENEWED ON LM_RENEWED.branchcode =
      branchescategories.branchcode AND
      LM_RENEWED.categorycode = branchescategories.categorycode
WHERE
  (branchescategories.branchcode LIKE @brn := <<Choose your library|branches>> COLLATE utf8mb4_unicode_ci)
GROUP BY
  branchescategories.branchname,
  branchescategories.categorycode
UNION
SELECT
  Concat(branchescategories.branchname, ' - TOTAL') AS branchname,
  Concat('') AS CATEGORY_TYPE,
  Concat('') AS AGE_RANGE,
  Concat('') AS DESCRIPTION,
  Concat('') AS CATEGORYCODE,
  Concat('') AS STAFF_CAN_CREATE_NEW,
  TOTAL.Count_borrowernumber AS TOTAL_BORROWERS,
  LM_ADDED.Count_borrowernumber AS ADDED_LM,
  LM_RENEWED.Count_borrowernumber AS RENEWED_LM,
  LM_DELETED.Count_borrowernumber AS DELETED_LM
FROM
  (SELECT
      branches.branchcode,
      branches.branchname
    FROM
      branches) branchescategories LEFT JOIN
  (SELECT
      Count(borrowers.borrowernumber) AS Count_borrowernumber,
      borrowers.branchcode
    FROM
      borrowers
    WHERE
      Year(borrowers.dateenrolled) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(borrowers.dateenrolled) = Month(Now() - INTERVAL 1 MONTH)
    GROUP BY
      borrowers.branchcode) LM_ADDED ON LM_ADDED.branchcode =
      branchescategories.branchcode LEFT JOIN
  (SELECT
      deletedborrowers.branchcode,
      Count(deletedborrowers.borrowernumber) AS Count_borrowernumber
    FROM
      deletedborrowers
    WHERE
      Year(deletedborrowers.updated_on) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(deletedborrowers.updated_on) = Month(Now() - INTERVAL 1 MONTH)
    GROUP BY
      deletedborrowers.branchcode) LM_DELETED ON LM_DELETED.branchcode =
      branchescategories.branchcode LEFT JOIN
  (SELECT
      Count(borrowers.borrowernumber) AS Count_borrowernumber,
      borrowers.branchcode
    FROM
      borrowers
    WHERE
      Year(borrowers.date_renewed) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(borrowers.date_renewed) = Month(Now() - INTERVAL 1 MONTH)
    GROUP BY
      borrowers.branchcode) LM_RENEWED ON LM_RENEWED.branchcode =
      branchescategories.branchcode LEFT JOIN
  (SELECT
      Count(borrowers.borrowernumber) AS Count_borrowernumber,
      borrowers.branchcode
    FROM
      borrowers
    GROUP BY
      borrowers.branchcode) TOTAL ON
      TOTAL.branchcode = branchescategories.branchcode
WHERE
  branchescategories.branchcode LIKE @brn
GROUP BY
  Concat(branchescategories.branchname, ' - TOTAL')
ORDER BY
  branchname,
  Coalesce(DESCRIPTION, 'Z')

























