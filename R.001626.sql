/*
R.001626

----------

Name: List that totals the circulation of each Dewey section, F, and periodicals, by year
Created by: Heather Braum

----------

Group: Circulation
     Circ Stats

Created on: 2012-11-09 12:18:19
Modified on: 2013-09-25 17:14:56
Date last run: 2020-07-06 12:01:01

----------

Public: 0
Expiry: 0

----------

A revised version of 1128 #circ

----------
*/

SELECT items.ccode, items.location, substring(items.itemcallnumber,1,1) AS 'Call Number range', count(*) AS count FROM statistics LEFT JOIN items USING (itemnumber) WHERE statistics.type IN ('issue', 'renew') AND YEAR(datetime) = <<Enter Year>> AND statistics.branch = <<branch|branches>> GROUP BY items.ccode, items.location, substring(items.itemcallnumber,1,1)



