/*
R.001423

----------

Name: Lost Items Count per Branch
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Status reports-lost, damaged

Created on: 2012-05-14 23:48:28
Modified on: 2013-09-25 17:15:40
Date last run: 2020-01-06 16:41:52

----------

Public: 0
Expiry: 0

----------

Count of Lost Items per Branch. (On Reports Webpages, 5/14/12); #count

----------
*/

SELECT items.homebranch, authorised_values.lib, count(items.itemnumber) as items FROM items LEFT JOIN authorised_values ON (items.itemlost=authorised_values.authorised_value) WHERE items.itemlost != 0 AND authorised_values.category='LOST' GROUP BY items.homebranch, authorised_values.lib ORDER BY homebranch, authorised_values.lib asc 



