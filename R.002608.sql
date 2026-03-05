/*
R.002608

----------

Name: Fixing Series, VF items
Created by: Heather Braum

----------

Group: -
     -

Created on: 2015-09-22 18:03:58
Modified on: 2017-12-19 09:28:37
Date last run: 2022-09-15 10:39:04

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT CONCAT('<a href=\"/cgi-bin/koha/cataloguing/addbiblio.pl?biblionumber=',b.biblionumber,'&op=#tab4XX\" target="_blank">'"edit item"'</a>') as "edit item", b.title, i.biblionumber, i.enumchron, b.seriestitle, ExtractValue(t.metadata, '//datafield[@tag="490"]/subfield[@code>="v"]') as 490v FROM items i LEFT JOIN biblio b USING(biblionumber) LEFT JOIN biblio_metadata t USING(biblionumber) WHERE i.homebranch='VALLEYFALL' AND i.enumchron IS NOT NULL AND i.biblionumber IN ('276732','464056','301816','635334','443660','276740','464162','670398','670400','552252','235770','533757','484338','504487','268612','362348','466391') AND b.seriestitle IS NULL

























