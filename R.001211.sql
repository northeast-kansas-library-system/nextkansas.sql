/*
R.001211

----------

Name: Holds Left Behind When Record Deleted
Created by: -

----------

Group: Administrative Reports
     Holds-admin

Created on: 2011-10-25 09:40:52
Modified on: 2013-09-21 16:05:33
Date last run: 2021-06-10 14:32:00

----------

Public: 0
Expiry: 0

----------

Patrons with a hold that was left behind when bib records were deleted. #holds

----------
*/



select * from reserves where biblionumber IS NULL

























