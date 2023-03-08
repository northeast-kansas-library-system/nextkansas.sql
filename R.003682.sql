/*
R.003682

----------

Name: GHW - Upcoming closures for home page for jQuery enhancement
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-11-27 16:14:02
Modified on: 2022-12-14 15:10:13
Date last run: 2023-03-08 14:36:21

----------

Public: 1
Expiry: 5

----------

<div id=reportinfo class=noprint>
  <p>Produces a list of upcoming closures at a library</p>
  <ul>
    <li>Shows data current for the date and time the report is run</li>
    <li>shows closures at the library you're logged in at</li>
    <li>grouped by special_holidays.id and repeatable_holidays.id</li>
    <li>sorted by branchcode and date</li>
  </ul><br />
  <p><ins>Notes:</ins></p>
  <p></p>
  <p>Relies on jQuery to work properly</p>
  <p></p>
  <p class= "notetags" style="display: none;">#jquery_enhancement</p>
  <!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes -->
</div>

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

























