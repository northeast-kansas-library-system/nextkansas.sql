/*
R.000610

----------

Name: Branchcodes and Branchnames
Created by:  Tongie Book Club

----------

Group: Administrative Reports
     System-admin

Created on: 2009-06-24 16:26:50
Modified on: 2023-03-28 16:32:40
Date last run: 2023-03-28 16:32:43

----------

Public: 0
Expiry: 0

----------

Simple table showing branch names and branchcode

----------
*/



SELECT 
  branches.branchname, 
  branches.branchcode 
FROM branches 
ORDER BY 
  branchname ASC 
LIMIT
  500

























