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
Date last run: 2026-01-02 09:47:00

----------

Public: 0
Expiry: 0

----------

Provides count of active patrons during a set time period, who interacted with the system in some manner (have entries in the statistics table). Must choose branch twice & enter starting and ending date. 

This report cannot consider any patron activity more than 25 months old.

----------
*/



SELECT count(distinct borrowers.borrowernumber) FROM statistics, borrowers WHERE statistics.borrowernumber=borrowers.borrowernumber AND 
borrowers.branchcode=&lt;&gt; AND statistics.branch=&lt;&gt; AND statistics.datetime BETWEEN &lt;&gt; AND &lt;&gt;

























