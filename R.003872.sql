/*
R.003872

----------

Name: koha-us 002
Created by: George Williams

----------

Group: -
     -

Created on: 2025-01-14 16:38:13
Modified on: 2025-01-14 16:43:29
Date last run: 2025-01-14 17:37:30

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
      statistics.itemnumber,
      Group_Concat(statistics.datetime Separator ' //<br> ') As Group_Concat_datetime,
      Count(statistics.datetime) As COUNT
    From
      statistics
    Where
      (statistics.type = 'issue' Or
       statistics.type = 'renew') And
      Year(statistics.datetime) Like <<Enter 4 digit year>> And
      Month(statistics.datetime) Like Concat('%', <<Enter number of month or a percent symbol>> , '%')
    Group By
      statistics.itemnumber

























