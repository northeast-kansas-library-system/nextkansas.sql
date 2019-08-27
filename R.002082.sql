/*
R.002082

----------

Name: Holds Queue Analysis (Available Items)
Created by: Heather Braum

----------

Group: Administrative Reports
     Holds-admin

Created on: 2013-10-31 13:37:49
Modified on: 2016-07-22 09:07:53
Date last run: 2019-08-27 15:00:03

----------

Public: 0
Expiry: 0

----------

Analyzes number of items on a record, number of unrestricted & restricted items, notforloan, damaged, lost, withdrawn

----------
*/

SELECT 
    current_timestamp() as "report time", 
    CONCAT ('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',t.biblionumber,'\" target="_blank">'"link to record"'</a>') AS "Link to Record", 
    b.title, b.author, t.holdingbranch, i.ccode, count(i.itemnumber) as "total items on record", 
    (SELECT count(r.reserve_id) FROM reserves r WHERE r.biblionumber=t.biblionumber GROUP BY t.biblionumber) AS totalholds,
    (SELECT count(i.itemnumber)
        FROM items i 
        WHERE i.biblionumber=t.biblionumber AND i.itype NOT IN ('WALKIN','WALKIN1','WALKIN2','LOCALHOLD','LOCALHOLD1','LOCALHOLD2')
        GROUP BY t.biblionumber) as "unrestricted count", 
    (SELECT count(i.itemnumber)
        FROM items i 
        WHERE i.biblionumber=t.biblionumber AND i.itype IN ('WALKIN','WALKIN1','WALKIN2','LOCALHOLD','LOCALHOLD1','LOCALHOLD2')
        GROUP BY t.biblionumber) as "restricted count", 
    (SELECT count(i.itemnumber) 
        FROM items i 
        WHERE i.biblionumber=t.biblionumber AND i.notforloan <> '0'
        GROUP BY t.biblionumber) as "notforloan count", 
    (SELECT count(i.itemnumber) 
        FROM items i 
        WHERE i.biblionumber=t.biblionumber AND i.damaged <> '0'
        GROUP BY t.biblionumber) as "damaged count", 
    (SELECT count(i.itemnumber)
        FROM items i 
        WHERE i.biblionumber=t.biblionumber AND i.itemlost <> '0'
        GROUP BY t.biblionumber) as "lost count",
    (SELECT count(i.itemnumber)
        FROM items i 
        WHERE i.biblionumber=t.biblionumber AND i.withdrawn <> '0'
        GROUP BY t.biblionumber) as "withdrawn count" ,
    t.barcode
FROM tmp_holdsqueue t LEFT JOIN biblio b USING(biblionumber) LEFT JOIN items i USING(biblionumber) 
GROUP BY t.itemnumber 
ORDER BY t.holdingbranch ASC, totalholds DESC



