/*
R.002240

----------

Name: Active patrons in set timeperiod
Created by: Heather Braum

----------

Group: Patrons
     Patron Statistics

Created on: 2014-04-07 22:36:00
Modified on: 2014-04-07 22:36:26
Date last run: 2020-12-01 14:46:44

----------

Public: 0
Expiry: 0

----------

Provides count of active patrons during a set time period, who interacted with the system in some manner (have entries in the statistics table). Must choose branch twice & enter starting and ending date. 

----------
*/

SELECT count(distinct borrowers.borrowernumber) FROM statistics, borrowers WHERE statistics.borrowernumber=borrowers.borrowernumber AND 
borrowers.branchcode=<<branch|branches>> AND statistics.branch=<<branch|branches>> AND statistics.datetime BETWEEN <<starting date, ex. 2013-01-01>> AND <<ending date, ex. 2013-12-31>>



