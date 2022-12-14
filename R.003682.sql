/*
R.003682

----------

Name: GHW - Upcoming closures for home page
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-11-27 16:14:02
Modified on: 2022-11-27 22:05:41
Date last run: 2022-12-14 13:49:11

----------

Public: 1
Expiry: 5

----------



----------
*/



Select
    special_holidays.branchcode As BRANCH,
    Concat_WS(
      ' - ', 
      Str_To_Date(
        Concat(
          special_holidays.month, 
          '/', 
          special_holidays.day, 
          '/', 
          special_holidays.year
        ), 
        '%m/%d/%Y'
      ),  
      Date_Format(
        Str_To_Date(
          Concat(
            special_holidays.month, 
            '/', 
            special_holidays.day, 
            '/', 
            special_holidays.year
          ), 
        '%m/%d/%Y'
        ), 
       '%W'
      )
    ) As CLOSED_DATE,
    special_holidays.title As TITLE,
    If(
      special_holidays.year Is Null, 
      "X", 
      special_holidays.year
    ) As FREQUENCY
From
    special_holidays
Where
    special_holidays.branchcode Like <<branchcode1>> And
    Str_To_Date(
      Concat(
        special_holidays.month, 
        '/', 
        special_holidays.day, 
        '/', 
        special_holidays.year
      ), 
      '%m/%d/%Y'
    ) > Now() - Interval 1 Day
Group By
    special_holidays.id
UNION 
Select
    repeatable_holidays.branchcode As BRANCH,
    CONCAT_WS(
      ' - ', 
      Str_To_Date(
        Concat(
          repeatable_holidays.month, 
          '/', 
          repeatable_holidays.day, 
          '/', 
          If(
            repeatable_holidays.month >= Month(CurDate()), 
            Year(CurDate()), 
            Year(CurDate()) + 1
          )
        ), 
        '%m/%d/%Y'
      ), 
      If(
        repeatable_holidays.weekday = 0, 
        ' Every Sunday', 
        If(
          repeatable_holidays.weekday = 1, 
          ' Every Monday', 
          If(
            repeatable_holidays.weekday = 2, 
            ' Every Tuesday', 
            If(
              repeatable_holidays.weekday = 3, 
              ' Every Wednesday', 
              If(
                repeatable_holidays.weekday = 4, 
                ' Every Thursday', 
                If(
                  repeatable_holidays.weekday = 5, 
                  ' Every Friday', 
                  If(
                    repeatable_holidays.weekday = 6, 
                    ' Every Saturday', 
                    Date_Format(
                      Str_To_Date(
                        Concat(
                          repeatable_holidays.month, 
                          '/', 
                          repeatable_holidays.day, 
                          '/', 
                          If(
                            repeatable_holidays.month >= Month(CurDate()), 
                            Year(CurDate()), 
                            Year(CurDate()) + 1
                          )
                        ), 
                        '%m/%d/%Y'
                      ), 
                      '%W'
                    )
                  )
                )
              )
            )
          )
        )
      )
    ) As CLOSED_DATE,
    repeatable_holidays.title As TITLE,
    If(
      repeatable_holidays.weekday Is Null, 
      CONCAT(
        "Repeats every year on ", 
        LPAD(repeatable_holidays.month, 2, 0), 
        '-', 
        LPAD(repeatable_holidays.day, 2, 0)
      ) , 
      "Repeats every week"
    ) As FREQUENCY
From
    repeatable_holidays
Where
    (
      repeatable_holidays.branchcode Like <<branchcode2>> And
      Str_To_Date(
        Concat(
          repeatable_holidays.month, 
          '/', 
          repeatable_holidays.day, 
          '/', 
          If(
            repeatable_holidays.month >= Month(CurDate()), 
            Year(CurDate()), 
            Year(CurDate()) + 1
          )
        ), 
        '%m/%d/%Y'
      ) > Now() - Interval 1 Day
    ) 
    Or
    (
      repeatable_holidays.branchcode Like <<branchcode3>> And
      Str_To_Date(
        Concat(
          repeatable_holidays.month, 
          '/', 
          repeatable_holidays.day, 
          '/', 
          If(
            repeatable_holidays.month >= Month(CurDate()), 
            Year(CurDate()), 
            Year(CurDate()) + 1
          )
        ), '%m/%d/%Y'
      ) Is Null
    )
Group By
    repeatable_holidays.id
Order By
    BRANCH,
    CLOSED_DATE

























