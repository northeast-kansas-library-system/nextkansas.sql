/*
R.002419

----------

Name: Shelf list in a shelving location with subjects (650, 651, and 655)
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2014-11-18 13:02:35
Modified on: 2017-12-19 09:28:30
Date last run: 2018-06-27 16:42:03

----------

Public: 0
Expiry: 0

----------

Helps with Genrefying your collection -- but is only as good as the record; if it doesn't have subjects, this report won't show that information. 

----------
*/

SELECT b.title, b.author, GROUP_CONCAT(i.itemcallnumber SEPARATOR ', ') as callnumbers, count(i.itemnumber) as total_items, GROUP_CONCAT(i.ccode SEPARATOR ', ') as ccodes, ExtractValue(t.metadata,'//datafield[@tag="650"]/subfield[@code>="a"]') as 650_field, ExtractValue(t.metadata,'//datafield[@tag="651"]/subfield[@code>="a"]') as 651_field, ExtractValue(t.metadata,'//datafield[@tag="655"]/subfield[@code>="a"]') as 655_field 
FROM biblio_metadata t LEFT JOIN items i USING(biblionumber) LEFT JOIN biblio b USING(biblionumber)
WHERE i.homebranch=<<choose library|branches>> AND i.location=<<choose location|LOC>>
GROUP BY b.biblionumber



