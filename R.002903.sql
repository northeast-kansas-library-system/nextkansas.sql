/*
R.002903

----------

Name: GHW - Patrons added count by category - previous calendar month
Created by: George H Williams

----------

Group: Daily, Monthly, Yearly Stats
     Monthly

Created on: 2017-02-07 15:20:51
Modified on: 2019-02-08 11:12:25
Date last run: 2019-08-19 11:39:49

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Count of patrons added by home library and category code</p>
<ul><li>Counts patrons added in the previous calendar month</li>
<li>at the library you specify</li>
<li>grouped and sorted by home library and category code</li>
<li>includes total for the month at the bottom of the results</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2903&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  BC.branchcode,
  BC.description,
  Coalesce(PADDED.ALM, 0) AS ADDED_LAST_MONTH,
  Coalesce(PRENEWED.RLM, 0) AS RENEWED_LAST_MONTH,
  Coalesce(PDELETED.DLM, 0) AS DELETED_LAST_MONTH,
  Coalesce(PTOTALS.P_TOTAL, 0) AS TOTAL_AT_END_OF_LAST_MONTH
FROM
  (SELECT
      branches.branchcode,
      If(categories.categorycode = "A_ASS", "ASSOCIATE", categories.categorycode) AS categorycode,
      categories.description,
      categories.category_type
    FROM
      branches,
      categories
    GROUP BY
      branches.branchcode,
      categories.description,
      categories.category_type,
      If(categories.categorycode = "A_AAS", "ASSOCIATE", categories.categorycode)) BC
  LEFT JOIN (SELECT
      borrowers.branchcode,
      borrowers.categorycode,
      COUNT(*) AS P_TOTAL
    FROM
      borrowers
    WHERE
      borrowers.dateenrolled < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1)
    GROUP BY
      borrowers.branchcode,
      borrowers.categorycode WITH ROLLUP) PTOTALS ON BC.branchcode = PTOTALS.branchcode AND
    BC.categorycode = PTOTALS.categorycode
  LEFT JOIN (SELECT
      borrowers.branchcode,
      borrowers.categorycode,
      COUNT(*) AS ALM
    FROM
      borrowers
    WHERE
      Month(borrowers.dateenrolled) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(borrowers.dateenrolled) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      borrowers.branchcode,
      borrowers.categorycode WITH ROLLUP) PADDED ON BC.branchcode = PADDED.branchcode AND
    BC.categorycode = PADDED.categorycode
  LEFT JOIN (SELECT
      deletedborrowers.branchcode,
      deletedborrowers.categorycode,
      Count(*) AS DLM
    FROM
      deletedborrowers
    WHERE
      Month(deletedborrowers.updated_on) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(deletedborrowers.updated_on) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      deletedborrowers.branchcode,
      deletedborrowers.categorycode) PDELETED ON BC.branchcode = PDELETED.branchcode AND
    BC.categorycode = PDELETED.categorycode
  LEFT JOIN (SELECT
      borrowers.branchcode,
      borrowers.categorycode,
      Count(*) AS RLM
    FROM
      borrowers
    WHERE
      Month(borrowers.date_renewed) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(borrowers.date_renewed) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      borrowers.branchcode,
      borrowers.categorycode) PRENEWED ON PRENEWED.categorycode = BC.categorycode AND
    PRENEWED.branchcode = BC.branchcode
WHERE
  BC.branchcode LIKE <<Choose your library|LBRANCH>>
GROUP BY
  BC.branchcode,
  BC.description
ORDER BY
  BC.branchcode,
  BC.description



