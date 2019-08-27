/*
R.002214

----------

Name: Holds Priority Issue Checking
Created by: Heather Braum

----------

Group: Administrative Reports
     Holds-admin

Created on: 2014-03-16 13:26:57
Modified on: 2014-03-18 18:24:03
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT timestamp, CONCAT ('<a href=\"/cgi-bin/koha/reserve/request.pl?biblionumber=',biblionumber,'\" target="_blank">',biblionumber,'</a>') AS "Holds Table", biblionumber, priority FROM reserves WHERE found IS NULL AND biblionumber IN (SELECT biblionumber FROM reserves GROUP BY biblionumber HAVING count(reserve_id) > 1) AND priority GROUP BY biblionumber ORDER BY priority desc LIMIT 10000



