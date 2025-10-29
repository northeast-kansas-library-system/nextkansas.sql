/*
R.003778

----------

Name: GHW - ADMINREPORT closures
Created by: George Williams

----------

Group: -
     -

Created on: 2023-10-23 14:59:36
Modified on: 2023-10-23 14:59:36
Date last run: 2024-08-28 08:32:45

----------

Public: 0
Expiry: 300

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
    special_holidays.branchcode Like <> And
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
      repeatable_holidays.branchcode Like <> And
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
      repeatable_holidays.branchcode Like <> And
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

























