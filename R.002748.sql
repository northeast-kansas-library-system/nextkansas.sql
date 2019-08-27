/*
R.002748

----------

Name: GHW - Duplicate search
Created by: George H Williams

----------

Group: Administrative Reports
     -

Created on: 2016-08-29 23:37:20
Modified on: 2016-08-30 00:13:23
Date last run: 2018-12-22 09:12:26

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  CONCAT('<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=ti&q=',b.title,'&sort_by=title_az\" target="_blank">',b.title,'</a>') AS "Title Search",
  CONCAT(trim(b.title)),
  GROUP_CONCAT(DISTINCT b.biblionumber SEPARATOR ', ') as numbers,
  GROUP_CONCAT(DISTINCT '<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', b.biblionumber,'\" target="_blank">', b.biblionumber, '</a>'  SEPARATOR ', ') AS 'biblionumber',
  GROUP_CONCAT(DISTINCT t.publicationyear SEPARATOR ', ') as copyright,
  GROUP_CONCAT(DISTINCT b.author SEPARATOR ', ') as author,
  GROUP_CONCAT(DISTINCT i.ccode SEPARATOR ', ') as ccode,
  GROUP_CONCAT(DISTINCT i.itype SEPARATOR ', ') as ITEM_TYPE,
  GROUP_CONCAT(DISTINCT i.homebranch SEPARATOR ', ') as homebranches,
  count(DISTINCT b.biblionumber)
FROM biblio b 
  LEFT JOIN items i USING(biblionumber)
  LEFT JOIN biblioitems t USING(biblionumber)
WHERE (i.ccode NOT IN ('ERESOURCE','DLVIDEO','DLAUDIO','DLBOOK','DLMUSIC'))
GROUP BY CONCAT(trim(b.title))
HAVING (count(DISTINCT b.biblionumber) > 1) AND homebranches LIKE '%PAOLA%'




