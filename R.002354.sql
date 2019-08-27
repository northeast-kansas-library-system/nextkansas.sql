/*
R.002354

----------

Name: Ottawa book club records to check
Created by: Heather Braum

----------

Group: Administrative Reports
     Post-Lansing

Created on: 2014-09-05 19:35:00
Modified on: 2014-09-05 19:52:38
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',i.biblionumber,'\" target="_blank">',i.biblionumber,'</a>') as bib, count(i.itemnumber), t.editionstatement FROM items i LEFT JOIN biblioitems t USING(biblionumber) WHERE i.biblionumber IN (SELECT i.biblionumber FROM items i WHERE i.itype='KITS' AND i.ccode='PROFCOLL' AND i.homebranch='OTTAWA') GROUP BY biblionumber LIMIT 200



