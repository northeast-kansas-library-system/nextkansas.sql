/*
R.003081

----------

Name: Weeding
Created by: PHSHS TECH

----------

Group: -
     -

Created on: 2018-06-13 09:35:27
Modified on: 2018-06-13 09:35:27
Date last run: 2021-12-06 15:27:28

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT  items.dateaccessioned,items.issues FROM borrowers LEFT JOIN statistics on (statistics.borrowernumber=borrowers.borrowernumber) LEFT JOIN items on (items.itemnumber = statistics.itemnumber) LEFT JOIN biblioitems on (biblioitems.biblioitemnumber = items.biblioitemnumber) 

























