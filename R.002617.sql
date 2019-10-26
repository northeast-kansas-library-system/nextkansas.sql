/*
R.002617

----------

Name: enumchron work
Created by: Heather Braum

----------

Group: -
     -

Created on: 2015-10-12 20:06:11
Modified on: 2017-12-19 09:28:56
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblionumber,'\" target="_blank">',biblionumber,'</a>') as "record link", CONCAT('<a href=\"/cgi-bin/koha/cataloguing/addbiblio.pl?biblionumber=',biblionumber,'&op=#tab4XX\" target="_blank">'"edit record"'</a>') as "edit record", ExtractValue(metadata, '//datafield[@tag="490"]/subfield[@code="a"]') as seriestitle, ExtractValue(metadata, '//datafield[@tag="490"]/subfield[@code="v"]') as seriesno, enumchron FROM biblio_metadata left join items using(biblionumber) where enumchron IS NOT NULL AND enumchron <> '' and ExtractValue(metadata, '//datafield[@tag="490"]/subfield[@code="v"]') = '' group by biblionumber, enumchron


