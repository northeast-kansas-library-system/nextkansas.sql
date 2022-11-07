/*
R.003660

----------

Name: GHW - Unique borrowers in each of the previous 12 months
Created by: George H Williams

----------

Group: Statistics
     2022 beginning of month statistics

Created on: 2022-04-18 22:01:38
Modified on: 2022-04-18 22:20:08
Date last run: 2022-11-01 01:15:02

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  branchess.branchname,
  m_01.count AS M_01,
  m_02.count AS M_02,
  m_03.count AS M_03,
  m_04.count AS M_04,
  m_05.count AS M_05,
  m_06.count AS M_06,
  m_07.count AS M_07,
  m_08.count AS M_08,
  m_09.count AS M_09,
  m_10.count AS M_10,
  m_11.count AS M_11,
  m_12.count AS M_12,
  m_year.count AS LAST_12
FROM
    (SELECT
      branches.branchname,
      branches.branchcode
    FROM
      branches
    UNION
    SELECT
      '- Date range -' AS branchname,
      '-' AS branchcode) branchess LEFT JOIN
    (SELECT
      Concat('-') AS branch,
      Concat(
        Year(Now() - INTERVAL 1 MONTH),
        '-',
        LPad(Month(Now() - INTERVAL 1 MONTH), 2, 0),
        ' (',
        Date_Format(Now() - INTERVAL 1 MONTH, '%M'), 
        ')'
      ) AS count
    UNION
    SELECT
      statistics.branch,
      Coalesce(Count(DISTINCT statistics.borrowernumber), 0) AS count
    FROM
      statistics
    WHERE
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      (statistics.type = 'issue' OR
      statistics.type = 'renew')
    GROUP BY
      statistics.branch) m_01 ON m_01.branch = branchess.branchcode LEFT JOIN
    (SELECT
      Concat('-') AS branch,
      Concat(
        Year(Now() - INTERVAL 2 MONTH),
        '-',
        LPad(Month(Now() - INTERVAL 2 MONTH), 2, 0),
        ' (',
        Date_Format(Now() - INTERVAL 2 MONTH, '%M'), 
        ')'
      ) AS count
    UNION
    SELECT
      statistics.branch,
      Coalesce(Count(DISTINCT statistics.borrowernumber), 0) AS count
    FROM
      statistics
    WHERE
      Year(statistics.datetime) = Year(Now() - INTERVAL 2 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 2 MONTH) AND
      (statistics.type = 'issue' OR
      statistics.type = 'renew')
    GROUP BY
      statistics.branch) m_02 ON m_02.branch = branchess.branchcode LEFT JOIN
    (SELECT
      Concat('-') AS branch,
      Concat(
        Year(Now() - INTERVAL 3 MONTH),
        '-',
        LPad(Month(Now() - INTERVAL 3 MONTH), 2, 0),
        ' (',
        Date_Format(Now() - INTERVAL 3 MONTH, '%M'), 
        ')'
      ) AS count
    UNION
    SELECT
      statistics.branch,
      Coalesce(Count(DISTINCT statistics.borrowernumber), 0) AS count
    FROM
      statistics
    WHERE
      Year(statistics.datetime) = Year(Now() - INTERVAL 3 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 3 MONTH) AND
      (statistics.type = 'issue' OR
      statistics.type = 'renew')
    GROUP BY
      statistics.branch) m_03 ON m_03.branch = branchess.branchcode LEFT JOIN
    (SELECT
      Concat('-') AS branch,
      Concat(
        Year(Now() - INTERVAL 4 MONTH),
        '-',
        LPad(Month(Now() - INTERVAL 4 MONTH), 2, 0),
        ' (',
        Date_Format(Now() - INTERVAL 4 MONTH, '%M'), 
        ')'
      ) AS count
    UNION
    SELECT
      statistics.branch,
      Coalesce(Count(DISTINCT statistics.borrowernumber), 0) AS count
    FROM
      statistics
    WHERE
      Year(statistics.datetime) = Year(Now() - INTERVAL 4 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 4 MONTH) AND
      (statistics.type = 'issue' OR
      statistics.type = 'renew')
    GROUP BY
      statistics.branch) m_04 ON m_04.branch = branchess.branchcode LEFT JOIN
    (SELECT
      Concat('-') AS branch,
      Concat(
        Year(Now() - INTERVAL 5 MONTH),
        '-',
        LPad(Month(Now() - INTERVAL 5 MONTH), 2, 0),
        ' (',
        Date_Format(Now() - INTERVAL 5 MONTH, '%M'), 
        ')'
      ) AS count
    UNION
    SELECT
      statistics.branch,
      Coalesce(Count(DISTINCT statistics.borrowernumber), 0) AS count
    FROM
      statistics
    WHERE
      Year(statistics.datetime) = Year(Now() - INTERVAL 5 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 5 MONTH) AND
      (statistics.type = 'issue' OR
      statistics.type = 'renew')
    GROUP BY
      statistics.branch) m_05 ON m_05.branch = branchess.branchcode LEFT JOIN
    (SELECT
      Concat('-') AS branch,
      Concat(
        Year(Now() - INTERVAL 6 MONTH),
        '-',
        LPad(Month(Now() - INTERVAL 6 MONTH), 2, 0),
        ' (',
        Date_Format(Now() - INTERVAL 6 MONTH, '%M'), 
        ')'
      ) AS count
    UNION
    SELECT
      statistics.branch,
      Coalesce(Count(DISTINCT statistics.borrowernumber), 0) AS count
    FROM
      statistics
    WHERE
      Year(statistics.datetime) = Year(Now() - INTERVAL 6 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 6 MONTH) AND
      (statistics.type = 'issue' OR
      statistics.type = 'renew')
    GROUP BY
      statistics.branch) m_06 ON m_06.branch = branchess.branchcode LEFT JOIN
    (SELECT
      Concat('-') AS branch,
      Concat(
        Year(Now() - INTERVAL 7 MONTH),
        '-',
        LPad(Month(Now() - INTERVAL 7 MONTH), 2, 0),
        ' (',
        Date_Format(Now() - INTERVAL 7 MONTH, '%M'), 
        ')'
      ) AS count
    UNION
    SELECT
      statistics.branch,
      Coalesce(Count(DISTINCT statistics.borrowernumber), 0) AS count
    FROM
      statistics
    WHERE
      Year(statistics.datetime) = Year(Now() - INTERVAL 7 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 7 MONTH) AND
      (statistics.type = 'issue' OR
      statistics.type = 'renew')
    GROUP BY
      statistics.branch) m_07 ON m_07.branch = branchess.branchcode LEFT JOIN
    (SELECT
      Concat('-') AS branch,
      Concat(
        Year(Now() - INTERVAL 8 MONTH),
        '-',
        LPad(Month(Now() - INTERVAL 8 MONTH), 2, 0),
        ' (',
        Date_Format(Now() - INTERVAL 8 MONTH, '%M'), 
        ')'
      ) AS count
    UNION
    SELECT
      statistics.branch,
      Coalesce(Count(DISTINCT statistics.borrowernumber), 0) AS count
    FROM
      statistics
    WHERE
      Year(statistics.datetime) = Year(Now() - INTERVAL 8 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 8 MONTH) AND
      (statistics.type = 'issue' OR
      statistics.type = 'renew')
    GROUP BY
      statistics.branch) m_08 ON m_08.branch = branchess.branchcode LEFT JOIN
    (SELECT
      Concat('-') AS branch,
      Concat(
        Year(Now() - INTERVAL 9 MONTH),
        '-',
        LPad(Month(Now() - INTERVAL 9 MONTH), 2, 0),
        ' (',
        Date_Format(Now() - INTERVAL 9 MONTH, '%M'), 
        ')'
      ) AS count
    UNION
    SELECT
      statistics.branch,
      Coalesce(Count(DISTINCT statistics.borrowernumber), 0) AS count
    FROM
      statistics
    WHERE
      Year(statistics.datetime) = Year(Now() - INTERVAL 9 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 9 MONTH) AND
      (statistics.type = 'issue' OR
      statistics.type = 'renew')
    GROUP BY
      statistics.branch) m_09 ON m_09.branch = branchess.branchcode LEFT JOIN
    (SELECT
      Concat('-') AS branch,
      Concat(
        Year(Now() - INTERVAL 10 MONTH),
        '-',
        LPad(Month(Now() - INTERVAL 10 MONTH), 2, 0),
        ' (',
        Date_Format(Now() - INTERVAL 10 MONTH, '%M'), 
        ')'
      ) AS count
    UNION
    SELECT
      statistics.branch,
      Coalesce(Count(DISTINCT statistics.borrowernumber), 0) AS count
    FROM
      statistics
    WHERE
      Year(statistics.datetime) = Year(Now() - INTERVAL 10 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 10 MONTH) AND
      (statistics.type = 'issue' OR
      statistics.type = 'renew')
    GROUP BY
      statistics.branch) m_10 ON m_10.branch = branchess.branchcode LEFT JOIN
    (SELECT
      Concat('-') AS branch,
      Concat(
        Year(Now() - INTERVAL 11 MONTH),
        '-', 
       
        LPad(Month(Now() - INTERVAL 11 MONTH), 2, 0), 
       
        ' (', 
        Date_Format(Now() - INTERVAL 11 MONTH, '%M'), 
        
        ')'
      ) AS count
    UNION
    SELECT
      statistics.branch,
      Coalesce(Count(DISTINCT statistics.borrowernumber), 0) AS count
    FROM
      statistics
    WHERE
      Year(statistics.datetime) = Year(Now() - INTERVAL 11 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 11 MONTH) AND
      (statistics.type = 'issue' OR
      statistics.type = 'renew')
    GROUP BY
      statistics.branch) m_11 ON m_11.branch = branchess.branchcode LEFT JOIN
    (SELECT
      Concat('-') AS branch,
      Concat(
        Year(Now() - INTERVAL 12 MONTH),
        '-',
        LPad(Month(Now() - INTERVAL 12 MONTH), 2, 0),
        ' (',
        Date_Format(Now() - INTERVAL 12 MONTH, '%M'), 
        ')'
      ) AS count
    UNION
    SELECT
      statistics.branch,
      Coalesce(Count(DISTINCT statistics.borrowernumber), 0) AS count
    FROM
      statistics
    WHERE
      Year(statistics.datetime) = Year(Now() - INTERVAL 12 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 12 MONTH) AND
      (statistics.type = 'issue' OR
      statistics.type = 'renew')
    GROUP BY
      statistics.branch) m_12 ON m_12.branch = branchess.branchcode LEFT JOIN
    (SELECT
      Concat('-') AS branch,
      Concat('Previous 12 calendar months') AS count
    UNION
    SELECT
      statistics.branch,
      Coalesce(Count(DISTINCT statistics.borrowernumber), 0) AS count
    FROM
      statistics
    WHERE
      statistics.datetime 
        BETWEEN
          AddDate(Last_Day(SubDate(Now(), INTERVAL 14 MONTH)), 1) AND 
          AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1)
        AND
      (statistics.type = 'issue' OR
      statistics.type = 'renew')
    GROUP BY
      statistics.branch) m_year ON m_year.branch = branchess.branchcode
ORDER BY
  branchess.branchname

























