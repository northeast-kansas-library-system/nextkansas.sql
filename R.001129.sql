/*
R.001129

----------

Name: Bib record count - entire catalog
Created by: -

----------

Group: Administrative Reports
     Collection Stats-admin

Created on: 2011-06-10 11:07:17
Modified on: 2016-06-01 10:33:43
Date last run: 2019-01-15 21:22:34

----------

Public: 0
Expiry: 0

----------



----------
*/

select count(*) from biblio WHERE datecreated < <<Choose date (usually first of month, to count total records in system through end of previous month|date>>



