/*
R.002126

----------

Name: circ comparison by itype
Created by: BASEHOR DIRECTOR

----------

Group: Library-Specific
     -

Created on: 2013-12-08 06:45:04
Modified on: 2013-12-08 06:45:04
Date last run: -

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT items.itype, items.location, substring(items.itemcallnumber,1,1) AS 'Call Number range', count(*) AS count FROM statistics LEFT JOIN items USING (itemnumber) WHERE statistics.type IN ('issue', 'renew') AND YEAR(datetime) = '2013' AND statistics.branch = 'BASEHOR' GROUP BY items.ccode, items.location, substring(items.itemcallnumber,1,1)



