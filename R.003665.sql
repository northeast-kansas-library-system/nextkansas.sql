/*
R.003665

----------

Name: koha-US 1001
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-09-18 23:31:16
Modified on: 2022-09-18 23:31:16
Date last run: 2022-10-18 10:24:55

----------

Public: 0
Expiry: 300

----------

Simple report for yesterday's statistics by branchcode.

----------
*/



Select
    statistics.branch,
    Count(*) As CIRC_RENEW_COUNT
From
    statistics
Where
    (statistics.type = 'issue' Or
    statistics.type = 'renew') And
    Year(statistics.datetime) = Year(CurDate() - Interval 1 Day) And
    Month(statistics.datetime) = Month(CurDate() - Interval 1 Day) And
    Day(statistics.datetime) = Day(CurDate() - Interval 1 Day)
Group By
    statistics.branch

























