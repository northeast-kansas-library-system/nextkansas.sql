/*
R.002461

----------

Name: Circ stats by source of acquisition
Created by: Heather Braum

----------

Group: Circulation
     Circ Stats

Created on: 2015-02-12 10:09:53
Modified on: 2015-02-12 10:17:20
Date last run: 2019-09-18 15:49:26

----------

Public: 0
Expiry: 0

----------

Note -- if you haven't been consistent with the names of sources of acquisition, this may be a long report. 

----------
*/



SELECT booksellerid, count(itemnumber) as "total items", SUM(issues+renewals) as "total circ" FROM items WHERE homebranch=<<choose branch|branches>> GROUP BY booksellerid

























