/*
R.003946

----------

Name: Extract 942 h from homebranch
Created by: Nikki Hansen

----------

Group: -
     -

Created on: 2026-03-06 10:26:12
Modified on: 2026-03-06 11:13:39
Date last run: 2026-03-06 11:13:42

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
    biblio.title, 
    items.ccode,
    items.barcode, 
    items.homebranch,
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="h"]') AS "942h_Classification"
FROM items
LEFT JOIN biblio ON (items.biblionumber = biblio.biblionumber)
LEFT JOIN biblio_metadata ON (items.biblionumber = biblio_metadata.biblionumber)
WHERE items.homebranch = <<Enter Branch Code|branches>>
ORDER BY items.ccode


























