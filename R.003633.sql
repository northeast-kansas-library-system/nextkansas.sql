/*
R.003633

----------

Name: GHW - Statistics - Daily overdue count for prevous calendar month
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-12-29 18:20:10
Modified on: 2021-12-30 15:19:37
Date last run: 2022-12-13 17:03:09

----------

Public: 0
Expiry: 300

----------

Counts the number of items that were overdue at the beginning of each day of the previous calendar month

----------
*/



SELECT
  branches.branchname,
  aa.Sum_Count_issue_id AS `01`,
  ab.Sum_Count_issue_id AS `02`,
  ac.Sum_Count_issue_id AS `03`,
  ad.Sum_Count_issue_id AS `04`,
  ae.Sum_Count_issue_id AS `05`,
  af.Sum_Count_issue_id AS `06`,
  ag.Sum_Count_issue_id AS `07`,
  ah.Sum_Count_issue_id AS `08`,
  ai.Sum_Count_issue_id AS `09`,
  aj.Sum_Count_issue_id AS `10`,
  ba.Sum_Count_issue_id AS `11`,
  bb.Sum_Count_issue_id AS `12`,
  bc.Sum_Count_issue_id AS `13`,
  bd.Sum_Count_issue_id AS `14`,
  be.Sum_Count_issue_id AS `15`,
  bf.Sum_Count_issue_id AS `16`,
  bg.Sum_Count_issue_id AS `17`,
  bh.Sum_Count_issue_id AS `18`,
  bi.Sum_Count_issue_id AS `19`,
  bj.Sum_Count_issue_id AS `20`,
  ca.Sum_Count_issue_id AS `21`,
  cb.Sum_Count_issue_id AS `22`,
  cc.Sum_Count_issue_id AS `23`,
  cd.Sum_Count_issue_id AS `24`,
  ce.Sum_Count_issue_id AS `25`,
  cf.Sum_Count_issue_id AS `26`,
  cg.Sum_Count_issue_id AS `27`,
  ch.Sum_Count_issue_id AS `28`,
  ci.Sum_Count_issue_id AS `29`,
  cj.Sum_Count_issue_id AS `30`,
  da.Sum_Count_issue_id AS `31`
FROM
  branches LEFT JOIN
  (SELECT
      aacounts.branchcode,
      Sum(DISTINCT aacounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1)
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1)
        GROUP BY
          old_issues.branchcode) aacounts
    GROUP BY
      aacounts.branchcode) aa ON aa.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      abcounts.branchcode,
      Sum(DISTINCT abcounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 1 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 1 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 1 DAY
        GROUP BY
          old_issues.branchcode) abcounts
    GROUP BY
      abcounts.branchcode) ab ON ab.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      accounts.branchcode,
      Sum(DISTINCT accounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 2 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 2 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 2 DAY
        GROUP BY
          old_issues.branchcode) accounts
    GROUP BY
      accounts.branchcode) ac ON ac.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      adcounts.branchcode,
      Sum(DISTINCT adcounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 3 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 3 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 3 DAY
        GROUP BY
          old_issues.branchcode) adcounts
    GROUP BY
      adcounts.branchcode) ad ON ad.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      aecounts.branchcode,
      Sum(DISTINCT aecounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 4 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 4 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 4 DAY
        GROUP BY
          old_issues.branchcode) aecounts
    GROUP BY
      aecounts.branchcode) ae ON ae.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      afcounts.branchcode,
      Sum(DISTINCT afcounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 5 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 5 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 5 DAY
        GROUP BY
          old_issues.branchcode) afcounts
    GROUP BY
      afcounts.branchcode) af ON af.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      agcounts.branchcode,
      Sum(DISTINCT agcounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 6 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 6 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 6 DAY
        GROUP BY
          old_issues.branchcode) agcounts
    GROUP BY
      agcounts.branchcode) ag ON ag.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      ahcounts.branchcode,
      Sum(DISTINCT ahcounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 7 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 7 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 7 DAY
        GROUP BY
          old_issues.branchcode) ahcounts
    GROUP BY
      ahcounts.branchcode) ah ON ah.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      aicounts.branchcode,
      Sum(DISTINCT aicounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 8 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 8 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 8 DAY
        GROUP BY
          old_issues.branchcode) aicounts
    GROUP BY
      aicounts.branchcode) ai ON ai.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      ajcounts.branchcode,
      Sum(DISTINCT ajcounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 9 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 9 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 9 DAY
        GROUP BY
          old_issues.branchcode) ajcounts
    GROUP BY
      ajcounts.branchcode) aj ON aj.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      bacounts.branchcode,
      Sum(DISTINCT bacounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 10 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 10 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 10 DAY
        GROUP BY
          old_issues.branchcode) bacounts
    GROUP BY
      bacounts.branchcode) ba ON ba.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      bbcounts.branchcode,
      Sum(DISTINCT bbcounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 11 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 11 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 11 DAY
        GROUP BY
          old_issues.branchcode) bbcounts
    GROUP BY
      bbcounts.branchcode) bb ON bb.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      bccounts.branchcode,
      Sum(DISTINCT bccounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 12 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 12 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 12 DAY
        GROUP BY
          old_issues.branchcode) bccounts
    GROUP BY
      bccounts.branchcode) bc ON bc.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      bdcounts.branchcode,
      Sum(DISTINCT bdcounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 13 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 13 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 13 DAY
        GROUP BY
          old_issues.branchcode) bdcounts
    GROUP BY
      bdcounts.branchcode) bd ON bd.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      becounts.branchcode,
      Sum(DISTINCT becounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 14 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 14 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 14 DAY
        GROUP BY
          old_issues.branchcode) becounts
    GROUP BY
      becounts.branchcode) be ON be.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      bfcounts.branchcode,
      Sum(DISTINCT bfcounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 15 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 15 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 15 DAY
        GROUP BY
          old_issues.branchcode) bfcounts
    GROUP BY
      bfcounts.branchcode) bf ON bf.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      bgcounts.branchcode,
      Sum(DISTINCT bgcounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 16 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 16 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 16 DAY
        GROUP BY
          old_issues.branchcode) bgcounts
    GROUP BY
      bgcounts.branchcode) bg ON bg.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      bhcounts.branchcode,
      Sum(DISTINCT bhcounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 17 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 17 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 17 DAY
        GROUP BY
          old_issues.branchcode) bhcounts
    GROUP BY
      bhcounts.branchcode) bh ON bh.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      bicounts.branchcode,
      Sum(DISTINCT bicounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 18 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 18 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 18 DAY
        GROUP BY
          old_issues.branchcode) bicounts
    GROUP BY
      bicounts.branchcode) bi ON bi.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      bjcounts.branchcode,
      Sum(DISTINCT bjcounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 19 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 19 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 19 DAY
        GROUP BY
          old_issues.branchcode) bjcounts
    GROUP BY
      bjcounts.branchcode) bj ON bj.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      cacounts.branchcode,
      Sum(DISTINCT cacounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 20 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 20 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 20 DAY
        GROUP BY
          old_issues.branchcode) cacounts
    GROUP BY
      cacounts.branchcode) ca ON ca.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      cbcounts.branchcode,
      Sum(DISTINCT cbcounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 21 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 21 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 21 DAY
        GROUP BY
          old_issues.branchcode) cbcounts
    GROUP BY
      cbcounts.branchcode) cb ON cb.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      cccounts.branchcode,
      Sum(DISTINCT cccounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 22 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 22 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 22 DAY
        GROUP BY
          old_issues.branchcode) cccounts
    GROUP BY
      cccounts.branchcode) cc ON cc.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      cdcounts.branchcode,
      Sum(DISTINCT cdcounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 23 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 23 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 23 DAY
        GROUP BY
          old_issues.branchcode) cdcounts
    GROUP BY
      cdcounts.branchcode) cd ON cd.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      cecounts.branchcode,
      Sum(DISTINCT cecounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 24 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 24 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 24 DAY
        GROUP BY
          old_issues.branchcode) cecounts
    GROUP BY
      cecounts.branchcode) ce ON ce.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      cfcounts.branchcode,
      Sum(DISTINCT cfcounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 25 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 25 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 25 DAY
        GROUP BY
          old_issues.branchcode) cfcounts
    GROUP BY
      cfcounts.branchcode) cf ON cf.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      cgcounts.branchcode,
      Sum(DISTINCT cgcounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 26 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 26 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 26 DAY
        GROUP BY
          old_issues.branchcode) cgcounts
    GROUP BY
      cgcounts.branchcode) cg ON cg.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      chcounts.branchcode,
      Sum(DISTINCT chcounts.Count_issue_id) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 27 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 27 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 27 DAY
        GROUP BY
          old_issues.branchcode) chcounts
    GROUP BY
      chcounts.branchcode) ch ON ch.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      cicounts.branchcode,
      IF(
        Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 28 DAY) = Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1)), 
        Sum(DISTINCT cicounts.Count_issue_id), 
        '-'
      ) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 28 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 28 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 28 DAY
        GROUP BY
          old_issues.branchcode) cicounts
    GROUP BY
      cicounts.branchcode) ci ON ci.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      cjcounts.branchcode,
      If(
        Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 29 DAY) = Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1)), 
        Sum(DISTINCT cjcounts.Count_issue_id), 
        '-'
      ) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 29 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 29 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 29 DAY
        GROUP BY
          old_issues.branchcode) cjcounts
    GROUP BY
      cjcounts.branchcode) cj ON cj.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      dacounts.branchcode,
      If(
        Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 30 DAY) = Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1)), 
        Sum(DISTINCT dacounts.Count_issue_id), 
        '-'
      ) AS Sum_Count_issue_id
    FROM
      (SELECT
          issues.branchcode,
          Count(DISTINCT issues.issue_id) AS Count_issue_id
        FROM
          issues
        WHERE
          issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 30 DAY
        GROUP BY
          issues.branchcode
        UNION
        SELECT
          old_issues.branchcode,
          Count(DISTINCT old_issues.issue_id) AS Count_issue_id
        FROM
          old_issues
        WHERE
          old_issues.date_due <= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 30 DAY AND
          old_issues.returndate > AddDate(Last_Day(SubDate(Now(), INTERVAL 2 Month)), 1) + INTERVAL 30 DAY
        GROUP BY
          old_issues.branchcode) dacounts
    GROUP BY
      dacounts.branchcode) da ON da.branchcode = branches.branchcode
GROUP BY
  branches.branchname
UNION  
  SELECT  
    Concat(" DATE") AS branchname,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) AS `01`,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 1 DAY AS `02`,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 2 DAY AS `03`,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 3 DAY AS `04`,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 4 DAY AS `05`,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 5 DAY AS `06`,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 6 DAY AS `07`,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 7 DAY AS `08`,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 8 DAY AS `09`,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 9 DAY AS `10`,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 10 DAY AS `11`,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 11 DAY AS `12`,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 12 DAY AS `13`,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 13 DAY AS `14`,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 14 DAY AS `15`,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 15 DAY AS `16`,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 16 DAY AS `17`,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 17 DAY AS `18`,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 18 DAY AS `19`,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 19 DAY AS `20`,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 20 DAY AS `21`,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 21 DAY AS `22`,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 22 DAY AS `23`,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 23 DAY AS `24`,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 24 DAY AS `25`,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 25 DAY AS `26`,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 26 DAY AS `27`,  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 27 DAY AS `28`,  
    If(  
      Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 28 DAY) = Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1)),  
      AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 28 DAY,  
      "NA"  
    ) AS `29`,  
    If(  
      Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 29 DAY) = Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1)),  
      AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 29 DAY,  
      "NA"  
    ) AS `30`,  
    If(  
      Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 30 DAY) = Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1)),  
      AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 30 DAY,  
      "NA"  
    ) AS `31` 
UNION  
  SELECT  
    Concat(" DAY") AS branchname,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1), "%W") AS `01`,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 1 DAY, "%W") AS `02`,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 2 DAY, "%W") AS `03`,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 3 DAY, "%W") AS `04`,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 4 DAY, "%W") AS `05`,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 5 DAY, "%W") AS `06`,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 6 DAY, "%W") AS `07`,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 7 DAY, "%W") AS `08`,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 8 DAY, "%W") AS `09`,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 9 DAY, "%W") AS `10`,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 10 DAY, "%W") AS `11`,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 11 DAY, "%W") AS `12`,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 12 DAY, "%W") AS `13`,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 13 DAY, "%W") AS `14`,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 14 DAY, "%W") AS `15`,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 15 DAY, "%W") AS `16`,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 16 DAY, "%W") AS `17`,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 17 DAY, "%W") AS `18`,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 18 DAY, "%W") AS `19`,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 19 DAY, "%W") AS `20`,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 20 DAY, "%W") AS `21`,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 21 DAY, "%W") AS `22`,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 22 DAY, "%W") AS `23`,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 23 DAY, "%W") AS `24`,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 24 DAY, "%W") AS `25`,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 25 DAY, "%W") AS `26`,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 26 DAY, "%W") AS `27`,  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 27 DAY, "%W") AS `28`,  
    If(  
      Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 28 DAY) = Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1)),  
      Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 28 DAY, "%W"),  
      "NA"  
    ) AS `29`,  
    If(  
      Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 29 DAY) = Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1)),  
      Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 29 DAY, "%W"),  
      "NA"  
    ) AS `30`,  
    If(  
      Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 30 DAY) = Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1)),  
      Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 30 DAY, "%W"),  
      "NA"  
    ) AS `31`  
ORDER BY  
  branchname





















