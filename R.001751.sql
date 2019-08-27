/*
R.001751

----------

Name: pcm records
Created by: Heather Braum

----------

Group: Administrative Reports
     Fix Bib Records-admin

Created on: 2013-02-12 12:22:28
Modified on: 2018-09-06 15:44:24
Date last run: 2018-09-06 15:44:31

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT b.biblionumber, CONCAT ('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',b.biblionumber,'\" target="_blank">'"link to record"'</a>') AS "Access Record", b.title, b.author, t.pages FROM biblio b LEFT JOIN biblioitems t USING(biblionumber) WHERE t.pages LIKE "p%cm%" GROUP BY biblionumber



