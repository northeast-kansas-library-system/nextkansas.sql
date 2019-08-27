/*
R.001919

----------

Name: Top Circing Patrons
Created by: Heather Braum

----------

Group: Administrative Reports
     Patron Statistics-admin

Created on: 2013-06-24 19:42:39
Modified on: 2014-01-15 15:19:24
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/circ/circulation.pl?borrowernumber=',borrowernumber,'\" target="_blank">',statistics.borrowernumber,'</a>') as "edit patron", count(statistics.datetime) as count FROM statistics LEFT JOIN borrowers USING(borrowernumber) WHERE statistics.borrowernumber IS NOT NULL AND statistics.borrowernumber NOT IN ('11689','13712','102213') AND borrowers.categorycode NOT IN ('ILL','ASSOCIATE','STATISTIC','STAFF') GROUP BY statistics.borrowernumber ORDER BY count DESC LIMIT 10



