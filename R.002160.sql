/*
R.002160

----------

Name: Fixing Publisher Fields with bad Diacritics
Created by: Heather Braum

----------

Group: Administrative Reports
     Fix Bib Records-admin

Created on: 2014-01-14 23:44:50
Modified on: 2017-12-18 15:40:02
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT biblionumber, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/addbiblio.pl?biblionumber=',biblionumber,'#tab2XX\" target="_blank">'"edit record"'</a>') as "edit record", ExtractValue(metadata, '//datafield[@tag="260"]/subfield[@code>="a"]') as publisher260,  ExtractValue(metadata, '//datafield[@tag="264"]/subfield[@code>="a"]') as publisher264 from biblio_metadata where metadata LIKE '%�%' ORDER BY biblionumber desc



