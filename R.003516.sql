/*
R.003516

----------

Name: GHW - SQL testing from wiki
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-06-04 08:59:07
Modified on: 2021-06-04 09:01:52
Date last run: 2021-06-04 09:08:04

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT count(DISTINCT reserves.borrowernumber) AS HOLDCOUNT,
     count(DISTINCT items.itemnumber) AS ITEMCOUNT,
     (COUNT(DISTINCT reserves.borrowernumber) / count(DISTINCT items.itemnumber)) AS RATIO,
     biblio.title,
     CONCAT( '<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber,'\" target="_blank">', biblio.biblionumber, '</a>' ) AS 'LINK_TO_BIBLIO',
     GROUP_CONCAT(DISTINCT items.homebranch SEPARATOR ' // ') AS HOMEBRANCHES,
     GROUP_CONCAT(DISTINCT items.location SEPARATOR ' // ') AS LOCATIONS,
     GROUP_CONCAT(DISTINCT items.itype SEPARATOR ' // ') AS ITYPES,
     GROUP_CONCAT(DISTINCT items.itemcallnumber SEPARATOR ' // ') AS CALLNUMBERS,
     GROUP_CONCAT(DISTINCT items.notforloan SEPARATOR ' // ') AS NOTLOAN
  FROM  reserves LEFT JOIN items ON items.biblionumber=reserves.biblionumber 
     LEFT JOIN biblio ON reserves.biblionumber=biblio.biblionumber
  WHERE items.itemlost=0 
     AND items.damaged=0
  GROUP BY biblio.biblionumber
  HAVING (COUNT(DISTINCT reserves.borrowernumber) / count(DISTINCT items.itemnumber))>3
  ORDER BY RATIO DESC



