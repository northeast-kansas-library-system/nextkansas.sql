/*
R.001128

----------

Name: List that totals the circulation of each Dewey section, F, and periodicals, by month
Created by: -

----------

Group: Catalog Records and Items
     Collection Statistics

Created on: 2011-06-08 13:03:00
Modified on: 2013-11-17 16:13:42
Date last run: 2021-01-27 12:32:42

----------

Public: 0
Expiry: 0

----------

From koha-comm reports library

----------
*/

SELECT location, substring(itemcallnumber,1,1) AS 'Call Number range', count(*) AS count FROM statistics LEFT JOIN items USING (itemnumber) WHERE statistics.type IN ('issue', 'renew') AND YEAR(datetime) = <<Enter Year>> AND MONTH(datetime) = <<Enter Month>> AND statistics.branch = <<branch|branches>> AND items.itype = <<Item Type|itemtypes>> AND items.ccode = <<ccode|CCODE>> GROUP BY location, substring(itemcallnumber,1,1)



