/*
R.002240

----------

Name: Active patrons in set timeperiod
Created by: Heather Braum

----------

Group: Borrowers
     Patron Statistics

Created on: 2014-04-07 22:36:00
Modified on: 2022-05-18 12:13:45
Date last run: 2025-10-01 14:34:05

----------

Public: 0
Expiry: 0

----------

Provides count of active patrons during a set time period, who interacted with the system in some manner (have entries in the statistics table). Must choose branch twice & enter starting and ending date. 

This report cannot consider any patron activity more than 25 months old.

----------
*/



SELECT count(distinct borrowers.borrowernumber) FROM statistics, borrowers WHERE statistics.borrowernumber=borrowers.borrowernumber AND 
borrowers.branchcode=<> AND statistics.branch=<> AND statistics.datetime BETWEEN <> AND <>

























