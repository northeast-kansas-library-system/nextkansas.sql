/*
R.001952

----------

Name: Bib records with more than 200 items
Created by: Heather Braum

----------

Group: Administrative Reports
     Catalog-admin

Created on: 2013-07-21 09:51:36
Modified on: 2013-08-07 00:06:13
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT biblionumber, count(itemnumber) FROM items GROUP BY biblionumber HAVING count(itemnumber) > 199



