/*
R.002602

----------

Name: Circ by Call Number Range (Circ of your items at Your Library)
Created by: Heather Braum

----------

Group: Circulation
     Circ Stats

Created on: 2015-09-10 13:49:15
Modified on: 2015-09-10 13:49:15
Date last run: 2025-04-09 09:03:09

----------

Public: 0
Expiry: 300

----------

Limited to Your Library's items, circed at your library, in a set year. 

----------
*/



SELECT items.location, items.ccode, substring(items.itemcallnumber,1,4) AS 'Call Number range', count(*) AS count FROM statistics LEFT JOIN items USING (itemnumber) WHERE items.homebranch=<> AND statistics.type IN ('issue', 'renew') AND YEAR(datetime) = <> AND statistics.branch = <> GROUP BY items.location, substring(items.itemcallnumber,1,4), items.ccode ORDER BY items.ccode, substring(items.itemcallnumber,1,4)

























