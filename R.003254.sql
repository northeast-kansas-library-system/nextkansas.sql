/*
R.003254

----------

Name: Report testing - ADMINREPORT
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-08-18 22:03:31
Modified on: 2019-11-14 22:13:42
Date last run: 2019-11-14 22:20:40

----------

Public: 0
Expiry: 300

----------

Testing closure report for Mana

----------
*/



SELECT 
  special_holidays.branchcode AS BRANCH, 
  special_holidays.title AS TITLE, 
  special_holidays.description AS DESCRIPTION, 
  Str_To_Date( 
    Concat( 
      special_holidays.month, '/', special_holidays.day, '/', special_holidays.year 
    ), 
    '%m/%d/%Y' 
  ) AS UPCOMING_DATE, 
  Date_Format( 
    Str_To_Date( 
      Concat(special_holidays.month, '/', special_holidays.day, '/', special_holidays.year), 
      '%m/%d/%Y' 
    ), 
    '%W' 
  ) AS DAY_OF_WEEK, 
  IF(special_holidays.year IS NULL, "X", Concat(special_holidays.year, " only" )) AS REPEATS 
FROM 
  special_holidays 
WHERE 
    (special_holidays.branchcode LIKE @brn:=<<Enter your branch|branches>> COLLATE utf8mb4_unicode_ci) 
  AND 
    Str_To_Date( 
      Concat(special_holidays.month, '/', special_holidays.day, '/', special_holidays.year), '%m/%d/%Y' 
    ) > Now() - INTERVAL 1 DAY 
UNION 
SELECT 
  repeatable_holidays.branchcode AS BRANCH, 
  repeatable_holidays.title AS TITLE, 
  repeatable_holidays.description AS DESCRIPTION, 
  Str_To_Date( 
    Concat( 
      repeatable_holidays.month, 
      '/', 
      repeatable_holidays.day, 
      '/', 
      (If(repeatable_holidays.month >= Month(CurDate()), Year(CurDate()), Year(CurDate()) + 1)) 
    ), 
    '%m/%d/%Y' 
  ) AS UPCOMING_DATE, 
  If(repeatable_holidays.weekday = 0, 'Every Sunday', 
    If(repeatable_holidays.weekday = 1, 'Every Monday', 
      If(repeatable_holidays.weekday = 2, 'Every Tuesday', 
        If(repeatable_holidays.weekday = 3, 'Every Wednesday', 
          If(repeatable_holidays.weekday = 4, 'Every Thursday', 
            If(repeatable_holidays.weekday = 5, 'Every Friday', 
              If(repeatable_holidays.weekday = 6, 'Every Saturday', 
              Date_Format( 
                Str_To_Date( 
                  Concat( 
                    repeatable_holidays.month, 
                    '/', 
                    repeatable_holidays.day, 
                    '/', 
                    (If(repeatable_holidays.month >= Month(CurDate()), Year(CurDate()), Year(CurDate()) + 1)) 
                  ), 
                  '%m/%d/%Y'), 
                  '%W' 
                ) 
              ) 
            ) 
          ) 
        ) 
      ) 
    ) 
  ) AS DAY_OF_WEEK, 
  If(repeatable_holidays.weekday IS NULL, "Repeats annually", "Repeats weekly") AS REPEATS 
FROM 
    repeatable_holidays 
WHERE 
    (repeatable_holidays.branchcode LIKE @brn 
  AND 
    Str_To_Date( 
      Concat( 
        repeatable_holidays.month, 
        '/', 
        repeatable_holidays.day, 
        '/', 
        (If(repeatable_holidays.month >= Month(CurDate()), Year(CurDate()), Year(CurDate()) + 1)) 
      ), 
    '%m/%d/%Y') > Now() - INTERVAL 1 DAY) 
  OR 
    (repeatable_holidays.branchcode LIKE @brn 
  AND 
    Str_To_Date( 
      Concat( 
        repeatable_holidays.month, 
        '/', 
        repeatable_holidays.day, 
        '/', 
        (If(repeatable_holidays.month >= Month(CurDate()), Year(CurDate()), Year(CurDate()) + 1)) 
      ), 
    '%m/%d/%Y') IS NULL) 
ORDER BY 
  BRANCH, 
  UPCOMING_DATE

























