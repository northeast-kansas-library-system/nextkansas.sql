/*
R.003948

----------

Name: Test count 942h
Created by: George Williams

----------

Group: -
     -

Created on: 2026-03-06 11:18:39
Modified on: 2026-03-06 11:19:18
Date last run: 2026-03-06 11:20:01

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="h"]') AS "942h_Classification",
  count(items.itemnumber)
FROM items
LEFT JOIN biblio_metadata ON (items.biblionumber = biblio_metadata.biblionumber)
WHERE items.homebranch LIKE <<Enter Branch Code|branches:all>>
Group BY ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="h"]')
ORDER BY ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="h"]')

























