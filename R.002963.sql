/*
R.002963

----------

Name: SQL helper - Date Snippets
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2017-06-26 19:16:07
Modified on: 2020-10-09 00:57:04
Date last run: 2021-01-17 16:33:09

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
  CurDate() - INTERVAL 1 DAY  
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
  @2 := 'Last_Day(CURRENT_DATE()) - INTERVAL 1 MONTH',  
  Last_Day(CURRENT_DATE()) - INTERVAL 1 MONTH  
UNION  
SELECT  
  @1 := 'LAST_DATE_THIS_M',  
  @2 := 'Last_Day(CURRENT_DATE())',  
  Last_Day(CURRENT_DATE())  
UNION  
SELECT  
  @1 := 'LAST_DATE_NEXT_M',  
  @2 := 'Last_Day(CURRENT_DATE()) + INTERVAL 1 MONTH',  
  Last_Day(CURRENT_DATE()) + INTERVAL 1 MONTH  
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
  @1 := '-------',  
  @2 := '-------',  
  CONCAT('-------')  
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
  @1 := '--------',  
  @2 := '--------',  
  CONCAT('--------')  
UNION  
SELECT  
  @1 := 'D_TWO_SUNDAYS_AGO',  
  @2 := 'Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) + 6 DAY) - INTERVAL 1 WEEK',  
  Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) + 6 DAY) - INTERVAL 1 WEEK  
UNION  
SELECT  
  @1 := 'D_LAST_SUNDAY',  
  @2 := 'Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) + 6 DAY)',  
  Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) + 6 DAY)  
UNION  
SELECT  
  @1 := 'D_THIS_SUNDAY',  
  @2 := 'Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) - 1 DAY)',  
  Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) - 1 DAY)  
UNION  
SELECT  
  @1 := 'D_NEXT_SUNDAY',  
  @2 := 'Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) - 1 DAY) + INTERVAL 1 WEEK',  
  Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) - 1 DAY) + INTERVAL 1 WEEK
UNION  
SELECT  
  @1 := '---------',  
  @2 := '---------',  
  CONCAT('---------')  
UNION  
SELECT  
  @1 := 'D_TWO_SATURDAYS_AGO',  
  @2 := 'Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) + 7 DAY)',  
  Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) + 7 DAY)  
UNION  
SELECT  
  @1 := 'D_LAST_SATURDAY_AGO',  
  @2 := 'Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) - 0 DAY)',  
  Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) - 0 DAY)  
UNION  
SELECT  
  @1 := 'D_THIS_SATURDAY',  
  @2 := 'Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) - 7 DAY)',  
  Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) - 7 DAY)
  
UNION  
SELECT  
  @1 := 'D_NEXT_SATURDAY',  
  @2 := 'Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) - 14 DAY)',  
  Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) - 14 DAY)  
  



