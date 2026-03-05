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
Date last run: 2026-01-22 16:49:41

----------

Public: 0
Expiry: 0

----------

#circ

----------
*/



SELECT items.location, items.ccode, substring(items.itemcallnumber,1,4) AS 'Call Number range', count(&ast;) AS count FROM statistics LEFT JOIN items USING (itemnumber) WHERE statistics.type IN ('issue', 'renew') AND YEAR(datetime) = &lt;&gt; AND statistics.branch = &lt;&gt; GROUP BY items.location, substring(items.itemcallnumber,1,4), items.ccode ORDER BY items.ccode, substring(items.itemcallnumber,1,4)

























