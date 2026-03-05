/*
R.003942

----------

Name: WMSBG TEST
Created by: Nikki Hansen

----------

Group: -
     -

Created on: 2026-02-23 08:21:42
Modified on: 2026-02-23 08:29:11
Date last run: 2026-02-23 08:29:30

----------

Public: 0
Expiry: 180

----------



----------
*/



SELECT
    b.title,
    b.author,
    i.barcode,
    i.itemcallnumber,
    i.homebranch,
    i.location,
    i.itype,
    i.dateaccessioned,
    i.datelastborrowed,
    i.issues AS total_checkouts,
    i.renewals AS total_renewals
FROM items i
LEFT JOIN biblio b ON i.biblionumber = b.biblionumber
WHERE (i.datelastborrowed < DATE_SUB(CURDATE(), INTERVAL 5 YEAR)
       OR (i.datelastborrowed IS NULL AND i.dateaccessioned < DATE_SUB(CURDATE(), INTERVAL 5 YEAR)))
AND i.onloan IS NULL
AND i.itemlost = 0
AND i.withdrawn = 0
AND i.homebranch = <<Choose branch|branches>>
ORDER BY i.homebranch, i.itemcallnumber

























