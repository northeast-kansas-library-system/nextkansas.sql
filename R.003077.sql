/*
R.003077

----------

Name: GHW - Borrowers count by category
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-04-20 19:05:59
Modified on: 2019-08-09 11:49:14
Date last run: 2020-08-19 09:30:22

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Counts the number of borrowers at the library you specify</p>
<ul><li>Counts current borrowers - counts borrowers added last month - and indicates whether staff can create new accounts in that category</li>
<li>at the library you specify</li>
<li>grouped and sorted by patron home library and patron category description</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Notes go here.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3077&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  branchcats.branchcode,
  IF(
    branchcats.category_type = "C",
    "Minor",
    IF(
      branchcats.category_type = "A",
      "Adult",
      IF(
        branchcats.category_type = "I",
        "Organizational",
        IF(
          branchcats.category_type = "X",
          "Statistical",
          IF(
            branchcats.category_type = "P",
            "Professional",
            IF(
              branchcats.category_type = "S",
              "Staff",
              branchcats.category_type
            )
          )
        )
      )
    )
  ) AS category_type,
  branchcats.description,
  branchcats.categorycode,
  borrowers_total.Count_borrowernumber AS TOTAL,
  borrowers_last_month.Count_borrowernumber AS ADDED_LM,
  If(categories_branches.categorycode IS NULL, "", "Yes") AS STAFF_CAN_CREATE_NEW
FROM
  (
    SELECT
      branches.branchcode,
      categories.category_type,
      categories.categorycode,
      categories.description
    FROM
      categories,
      branches
    GROUP BY
      branches.branchcode,
      categories.category_type,
      categories.categorycode,
      categories.description
    ORDER BY
      branches.branchcode,
      categories.categorycode
  ) branchcats
  LEFT JOIN categories_branches
    ON branchcats.branchcode = categories_branches.branchcode AND
      branchcats.categorycode = categories_branches.categorycode
  LEFT JOIN (
    SELECT
      Count(borrowers.borrowernumber) AS Count_borrowernumber,
      borrowers.branchcode,
      borrowers.categorycode
    FROM
      borrowers
    GROUP BY
      borrowers.branchcode,
      borrowers.categorycode
  ) borrowers_total
    ON branchcats.branchcode = borrowers_total.branchcode AND
      branchcats.categorycode = borrowers_total.categorycode
  LEFT JOIN (
    SELECT
      Count(borrowers.borrowernumber) AS Count_borrowernumber,
      borrowers.branchcode,
      borrowers.categorycode
    FROM
      borrowers
    WHERE
      Month(borrowers.dateenrolled) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(borrowers.dateenrolled) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      borrowers.branchcode,
      borrowers.categorycode
  ) borrowers_last_month
    ON branchcats.branchcode = borrowers_last_month.branchcode AND
      branchcats.categorycode = borrowers_last_month.categorycode
WHERE
  branchcats.branchcode LIKE <<Choose your library|ZBRAN>>
GROUP BY
  branchcats.branchcode,
  branchcats.category_type,
  branchcats.description
ORDER BY
  branchcats.branchcode,
  branchcats.description



