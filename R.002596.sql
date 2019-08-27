/*
R.002596

----------

Name: Custom Holds Test djw
Created by: BASEHOR DIRECTOR

----------

Group: -
     -

Created on: 2015-08-29 14:30:40
Modified on: 2015-08-29 14:38:25
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT ('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',t.biblionumber,'\" target="_blank">'"link to record"'</a>') AS "Link to Record",  t.title, b.author, t.holdingbranch, t.itemcallnumber, t.barcode, i.ccode, t.publicationyear, i.location, count(i.itemnumber) as totalitemsavail, 
(SELECT count(r.reserve_id) FROM reserves r WHERE r.biblionumber=t.biblionumber GROUP BY t.biblionumber) AS totalholds
FROM tmp_holdsqueue t LEFT JOIN biblio b USING(biblionumber) LEFT JOIN items i USING(biblionumber) 
WHERE i.withdrawn = '0' AND i.itemlost='0' AND i.notforloan='0' AND i.damaged='0' and i.onloan IS NULL AND t.holdingbranch='BASEHOR' and t.pickbranch <> 'BASEHOR'
GROUP BY t.itemnumber having count(totalitemsavail) < '3'
ORDER BY i.location, i.ccode, t.itemcallnumber



