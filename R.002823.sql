/*
R.002823

----------

Name: GHW - Koha Calendar by Branch
Created by: George H Williams

----------

Group: -
     -

Created on: 2016-11-15 09:48:53
Modified on: 2018-12-09 21:25:04
Date last run: 2020-11-17 14:52:43

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT
  special_holidays.branchcode AS BRANCH,
  special_holidays.title AS TITLE,
  special_holidays.description AS DESCRIPTION,
  Str_To_Date(Concat(special_holidays.month, '/', special_holidays.day, '/',
  special_holidays.year), '%m/%d/%Y') AS UPCOMING_DATE,
  Date_Format(Str_To_Date(Concat(special_holidays.month, '/',
  special_holidays.day, '/', special_holidays.year), '%m/%d/%Y'),
  '%W') AS DAY_OF_WEEK,
  special_holidays.year AS REPEATS
FROM
  special_holidays
WHERE
  (special_holidays.branchcode LIKE @brn:=<<Enter your branch|LBRANCH>> COLLATE utf8mb4_unicode_ci) AND
  Str_To_Date(Concat(special_holidays.month, '/', special_holidays.day, '/',
  special_holidays.year), '%m/%d/%Y') > Now() - INTERVAL 1 DAY
UNION
SELECT
  repeatable_holidays.branchcode AS BRANCH,
  repeatable_holidays.title AS TITLE,
  repeatable_holidays.description AS DESCRIPTION,
  Str_To_Date(Concat(repeatable_holidays.month, '/', repeatable_holidays.day,
  '/', (If(repeatable_holidays.month >= Month(CurDate()), Year(CurDate()),
  Year(CurDate()) + 1))), '%m/%d/%Y') AS UPCOMING_DATE,
  If(repeatable_holidays.weekday = 0, 'Every Sunday',
  If(repeatable_holidays.weekday = 1, 'Every Monday',
  If(repeatable_holidays.weekday = 2, 'Every Tuesday',
  If(repeatable_holidays.weekday = 3, 'Every Wednesday',
  If(repeatable_holidays.weekday = 4, 'Every Thursday',
  If(repeatable_holidays.weekday = 5, 'Every Friday',
  If(repeatable_holidays.weekday = 6, 'Every Saturday',
  Date_Format(Str_To_Date(Concat(repeatable_holidays.month, '/',
  repeatable_holidays.day, '/', (If(repeatable_holidays.month >=
  Month(CurDate()), Year(CurDate()), Year(CurDate()) + 1))), '%m/%d/%Y'),
  '%W')))))))) AS DAY_OF_WEEK,
  ('R') AS REPEATS
FROM
  repeatable_holidays
WHERE
  (repeatable_holidays.branchcode LIKE @brn AND
  Str_To_Date(Concat(repeatable_holidays.month, '/', repeatable_holidays.day,
  '/', (If(repeatable_holidays.month >= Month(CurDate()), Year(CurDate()),
  Year(CurDate()) + 1))), '%m/%d/%Y') > Now() - INTERVAL 1 DAY) OR
  (repeatable_holidays.branchcode LIKE @brn AND
  Str_To_Date(Concat(repeatable_holidays.month, '/', repeatable_holidays.day,
  '/', (If(repeatable_holidays.month >= Month(CurDate()), Year(CurDate()),
  Year(CurDate()) + 1))), '%m/%d/%Y') IS NULL)
ORDER BY
  BRANCH,
  UPCOMING_DATE

























