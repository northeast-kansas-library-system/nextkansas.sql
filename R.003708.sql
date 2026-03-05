/*
R.003708

----------

Name: GHW - Branch names and branchcodes
Created by: NEKLS Admin Test

----------

Group: -
     -

Created on: 2023-02-13 16:02:12
Modified on: 2023-02-13 16:02:12
Date last run: 2023-02-13 16:40:49

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  branches.branchname,
  branches.branchcode
From
  branches
Group By
  branches.branchname,
  branches.branchcode
LIMIT
  100

























