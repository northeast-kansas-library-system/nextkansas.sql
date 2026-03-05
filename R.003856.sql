/*
R.003856

----------

Name: GHW - Circulation + renewal count - previous 5 weeks
Created by: George Williams

----------

Group: -
     -

Created on: 2024-08-28 10:02:47
Modified on: 2024-08-28 10:02:47
Date last run: 2024-09-16 17:30:35

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  'BRANCH_NAME' AS BRANCH_NAME, 
  Concat( 
    'Week of ', 
    Date_Sub(CurDate(), INTERVAL WeekDay(CurDate()) + 1 DAY) - INTERVAL 5 WEEK, 
    ' to ', 
    Date_Sub(CurDate(), INTERVAL WeekDay(CurDate()) - 5 DAY) - INTERVAL 5 WEEK 
  ) AS FIVE_WEEKS_AGO, 
  Concat( 
    'Week of ', 
    Date_Sub(CurDate(), INTERVAL WeekDay(CurDate()) + 1 DAY) - INTERVAL 4 WEEK, 
    ' to ', 
    Date_Sub(CurDate(), INTERVAL WeekDay(CurDate()) - 5 DAY) - INTERVAL 4 WEEK 
  ) AS FOUR_WEEKS_AGO, 
  Concat( 
    'Week of ', 
    Date_Sub(CurDate(), INTERVAL WeekDay(CurDate()) + 1 DAY) - INTERVAL 3 WEEK, 
    ' to ', 
    Date_Sub(CurDate(), INTERVAL WeekDay(CurDate()) - 5 DAY) - INTERVAL 3 WEEK 
  ) AS THREE_WEEKS_AGO, 
  Concat( 
    'Week of ', 
    Date_Sub(CurDate(), INTERVAL WeekDay(CurDate()) + 1 DAY) - INTERVAL 2 WEEK, 
    ' to ', 
    Date_Sub(CurDate(), INTERVAL WeekDay(CurDate()) - 5 DAY) - INTERVAL 2 WEEK 
  ) AS TWO_WEEKS_AGO, 
  Concat( 
    'Week of ', 
    Date_Sub(CurDate(), INTERVAL WeekDay(CurDate()) + 1 DAY) - INTERVAL 1 WEEK, 
    ' to ', 
    Date_Sub(CurDate(), INTERVAL WeekDay(CurDate()) - 5 DAY) - INTERVAL 1 WEEK 
  ) AS ONE_WEEK_AGO 
UNION 
SELECT 
  branches.branchname AS BRANCH_NAME, 
  Coalesce(five.CKO_RENEW_COUNT, 0) AS FIVE_WEEKS_AGO, 
  Coalesce(four.CKO_RENEW_COUNT, 0) AS FOUR_WEEKS_AGO, 
  Coalesce(three.CKO_RENEW_COUNT, 0) AS THREE_WEEKS_AGO, 
  Coalesce(two.CKO_RENEW_COUNT, 0) AS TWO_WEEKS_AGO, 
  Coalesce(one.CKO_RENEW_COUNT, 0) AS ONE_WEEK_AGO 
FROM 
  branches LEFT JOIN 
  ( 
    SELECT 
      statistics.branch, 
      Count(*) AS CKO_RENEW_COUNT 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
        statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 5 WEEK) AND 
      Week(statistics.datetime) = Week(Now() - INTERVAL 5 WEEK) 
    GROUP BY 
      statistics.branch 
  ) five ON five.branch = branches.branchcode LEFT JOIN 
  ( 
    SELECT 
      statistics.branch, 
      Count(*) AS CKO_RENEW_COUNT 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
        statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 4 WEEK) AND 
      Week(statistics.datetime) = Week(Now() - INTERVAL 4 WEEK) 
    GROUP BY 
      statistics.branch 
  ) four ON four.branch = branches.branchcode LEFT JOIN 
  ( 
    SELECT 
      statistics.branch, 
      Count(*) AS CKO_RENEW_COUNT 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
        statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 3 WEEK) AND 
      Week(statistics.datetime) = Week(Now() - INTERVAL 3 WEEK) 
    GROUP BY 
      statistics.branch 
  ) three ON three.branch = branches.branchcode LEFT JOIN 
  ( 
    SELECT 
      statistics.branch, 
      Count(*) AS CKO_RENEW_COUNT 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
        statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 2 WEEK) AND 
      Week(statistics.datetime) = Week(Now() - INTERVAL 2 WEEK) 
    GROUP BY 
      statistics.branch 
  ) two ON two.branch = branches.branchcode LEFT JOIN 
  ( 
    SELECT 
      statistics.branch, 
      Count(*) AS CKO_RENEW_COUNT 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
        statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 WEEK) AND 
      Week(statistics.datetime) = Week(Now() - INTERVAL 1 WEEK) 
    GROUP BY 
      statistics.branch 
  ) one ON one.branch = branches.branchcode 

























