/*
R.003835

----------

Name: GHW - Patron failed login count by patron
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2024-05-30 15:03:15
Modified on: 2024-05-30 15:06:25
Date last run: 2025-03-01 01:51:01

----------

Public: 0
Expiry: 300

----------

Work in progress - this counts by patron - not number of actions. If a borrower fails on their first attempt to log in 10 times, this report only counts them once.

----------
*/



SELECT
  branchess.branchname,
  first.Count_object AS FAIL_FIRST_ATTEMPT_PATRON_COUNT,
  second.Count_object AS SUCCEEDED_ON_SECOND_PATRON_COUNT,
  third.Count_object AS SUCCEEDED_ON_THIRD_PATRON_COUNT,
  fourth.Count_object AS SUCCEEDED_ON_FOURTH_PATRON_COUNT,
  fifth.Count_object AS SUCCEEDED_ON_FIFTH_PATRON_COUNT,
  locked.Count_object AS LOCKED_OUT_PATRON_COUNT
FROM
  (SELECT
      branches.branchname,
      branches.branchcode
    FROM
      branches) branchess LEFT JOIN
  (SELECT
      borrowers.branchcode,
      Count(DISTINCT action_logs.object) AS Count_object
    FROM
      action_logs LEFT JOIN
      borrowers ON borrowers.borrowernumber = action_logs.object
    WHERE
      action_logs.module = 'members' AND
      action_logs.action = 'modify' AND
      action_logs.info LIKE '%login_attempts%' AND
      action_logs.info LIKE '%"before" : "1"%' AND
      action_logs.info LIKE '%"after" : "0"%' AND
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH)
    GROUP BY
      borrowers.branchcode) second ON second.branchcode = branchess.branchcode
  LEFT JOIN
  (SELECT
      borrowers.branchcode,
      Count(DISTINCT action_logs.object) AS Count_object
    FROM
      action_logs LEFT JOIN
      borrowers ON borrowers.borrowernumber = action_logs.object
    WHERE
      action_logs.module = 'members' AND
      action_logs.action = 'modify' AND
      action_logs.info LIKE '%login_attempts%' AND
      action_logs.info LIKE '%"before" : "2"%' AND
      action_logs.info LIKE '%"after" : "0"%' AND
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH)
    GROUP BY
      borrowers.branchcode) third ON third.branchcode = branchess.branchcode
  LEFT JOIN
  (SELECT
      borrowers.branchcode,
      Count(DISTINCT action_logs.object) AS Count_object
    FROM
      action_logs LEFT JOIN
      borrowers ON borrowers.borrowernumber = action_logs.object
    WHERE
      action_logs.module = 'members' AND
      action_logs.action = 'modify' AND
      action_logs.info LIKE '%login_attempts%' AND
      action_logs.info LIKE '%"before" : "3"%' AND
      action_logs.info LIKE '%"after" : "0"%' AND
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH)
    GROUP BY
      borrowers.branchcode) fourth ON fourth.branchcode = branchess.branchcode
  LEFT JOIN
  (SELECT
      borrowers.branchcode,
      Count(DISTINCT action_logs.object) AS Count_object
    FROM
      action_logs LEFT JOIN
      borrowers ON borrowers.borrowernumber = action_logs.object
    WHERE
      action_logs.module = 'members' AND
      action_logs.action = 'modify' AND
      action_logs.info LIKE '%login_attempts%' AND
      action_logs.info LIKE '%"before" : "4"%' AND
      action_logs.info LIKE '%"after" : "0"%' AND
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH)
    GROUP BY
      borrowers.branchcode) fifth ON fifth.branchcode = branchess.branchcode
  LEFT JOIN
  (SELECT
      borrowers.branchcode,
      Count(DISTINCT action_logs.object) AS Count_object
    FROM
      action_logs LEFT JOIN
      borrowers ON borrowers.borrowernumber = action_logs.object
    WHERE
      action_logs.module = 'members' AND
      action_logs.action = 'modify' AND
      action_logs.info LIKE '%login_attempts%' AND
      action_logs.info LIKE '%"before" : "4"%' AND
      action_logs.info LIKE '%"after" : "5"%' AND
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH)
    GROUP BY
      borrowers.branchcode) locked ON locked.branchcode = branchess.branchcode
  LEFT JOIN
  (SELECT
      borrowers.branchcode,
      Count(DISTINCT action_logs.object) AS Count_object
    FROM
      action_logs LEFT JOIN
      borrowers ON borrowers.borrowernumber = action_logs.object
    WHERE
      action_logs.module = 'members' AND
      action_logs.action = 'modify' AND
      action_logs.info LIKE '%login_attempts%' AND
      action_logs.info LIKE '%"before" : "0"%' AND
      action_logs.info LIKE '%"after" : "1"%' AND
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH)
    GROUP BY
      borrowers.branchcode) first ON first.branchcode = branchess.branchcode
GROUP BY
  branchess.branchname

























