/*
R.002502

----------

Name: Holds missing record level location -- agerestriction (942$e)
Created by: Heather Braum

----------

Group: Administrative Reports
     -

Created on: 2015-05-21 18:38:14
Modified on: 2015-05-21 20:39:28
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/cataloguing/addbiblio.pl?biblionumber=',t.biblionumber,'#tab9XX\" target="_blank">',t.biblionumber,'</a>') as "bibnumber" , CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',t.biblionumber,'\" target="_blank">'"access bib"'</a>') as "access bib", GROUP_CONCAT(DISTINCT ccode SEPARATOR ', ') as ccodes, GROUP_CONCAT(DISTINCT itype SEPARATOR ', ') as itypes, GROUP_CONCAT(DISTINCT location SEPARATOR ', ') as locations, agerestriction, cn_class, itemtype FROM biblioitems t LEFT JOIN items i USING(biblionumber) WHERE (t.biblionumber IN (SELECT biblionumber FROM reserves) OR t.biblionumber IN (SELECT biblionumber FROM old_reserves WHERE reservedate > '2015-03-01'))  AND agerestriction IS NULL GROUP BY t.biblionumber ORDER BY locations, itypes, ccodes LIMIT 50



