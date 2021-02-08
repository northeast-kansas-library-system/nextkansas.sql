/*
R.003419

----------

Name: GHW - Monthly 9902 - Circulation
Created by: George H Williams

----------

Group: Statistics
     Monthly Statistics

Created on: 2021-02-04 16:59:13
Modified on: 2021-02-04 17:03:07
Date last run: 2021-02-06 22:25:37

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  branches.branchcode,
  Coalesce(CIR_RENEW_LM.count, 0) AS CHECKOUT_RENEW_LM,
  Coalesce(CKO_LM.count, 0) AS CHECKOUT_LM,
  Coalesce(RENEW_LM.count, 0) AS RENEW_LM,
  Coalesce(RETURN_LM.count, 0) AS RETURN_LM,
  Coalesce(ADULT.count, 0) AS CR_ADULT_LM,
  Coalesce(YOUTH.count, 0) AS CR_YOUTH_LM,
  Coalesce(DVD_CIRC_RENEW_LM.count, 0) AS CR_VIDEO_DISC_LM
FROM
  branches LEFT JOIN
  (SELECT
      statistics.branch,
      Count(*) AS count
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
          statistics.type = 'renew') AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      statistics.branch) CIR_RENEW_LM ON branches.branchcode =
      CIR_RENEW_LM.branch LEFT JOIN
  (SELECT
      statistics.branch,
      Count(*) AS count
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
          statistics.type = 'renew') AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      (statistics.location LIKE "%ADULT%" AND
          statistics.location NOT LIKE "%YOUNG%" OR
          statistics.location IS NULL)
    GROUP BY
      statistics.branch) ADULT ON branches.branchcode = ADULT.branch LEFT JOIN
  (SELECT
      statistics.branch,
      Count(*) AS count
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
          statistics.type = 'renew') AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      statistics.location NOT LIKE "ADULT" AND
      statistics.location NOT LIKE "BALDADULT" AND
      statistics.location NOT LIKE "LVPLADULT" AND
      statistics.location NOT LIKE "PAOLAADULT"
    GROUP BY
      statistics.branch) YOUTH ON branches.branchcode = YOUTH.branch LEFT JOIN
  (SELECT
      statistics.branch,
      Count(*) AS count
    FROM
      statistics
    WHERE
      statistics.type = 'issue' AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      statistics.branch) CKO_LM ON CKO_LM.branch = branches.branchcode LEFT JOIN
  (SELECT
      statistics.branch,
      Count(*) AS count
    FROM
      statistics
    WHERE
      statistics.type = 'renew' AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      statistics.branch) RENEW_LM ON RENEW_LM.branch = branches.branchcode
  LEFT JOIN
  (SELECT
      statistics.branch,
      Count(*) AS count
    FROM
      statistics
    WHERE
      statistics.type = 'return' AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      statistics.branch) RETURN_LM ON RETURN_LM.branch = branches.branchcode
  LEFT JOIN
  (SELECT
      statistics.branch,
      Count(*) AS count
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
          statistics.type = 'renew') AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      statistics.itemtype LIKE "NVID%" AND
      (statistics.ccode LIKE "DVD" OR
          statistics.ccode LIKE "BLU-RAY" OR
          statistics.ccode LIKE "COMBO" OR
          statistics.ccode LIKE "TVSERIES")
    GROUP BY
      statistics.branch) DVD_CIRC_RENEW_LM ON DVD_CIRC_RENEW_LM.branch =
      branches.branchcode
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode



