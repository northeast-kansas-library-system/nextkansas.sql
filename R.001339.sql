/*
R.001339

----------

Name: Circ by Call Number Range (Circ at Any Library)
Created by: Heather Braum

----------

Group: Circulation
     Circ Stats

Created on: 2012-03-13 11:46:56
Modified on: 2015-09-10 13:47:54
Date last run: 2022-04-12 14:11:36

----------

Public: 0
Expiry: 0

----------

#circ

----------
*/



SELECT items.location, items.ccode, substring(items.itemcallnumber,1,4) AS 'Call Number range', count(*) AS count FROM statistics LEFT JOIN items USING (itemnumber) WHERE statistics.type IN ('issue', 'renew') AND YEAR(datetime) = <<enter year>> AND statistics.branch = <<branch|branches>> GROUP BY items.location, substring(items.itemcallnumber,1,4), items.ccode ORDER BY items.ccode, substring(items.itemcallnumber,1,4)

























