/*
R.002234

----------

Name: Records with links
Created by: Heather Braum

----------

Group: -
     -

Created on: 2014-03-29 22:09:01
Modified on: 2017-12-18 15:40:03
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT biblionumber, ExtractValue(metadata, '//datafield[@tag="856"]/subfield[@code>="u"]') FROM biblio_metadata



