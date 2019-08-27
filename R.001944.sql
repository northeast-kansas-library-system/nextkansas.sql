/*
R.001944

----------

Name: Size of MARC data per record
Created by: Heather Braum

----------

Group: Administrative Reports
     System-admin

Created on: 2013-07-17 16:18:11
Modified on: 2017-12-18 15:38:10
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT biblionumber, CONCAT ('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblionumber,'\" target="_blank">'"link to record"'</a>') AS "Linked Record", LENGTH(metadata) FROM biblio_metadata JOIN items USING(biblionumber) WHERE LENGTH(metadata) > 9999 AND items.ccode <> 'DVD' AND items.ccode <> 'TVSERIES' GROUP BY biblionumber HAVING COUNT(items.itemnumber) > 0 ORDER BY LENGTH(metadata) DESC LIMIT 2000



