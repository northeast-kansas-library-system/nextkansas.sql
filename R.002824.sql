/*
R.002824

----------

Name: GHW - Upcoming closed dates at a branch
Created by: George H Williams

----------

Group: -
     -

Created on: 2016-11-15 10:29:39
Modified on: 2022-07-07 10:24:06
Date last run: 2022-07-07 10:24:10

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Shows upcoming closures at a specified branch</p>
<ul><li>Shows repeating closures for the next 12 months and all future closures on individually specified dates</li>
<li>Shows closures at the branch you specify</li>
<li>sorted by branch and date of holiday (repeating weekly holidays appear first on the list)</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2824&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  (special_holidays.branchcode COLLATE utf8mb4_unicode_ci) AS BRANCH,
  special_holidays.title AS TITLE,
  special_holidays.description AS DESCRIPTION,

  Str_To_Date(
    Concat(special_holidays.month, '/', special_holidays.day, '/', special_holidays.year), 
    '%m/%d/%Y'
  ) AS UPCOMING_DATE,

  Date_Format(
    Str_To_Date(Concat(special_holidays.month, '/', special_holidays.day, '/', special_holidays.year), '%m/%d/%Y'), 
    '%W'
  ) AS DAY_OF_WEEK,

  IF(special_holidays.year IS NULL, "X", Concat(special_holidays.year, " only" )) AS REPEATS
FROM
  special_holidays
WHERE
  (special_holidays.branchcode LIKE @brn:=<<Enter your branch|LBRANCH>> COLLATE utf8mb4_unicode_ci) AND
  Str_To_Date(
    Concat(special_holidays.month, '/', special_holidays.day, '/', special_holidays.year), '%m/%d/%Y'
  ) > Now() - INTERVAL 1 DAY
UNION
SELECT
  repeatable_holidays.branchcode AS BRANCH,
  repeatable_holidays.title AS TITLE,
  repeatable_holidays.description AS DESCRIPTION,

  Str_To_Date(
    Concat(repeatable_holidays.month, '/', repeatable_holidays.day, '/', (If(repeatable_holidays.month >= Month(CurDate()), Year(CurDate()), Year(CurDate()) + 1))), '%m/%d/%Y'
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
                    Concat(repeatable_holidays.month, '/', repeatable_holidays.day, '/', (If(repeatable_holidays.month >= Month(CurDate()), Year(CurDate()), Year(CurDate()) + 1))), '%m/%d/%Y'
                    ), 
                  '%W'
                )
              )
            )
          )
        )
      )
    )
  ) AS DAY_OF_WEEK,

  If(
    repeatable_holidays.weekday IS NULL, 
    "Repeats annually", 
    "Repeats weekly"
  ) AS REPEATS
FROM
  repeatable_holidays
WHERE
  (
    repeatable_holidays.branchcode LIKE @brn AND
    Str_To_Date(
      Concat(repeatable_holidays.month, '/', repeatable_holidays.day, '/', (If(repeatable_holidays.month >= Month(CurDate()), Year(CurDate()), Year(CurDate()) + 1))), '%m/%d/%Y'
    ) > Now() - INTERVAL 1 DAY

  ) OR (

    repeatable_holidays.branchcode LIKE @brn AND 
    Str_To_Date(
      Concat(repeatable_holidays.month, '/', repeatable_holidays.day, '/', (If(repeatable_holidays.month >= Month(CurDate()), Year(CurDate()), Year(CurDate()) + 1))), '%m/%d/%Y'
    ) IS NULL
  )
ORDER BY
  BRANCH,
  UPCOMING_DATE

























