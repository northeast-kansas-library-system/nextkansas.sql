/*
R.002963

----------

Name: SQL helper - Date Snippets
Created by: George Williams

----------

Group: Administrative Reports
     Testing

Created on: 2017-06-26 19:16:07
Modified on: 2025-11-11 21:55:55
Date last run: 2026-03-01 21:33:05

----------

Public: 0
Expiry: 300

----------

Reusable code for setting dates in SQL reports

----------
*/



SELECT 
  @1 := 'YESTERDAY'  AS DESCRIPTION, 
  @2 := 'CurDate() - INTERVAL 1 DAY' AS `"SQL"`, 
  CurDate() - INTERVAL 1 DAY AS RESULT 
UNION 
SELECT 
  @1 := 'TODAY', 
  @2 := 'CurDate()', 
  CurDate() 
UNION 
SELECT 
  @1 := 'TOMORROW', 
  @2 := 'CurDate() + INTERVAL 1 DAY', 
  CurDate() + INTERVAL 1 DAY 
UNION 
SELECT 
  @1 := '-', 
  @2 := '-', 
  CONCAT('-') 
UNION 
SELECT 
  @1 := 'FIRST_DATE_LAST_YEAR', 
  @2 := 'MakeDate(Year(Now()), 1) - INTERVAL 1 YEAR', 
  MakeDate(Year(Now()), 1) - INTERVAL 1 YEAR 
UNION 
SELECT 
  @1 := 'FIRST_DATE_THIS_YEAR', 
  @2 := 'MakeDate(Year(Now()), 1)', 
  MakeDate(Year(Now()), 1) 
UNION 
SELECT 
  @1 := 'FIRST_DATE_NEXT_YEAR', 
  @2 := 'MakeDate(Year(Now()), 1) + INTERVAL 1 YEAR', 
  MakeDate(Year(Now()), 1) + INTERVAL 1 YEAR 
UNION 
SELECT 
  @1 := '--', 
  @2 := '--', 
  CONCAT('--') 
UNION 
SELECT 
  @1 := 'FIRST_DATE_LAST_M', 
  @2 := 'AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1)', 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) 
UNION 
SELECT 
  @1 := 'FIRST_DATE_THIS_M', 
  @2 := 'AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1)', 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
UNION 
SELECT 
  @1 := 'FIRST_DATE_NEXT_M', 
  @2 := 'AddDate(Last_Day(SubDate(Now(), INTERVAL 0 MONTH)), 1)', 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 0 MONTH)), 1) 
UNION 
SELECT 
  @1 := '---', 
  @2 := '---', 
  CONCAT('---') 
UNION 
SELECT 
  @1 := 'LAST_DATE_LAST_M', 
  @2 := 'Last_Day(CURRENT_DATE() - INTERVAL 1 MONTH)', 
  Last_Day(CURRENT_DATE() - INTERVAL 1 MONTH)
UNION 
SELECT 
  @1 := 'LAST_DATE_THIS_M', 
  @2 := 'Last_Day(CURRENT_DATE())', 
  Last_Day(CURRENT_DATE()) 
UNION 
SELECT 
  @1 := 'LAST_DATE_NEXT_M', 
  @2 := 'Last_Day(CURRENT_DATE() + INTERVAL 1 MONTH)', 
  Last_Day(CURRENT_DATE() + INTERVAL 1 MONTH) 
UNION 
SELECT 
  @1 := '----', 
  @2 := '----', 
  CONCAT('----') 
UNION 
SELECT 
  @1 := 'Y_LAST_Y', 
  @2 := 'Year(Now() - INTERVAL 1 YEAR)', 
  Year(Now() - INTERVAL 1 YEAR) 
UNION 
SELECT 
  @1 := 'Y_THIS_Y', 
  @2 := 'Year(Now())', 
  Year(Now()) 
UNION 
SELECT 
  @1 := 'Y_NEXT_Y', 
  @2 := 'Year(Now() + INTERVAL 1 YEAR)', 
  Year(Now() + INTERVAL 1 YEAR) 
UNION 
SELECT 
  @1 := '-----', 
  @2 := '-----', 
  CONCAT('-----') 
UNION 
SELECT 
  @1 := 'Y_LAST_M', 
  @2 := 'Year(Now() - INTERVAL 1 MONTH)', 
  Year(Now() - INTERVAL 1 MONTH) 
UNION 
SELECT 
  @1 := 'Y_THIS_M', 
  @2 := 'Year(Now())', 
  Year(Now()) 
UNION 
SELECT 
  @1 := 'Y_NEXT_M', 
  @2 := 'Year(Now() + INTERVAL 1 MONTH)', 
  Year(Now() + INTERVAL 1 MONTH) 
UNION 
SELECT 
  @1 := '------', 
  @2 := '------', 
  CONCAT('------') 
UNION 
SELECT 
  @1 := 'Y_LAST_W', 
  @2 := 'Year(Now() - INTERVAL 1 WEEK)', 
  Year(Now() - INTERVAL 1 WEEK) 
UNION 
SELECT 
  @1 := 'Y_THIS_W', 
  @2 := 'Year(Now())', 
  Year(Now()) 
UNION 
SELECT 
  @1 := 'Y_NEXT_W', 
  @2 := 'Year(Now() + INTERVAL 1 WEEK)', 
  Year(Now() + INTERVAL 1 WEEK) 
UNION 
SELECT 
  @1 := '-------', 
  @2 := '-------', 
  CONCAT('-------') 
UNION 
SELECT 
  @1 := 'M_LAST_M', 
  @2 := 'Month(Now() - INTERVAL 1 MONTH)', 
  Month(Now() - INTERVAL 1 MONTH) 
UNION 
SELECT 
  @1 := 'M_THIS_M', 
  @2 := 'Month(Now())', 
  Month(Now()) 
UNION 
SELECT 
  @1 := 'M_NEXT_M', 
  @2 := 'Month(Now() + INTERVAL 1 MONTH)', 
  Month(Now() + INTERVAL 1 MONTH) 
UNION 
SELECT 
  @1 := '--------', 
  @2 := '--------', 
  CONCAT('--------') 
UNION 
SELECT 
  @1 := 'W_LAST_W', 
  @2 := 'Week(Now() - INTERVAL 1 WEEK)', 
  Week(Now() - INTERVAL 1 WEEK) 
UNION 
SELECT 
  @1 := 'W_THIS_W', 
  @2 := 'Week(Now())', 
  Week(Now()) 
UNION 
SELECT 
  @1 := 'W_NEXT_W', 
  @2 := 'Week(Now() + INTERVAL 1 WEEK)', 
  Week(Now() + INTERVAL 1 WEEK) 
UNION 
SELECT 
  @1 := '---------', 
  @2 := '---------', 
  CONCAT('---------') 
UNION 
SELECT 
  @1 := 'D_1_YEAR_AGO', 
  @2 := 'CurDate() - INTERVAL 1 YEAR', 
  CurDate() - INTERVAL 1 YEAR 
UNION 
SELECT 
  @1 := 'D_TODAY', 
  @2 := 'CurDate()', 
  CurDate() 
UNION 
SELECT 
  @1 := 'D_1_YEAR_FROM_NOW', 
  @2 := 'CurDate() + INTERVAL 1 YEAR', 
  CurDate() + INTERVAL 1 YEAR 
UNION 
SELECT 
  @1 := '----------', 
  @2 := '----------', 
  CONCAT('----------') 
UNION 
SELECT 
  @1 := 'D_TWO_SUNDAYS_AGO', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) +1 DAY) - INTERVAL 2 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) +1 DAY) - INTERVAL 2 WEEK 
UNION 
SELECT 
  @1 := 'D_ONE_SUNDAY_AGO', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) +1 DAY) - INTERVAL 1 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) +1 DAY) - INTERVAL 1 WEEK 
UNION 
SELECT 
  @1 := 'D_SUNDAY_THIS_WEEK', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) +1 DAY)', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) +1 DAY) 
UNION 
SELECT 
  @1 := 'D_ONE_SUNDAY_FROM_NOW', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) +1 DAY) + INTERVAL 1 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) +1 DAY) + INTERVAL 1 WEEK 
UNION 
SELECT 
  @1 := 'D_TWO_SUNDAYS_FROM_NOW', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) +1 DAY) + INTERVAL 2 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) +1 DAY) + INTERVAL 2 WEEK 
UNION 
SELECT 
  @1 := '-----------', 
  @2 := '-----------', 
  CONCAT('-----------') 
UNION 
SELECT 
  @1 := 'D_TWO_MONDAYS_AGO', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) DAY) - INTERVAL 2 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) DAY) - INTERVAL 2 WEEK 
UNION 
SELECT 
  @1 := 'D_ONE_MONDAY_AGO', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) DAY) - INTERVAL 1 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) DAY) - INTERVAL 1 WEEK 
UNION 
SELECT 
  @1 := 'D_MONDAY_THIS_WEEK', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) DAY)', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) DAY) 
UNION 
SELECT 
  @1 := 'D_ONE_MONDAY_FROM_NOW', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) DAY) + INTERVAL 1 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) DAY) + INTERVAL 1 WEEK 
UNION 
SELECT 
  @1 := 'D_TWO_MONDAYS_FROM_NOW', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) DAY) + INTERVAL 2 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) DAY) + INTERVAL 2 WEEK 
UNION 
SELECT 
  @1 := '------------', 
  @2 := '------------', 
  CONCAT('------------') 
UNION 
SELECT 
  @1 := 'D_TWO_TUESDAYS_AGO', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -1 DAY) - INTERVAL 2 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -1 DAY) - INTERVAL 2 WEEK 
UNION 
SELECT 
  @1 := 'D_ONE_TUESDAY_AGO', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -1 DAY) - INTERVAL 1 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -1 DAY) - INTERVAL 1 WEEK 
UNION 
SELECT 
  @1 := 'D_TUESDAY_THIS_WEEK', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -1 DAY)', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -1 DAY) 
UNION 
SELECT 
  @1 := 'D_ONE_TUESDAY_FROM_NOW', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -1 DAY) + INTERVAL 1 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -1 DAY) + INTERVAL 1 WEEK 
UNION 
SELECT 
  @1 := 'D_TWO_TUESDAYS_FROM_NOW', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -1 DAY) + INTERVAL 2 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -1 DAY) + INTERVAL 2 WEEK 
UNION 
SELECT 
  @1 := '-------------', 
  @2 := '-------------', 
  CONCAT('-------------') 
UNION 
SELECT 
  @1 := 'D_TWO_WEDNESDAYS_AGO', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -2 DAY) - INTERVAL 2 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -2 DAY) - INTERVAL 2 WEEK 
UNION 
SELECT 
  @1 := 'D_ONE_WEDNESDAY_AGO', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -2 DAY) - INTERVAL 1 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -2 DAY) - INTERVAL 1 WEEK 
UNION 
SELECT 
  @1 := 'D_WEDNESDAY_THIS_WEEK', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -2 DAY)', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -2 DAY) 
UNION 
SELECT 
  @1 := 'D_ONE_WEDNESDAY_FROM_NOW', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -2 DAY) + INTERVAL 1 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -2 DAY) + INTERVAL 1 WEEK 
UNION 
SELECT 
  @1 := 'D_TWO_WEDNESDAYS_FROM_NOW', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -2 DAY) + INTERVAL 2 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -2 DAY) + INTERVAL 2 WEEK 
UNION 
SELECT 
  @1 := '--------------', 
  @2 := '--------------', 
  CONCAT('--------------') 
UNION 
SELECT 
  @1 := 'D_TWO_THURSDAYS_AGO', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -3 DAY) - INTERVAL 2 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -3 DAY) - INTERVAL 2 WEEK 
UNION 
SELECT 
  @1 := 'D_ONE_THURSDAY_AGO', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -3 DAY) - INTERVAL 1 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -3 DAY) - INTERVAL 1 WEEK 
UNION 
SELECT 
  @1 := 'D_THURSDAY_THIS_WEEK', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -3 DAY)', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -3 DAY) 
UNION 
SELECT 
  @1 := 'D_ONE_THURSDAY_FROM_NOW', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -3 DAY) + INTERVAL 1 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -3 DAY) + INTERVAL 1 WEEK 
UNION 
SELECT 
  @1 := 'D_TWO_THURSDAYS_FROM_NOW', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -3 DAY) + INTERVAL 2 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -3 DAY) + INTERVAL 2 WEEK 
UNION 
SELECT 
  @1 := '---------------', 
  @2 := '---------------', 
  CONCAT('---------------') 
UNION 
SELECT 
  @1 := 'D_TWO_FRIDAYS_AGO', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -4 DAY) - INTERVAL 2 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -4 DAY) - INTERVAL 2 WEEK 
UNION 
SELECT 
  @1 := 'D_ONE_FRIDAY_AGO', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -4 DAY) - INTERVAL 1 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -4 DAY) - INTERVAL 1 WEEK 
UNION 
SELECT 
  @1 := 'D_FRIDAY_THIS_WEEK', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -4 DAY)', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -4 DAY) 
UNION 
SELECT 
  @1 := 'D_ONE_FRIDAY_FROM_NOW', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -4 DAY) + INTERVAL 1 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -4 DAY) + INTERVAL 1 WEEK 
UNION 
SELECT 
  @1 := 'D_TWO_FRIDAYS_FROM_NOW', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -4 DAY) + INTERVAL 2 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -4 DAY) + INTERVAL 2 WEEK 
UNION 
SELECT 
  @1 := '----------------', 
  @2 := '----------------', 
  CONCAT('----------------') 
UNION 
SELECT 
  @1 := 'D_TWO_SATURDAYS_AGO', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -5 DAY) - INTERVAL 2 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -5 DAY) - INTERVAL 2 WEEK 
UNION 
SELECT 
  @1 := 'D_ONE_SATURDAY_AGO', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -5 DAY) - INTERVAL 1 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -5 DAY) - INTERVAL 1 WEEK 
UNION 
SELECT 
  @1 := 'D_SATURDAY_THIS_WEEK', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -5 DAY)', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -5 DAY) 
UNION 
SELECT 
  @1 := 'D_ONE_SATURDAY_FROM_NOW', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -5 DAY) + INTERVAL 1 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -5 DAY) + INTERVAL 1 WEEK 
UNION 
SELECT 
  @1 := 'D_TWO_SATURDAYS_FROM_NOW', 
  @2 := 'Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -5 DAY) + INTERVAL 2 WEEK', 
  Date_Sub(Curdate(), INTERVAL Weekday(Curdate()) -5 DAY) + INTERVAL 2 WEEK 
LIMIT 500 

























