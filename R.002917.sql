/*
R.002917

----------

Name: GHW - Current Overdues
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2017-03-02 11:03:59
Modified on: 2017-03-02 11:03:59
Date last run: 2020-10-19 15:32:02

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  branches.branchcode AS CHECK_OUT_BRANCH,
  CurDate() - INTERVAL 1 DAY AS YESTERDAY,
  Coalesce(yesterday.count, 0) AS DUE_YESTERDAY,
  CurDate() - INTERVAL 8 DAY AS EIGHT,
  Coalesce(eightdays.count, 0) AS DUE_EIGHT,
  CurDate() - INTERVAL 15 DAY AS FIFTEEN,
  Coalesce(fifteendays.count, 0) AS DUE_FIFTEEN,
  CurDate() - INTERVAL 22 DAY AS TWENTY_TWO,
  Coalesce(twentytwo.count, 0) AS DUE_TWENTYTWO,
  CurDate() - INTERVAL 29 DAY AS TWENTY_NINE,
  Coalesce(twentynine.count, 0) AS DUE_TWENTYNINE
FROM
  (SELECT
    Count(DISTINCT issues.issue_id) AS count,
    issues.branchcode,
    CAST(issues.date_due AS DATE) AS due_yesterday
  FROM
    issues
  WHERE
    CAST(issues.date_due AS DATE) = CurDate() - INTERVAL 1 DAY
  GROUP BY
    issues.branchcode) yesterday RIGHT JOIN
  branches
    ON branches.branchcode = yesterday.branchcode LEFT JOIN
  (SELECT
    Count(DISTINCT issues.issue_id) AS count,
    issues.branchcode,
    CAST(issues.date_due AS DATE) AS due_eight
  FROM
    issues
  WHERE
    CAST(issues.date_due AS DATE) = CurDate() - INTERVAL 8 DAY
  GROUP BY
    issues.branchcode, CAST(issues.date_due AS DATE)) eightdays
    ON branches.branchcode = eightdays.branchcode LEFT JOIN
  (SELECT
    Count(DISTINCT issues.issue_id) AS count,
    issues.branchcode,
    CAST(issues.date_due AS DATE) AS due_fifteen
  FROM
    issues
  WHERE
    CAST(issues.date_due AS DATE) = CurDate() - INTERVAL 15 DAY
  GROUP BY
    issues.branchcode, CAST(issues.date_due AS DATE)) fifteendays
    ON branches.branchcode = fifteendays.branchcode LEFT JOIN
  (SELECT
    Count(DISTINCT issues.issue_id) AS count,
    issues.branchcode,
    CAST(issues.date_due AS DATE) AS due_twentytwo
  FROM
    issues
  WHERE
    CAST(issues.date_due AS DATE) = CurDate() - INTERVAL 22 DAY
  GROUP BY
    issues.branchcode, CAST(issues.date_due AS DATE)) twentytwo
    ON branches.branchcode = twentytwo.branchcode LEFT JOIN
  (SELECT
    Count(DISTINCT issues.issue_id) AS count,
    issues.branchcode,
    CAST(issues.date_due AS DATE) AS due_twentynine
  FROM
    issues
  WHERE
    CAST(issues.date_due AS DATE) = CurDate() - INTERVAL 29 DAY
  GROUP BY
    issues.branchcode, CAST(issues.date_due AS DATE)) twentynine
    ON branches.branchcode = twentynine.branchcode
GROUP BY
  branches.branchcode, Coalesce(yesterday.count, 0), Coalesce(eightdays.count,
  0), Coalesce(fifteendays.count, 0), Coalesce(twentytwo.count, 0),
  Coalesce(twentynine.count, 0)

























