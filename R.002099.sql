/*
R.002099

----------

Name: Shelf List of Items with subjects/title of keyword, limited by library
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2013-11-14 16:26:31
Modified on: 2017-12-18 15:38:31
Date last run: -

----------

Public: 0
Expiry: 0

----------

Has problems...will be writing ticket for this one 11/14/13. hb

----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblio.biblionumber,'\" target="_blank">',biblio.biblionumber,'</a>')
AS linkedbibnumber, biblio.title, biblio.author, items.ccode, items.itemcallnumber, items.homebranch
FROM 
(SELECT biblio_metadata.biblionumber, 
ExtractValue(biblio_metadata.metadata,'//datafield[@tag="650"]/subfield[@code>="a"]') AS lcsh1, 
ExtractValue(biblio_metadata.metadata,'//datafield[@tag="600"]/subfield[@code>="a"]') AS lcsh2, 
ExtractValue(biblio_metadata.metadata,'//datafield[@tag="651"]/subfield[@code>="a"]') AS lcsh3, 
ExtractValue(biblio_metadata.metadata,'//datafield[@tag="655"]/subfield[@code>="a"]') AS lcsh4, 
ExtractValue(biblio_metadata.metadata,'//datafield[@tag="245"]/subfield[@code>="a"]') AS fulltitle 
FROM biblio_metadata, items WHERE biblio_metadata.biblionumber=items.biblionumber AND items.homebranch=<<choose branch|branches>>) 
AS subjects, biblio, items 
WHERE subjects.biblionumber=biblio.biblionumber AND biblio.biblionumber=items.biblionumber AND items.homebranch=<<choose branch|branches>>
 AND (lcsh1 LIKE <<enter subject or keyword with % before and after (ex. %frogs%)>> 
OR lcsh2 LIKE  <<enter same subject or keyword with % before and after (ex. %frogs%)>>
OR lcsh3 LIKE  <<enter subject or keyword with % before and after (ex. %frogs%)>>
OR lcsh4 LIKE <<enter subject or keyword with % before and after (ex. %frogs%)>>
OR fulltitle LIKE  <<enter subject or keyword with % before and after (ex. %frogs%)>>)
GROUP BY biblio.biblionumber
ORDER BY items.ccode, items.itemcallnumber



