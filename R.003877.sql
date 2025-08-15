/*
R.003877

----------

Name: Spreadsheet builder by library
Created by: George Williams

----------

Group: -
     -

Created on: 2025-02-03 16:10:29
Modified on: 2025-02-03 16:10:29
Date last run: 2025-05-12 11:41:47

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  branches.branchname As "Library name"
From
  branches
Union
Select
  "Doniphan County - All" As "Library name"
Union
Select
  "Prairie Hills School District - All" As "Library name"
Union
Select
  "Total" As "Library name"

























