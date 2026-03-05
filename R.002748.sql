/*
R.002748

----------

Name: GHW - Duplicate search
Created by: George Williams

----------

Group: Administrative Reports
     -

Created on: 2016-08-29 23:37:20
Modified on: 2023-10-01 11:38:41
Date last run: 2023-10-01 11:40:12

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT
  CONCAT('<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=ti&q=',b.title,'&sort_by=title_az\" target="_blank">',b.title,'</a>') AS "Title Search",
  CONCAT(trim(b.title)),
  GROUP_CONCAT(DISTINCT b.biblionumber SEPARATOR '<br />') as numbers,
  GROUP_CONCAT(DISTINCT '<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', b.biblionumber,'\" target="_blank">', b.biblionumber, '</a>'  SEPARATOR '<br />') AS 'biblionumbers',
  GROUP_CONCAT(DISTINCT t.publicationyear SEPARATOR '<br />') as copyright,
  GROUP_CONCAT(DISTINCT b.author SEPARATOR '<br />') as author,
  GROUP_CONCAT(DISTINCT i.ccode SEPARATOR '<br />') as ccode,
  GROUP_CONCAT(DISTINCT i.itype SEPARATOR '<br />') as ITEM_TYPE,
  GROUP_CONCAT(DISTINCT i.homebranch SEPARATOR '<br />') as homebranches,
  count(DISTINCT b.biblionumber)
FROM biblio b 
  LEFT JOIN items i USING(biblionumber)
  LEFT JOIN biblioitems t USING(biblionumber)
WHERE (i.ccode NOT IN ('ERESOURCE','DLVIDEO','DLAUDIO','DLBOOK','DLMUSIC'))
GROUP BY CONCAT(trim(b.title))
HAVING (count(DISTINCT b.biblionumber) > 1) AND homebranches LIKE '%corning%'


























