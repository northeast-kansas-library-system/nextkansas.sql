/*
R.003668

----------

Name: koha-US 1004
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-09-18 23:40:29
Modified on: 2022-09-18 23:40:29
Date last run: 2022-10-18 10:25:55

----------

Public: 0
Expiry: 300

----------

All branches by branchname plus all circulation yesterday

----------
*/



Select
    branches.branchname,
    report_one.CIRC_RENEW_COUNT
From
    branches Left Join
    (Select
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
         statistics.branch) report_one On report_one.branch = branches.branchcode

























