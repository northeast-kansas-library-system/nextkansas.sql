/*
R.002388

----------

Name: unknown
Created by: Heather Braum

----------

Group: -
     -

Created on: 2014-10-05 23:25:44
Modified on: 2019-06-30 21:48:51
Date last run: 2019-06-30 21:48:57

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
 CONCAT(
   '<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=ti&q=',
   TRIM(Replace(Replace(Replace(Replace(Replace(Replace(b.title, "/", ""), ":", "" ), ";", ""), ",", ""), '"', ''), '#', '') ),
   '&sort_by=title_az\" target="_blank">',
   TRIM(Replace(Replace(Replace(Replace(Replace(Replace(b.title, "/", ""), ":", "" ), ";", ""), ",", ""), '"', ''), '#', '') ),'</a>'
 ) AS "Title Search",
 TRIM(Replace(Replace(Replace(Replace(Replace(Replace(b.title, "/", ""), ":", "" ), ";", ""), ",", ""), '"', ''), '#', '') ) AS TITLE, 
 GROUP_CONCAT(DISTINCT b.biblionumber SEPARATOR ', ') AS BIBLIONUMBER,
 GROUP_CONCAT(DISTINCT b.author SEPARATOR ', ') AS AUTHOR,
 GROUP_CONCAT(DIStINCT i.ccode SEPARATOR ', ') AS ITEM_CCODE
FROM biblio b
JOIN items i USING(biblionumber)
WHERE i.ccode NOT IN ('ERESOURCE')
GROUP BY TRIM(Replace(Replace(Replace(Replace(Replace(Replace(b.title, "/", ""), ":", "" ), ";", ""), ",", ""), '"', ''), '#', '') )
HAVING count(DISTINCT b.biblionumber) > 1



