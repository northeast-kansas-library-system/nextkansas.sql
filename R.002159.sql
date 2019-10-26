/*
R.002159

----------

Name: Records with bad diacritics
Created by: Heather Braum

----------

Group: Administrative Reports
     Fix Bib Records-admin

Created on: 2014-01-14 20:08:41
Modified on: 2017-12-18 15:38:50
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT ('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblionumber,'\" target="_blank">',biblionumber,'</a>') from biblio_metadata WHERE biblionumber IN (SELECT biblionumber FROM biblio_metadata where metadata LIKE '%�%')


