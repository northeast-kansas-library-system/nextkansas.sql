/*
R.001911

----------

Name: List of Child and Adult Patron Categories
Created by: Heather Braum

----------

Group: Administrative Reports
     System-admin

Created on: 2013-06-12 10:08:58
Modified on: 2013-06-17 00:54:59
Date last run: 2021-09-16 16:14:10

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT categorycode from categories where category_type IN ('c','a') order by categorycode desc, category_type desc limit 300



