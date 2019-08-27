/*
R.002217

----------

Name: Holds Priority Issue Tracking (after patch)
Created by: Heather Braum

----------

Group: Administrative Reports
     Holds-admin

Created on: 2014-03-18 18:28:06
Modified on: 2014-03-18 18:40:42
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT timestamp, reserve_id, CONCAT ('<a href=\"/cgi-bin/koha/reserve/request.pl?biblionumber=',biblionumber,'\" target="_blank">',biblionumber,'</a>') AS "Holds Table", priority, found FROM reserves WHERE timestamp > '2014-03-18 18:23' ORDER BY biblionumber asc, reserve_id asc, found asc, priority asc LIMIT 20000



