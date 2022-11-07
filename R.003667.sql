/*
R.003667

----------

Name: koha-US 1003
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-09-18 23:39:26
Modified on: 2022-09-18 23:41:59
Date last run: 2022-10-18 10:25:29

----------

Public: 0
Expiry: 300

----------

All results by branchname

----------
*/



Select
    branches.branchname,
    Count(*) As CIRC_RENEW_COUNT
From
    branches Left Join
    statistics On statistics.branch = branches.branchcode
Where
    (statistics.type = 'issue' Or
        statistics.type = 'renew') And
    Year(statistics.datetime) = Year(CurDate() - Interval 1 Day) And
    Month(statistics.datetime) = Month(CurDate() - Interval 1 Day) And
    Day(statistics.datetime) = Day(CurDate() - Interval 1 Day)
Group By
    branches.branchname

























