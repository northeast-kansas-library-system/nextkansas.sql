/*
R.002254

----------

Name: All Titles in Catalog within a Collection Code
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2014-05-05 23:14:32
Modified on: 2017-12-18 15:40:09
Date last run: 2017-09-27 13:00:03

----------

Public: 0
Expiry: 0

----------

Normally this would go under administrative reports, as it has no branch limits, but it's useful for all libraries. It simply lists all titles & title info for a specific collection code in the system. 

----------
*/

SELECT biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code>="b"]') as 'Remainder of Title' FROM items JOIN biblio USING(biblionumber) LEFT JOIN biblio_metadata USING(biblionumber) WHERE items.ccode=<<Pick your ccode|CCODE>> GROUP BY biblionumber ORDER BY biblio.title


