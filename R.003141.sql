/*
R.003141

----------

Name: GHW - Circulation last month by collection code - ADMINREPORT
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-12-10 22:51:22
Modified on: 2018-12-10 22:51:22
Date last run: 2018-12-10 22:53:27

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  branchcodes.branchcode,
  branchcodes.lib,
  statisticsall.COUNT AS TOTAL_CIRC,
  adultstats.COUNT AS ADULT_CIRC,
  juvenilestats.COUNT AS JUVENILE_CIRC,
  yastats.COUNT AS YOUNG_ADULT_CIRC
FROM
  (SELECT
      branches.branchcode,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      branches,
      authorised_values
    WHERE
      authorised_values.category = 'CCODE' AND
      branches.branchcode = <<Choose your library branch|branches>>) branchcodes
  LEFT JOIN (SELECT
      statistics.branch,
      statistics.ccode,
      COUNT(*) AS COUNT
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      statistics.branch,
      statistics.ccode) statisticsall ON statisticsall.branch = branchcodes.branchcode AND
    statisticsall.ccode = branchcodes.authorised_value
  LEFT JOIN (SELECT
      statistics.branch,
      statistics.ccode,
      COUNT(*) AS COUNT
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      (statistics.location = 'ADULT' OR
        statistics.location = 'LVPLADULT' OR
        statistics.location = 'CART' OR
        statistics.location = 'CATALOGING' OR
        statistics.location = 'PROC' OR
        statistics.location IS NULL)
    GROUP BY
      statistics.branch,
      statistics.ccode) adultstats ON adultstats.branch = branchcodes.branchcode AND
    adultstats.ccode = branchcodes.authorised_value
  LEFT JOIN (SELECT
      statistics.branch,
      statistics.ccode,
      COUNT(*) AS COUNT
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      (statistics.location = 'CHILDRENS' OR
        statistics.location = 'LVPLCHILD')
    GROUP BY
      statistics.branch,
      statistics.ccode) juvenilestats ON juvenilestats.branch = branchcodes.branchcode AND
    juvenilestats.ccode = branchcodes.authorised_value
  LEFT JOIN (SELECT
      statistics.branch,
      statistics.ccode,
      COUNT(*) AS COUNT
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      (statistics.location = 'YOUNGADULT' OR
        statistics.location = 'LVPLYA')
    GROUP BY
      statistics.branch,
      statistics.ccode) yastats ON yastats.branch = branchcodes.branchcode AND
    yastats.ccode = branchcodes.authorised_value
ORDER BY
  branchcodes.branchcode,
  branchcodes.lib

























