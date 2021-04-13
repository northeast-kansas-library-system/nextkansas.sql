/*
R.003249

----------

Name: GHW - SQL date expressions
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-08-12 23:18:20
Modified on: 2019-09-10 18:45:57
Date last run: 2021-03-16 19:31:32

----------

Public: 0
Expiry: 300

----------

<a href="/cgi-bin/koha/reports/guided_reports.pl?phase=Run+this+report&reports=3249&limit=10000"  target="_blank">Click here to run in a new window</a></p>

----------
*/

SELECT
  "YESTERDAY" AS DESCRIPTION,
  "CurDate() - INTERVAL 1 DAY" AS EXPRESSION,
  CurDate() - INTERVAL 1 DAY AS RESULT
UNION
SELECT
  "TODAY",
  "CurDate()",
  CurDate()
UNION
SELECT
  "TOMORROW",
  "CurDate() + INTERVAL 1 DAY",
  CurDate() + INTERVAL 1 DAY
UNION
SELECT
  "FIRST_DATE_LAST_YEAR",
  "MakeDate(Year(Now()), 1) - INTERVAL 1 YEAR",
  MakeDate(Year(Now()), 1) - INTERVAL 1 YEAR
UNION
SELECT
  "FIRST_DATE_THIS_YEAR",
  "MakeDate(Year(Now()), 1)",
  MakeDate(Year(Now()), 1)
UNION
SELECT
  "FIRST_DATE_NEXT_YEAR",
  "MakeDate(Year(Now()), 1) + INTERVAL 1 YEAR",
  MakeDate(Year(Now()), 1) + INTERVAL 1 YEAR
UNION
SELECT
  "FIRST_DATE_LAST_M",
  "AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1)",
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1)
UNION
SELECT
  "FIRST_DATE_THIS_M",
  "AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1)",
  AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1)
UNION
SELECT
  "FIRST_DATE_NEXT_M",
  "AddDate(Last_Day(SubDate(Now(), INTERVAL -1 MONTH)), 1)",
  AddDate(Last_Day(SubDate(Now(), INTERVAL -1 MONTH)), 1)
UNION
SELECT
  "Y_LAST_Y",
  "Year(Now() - INTERVAL 1 YEAR)",
  Year(Now() - INTERVAL 1 YEAR)
UNION
SELECT
  "Y_THIS_Y",
  "Year(Now())",
  Year(Now())
UNION
SELECT
  "Y_NEXT_Y",
  "Year(Now() + INTERVAL 1 YEAR)",
  Year(Now() + INTERVAL 1 YEAR)
UNION
SELECT
  "Y_LAST_M",
  "Year(Now() - INTERVAL 1 MONTH)",
  Year(Now() - INTERVAL 1 MONTH)
UNION
SELECT
  "Y_THIS_M",
  "Year(Now())",
  Year(Now())
UNION
SELECT
  "Y_NEXT_M",
  "Year(Now() + INTERVAL 1 MONTH)",
  Year(Now() + INTERVAL 1 MONTH)
UNION
SELECT
  "M_LAST_M",
  "Month(Now() - INTERVAL 1 MONTH)",
  Month(Now() - INTERVAL 1 MONTH)
UNION
SELECT
  "M_THIS_M",
  "Month(Now())",
  Month(Now())
UNION
SELECT
  "M_NEXT_M",
  "Month(Now() + INTERVAL 1 MONTH)",
  Month(Now() + INTERVAL 1 MONTH)
UNION
SELECT
  "D_1_YEAR_AGO",
  "CurDate() - INTERVAL 1 YEAR",
  CurDate() - INTERVAL 1 YEAR
UNION
SELECT
  "D_TODAY",
  "CurDate()",
  CurDate()
UNION
SELECT
  "D_1_YEAR_FROM_NOW",
  "CurDate() + INTERVAL 1 YEAR",
  CurDate() + INTERVAL 1 YEAR
UNION
SELECT
  "D_THREE_SUNDAYS_AGO",
  "Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) + 6 DAY) - INTERVAL 2 WEEK",
  Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) + 6 DAY) - INTERVAL 2 WEEK
UNION
SELECT
  "D_TWO_SUNDAYS_AGO",
  "Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) + 6 DAY) - INTERVAL 1 WEEK",
  Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) + 6 DAY) - INTERVAL 1 WEEK
UNION
SELECT
  "D_LAST_SUNDAY",
  "Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) + 6 DAY)",
  Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) + 6 DAY)
UNION
SELECT
  "D_THIS_SUNDAY",
  "Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) - 1 DAY)",
  Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) - 1 DAY)
UNION
SELECT
  "D_NEXT_SUNDAY",
  "Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) - 1 DAY) + INTERVAL 1 WEEK",
  Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) - 1 DAY) + INTERVAL 1 WEEK



