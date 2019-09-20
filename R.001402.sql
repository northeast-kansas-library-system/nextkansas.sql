/*
R.001402

----------

Name: Missing Replacement Prices
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Fix Items

Created on: 2012-05-14 22:08:03
Modified on: 2017-07-21 16:14:56
Date last run: 2019-09-18 11:19:13

----------

Public: 0
Expiry: 0

----------

Missing Replacement Price: Enhanced -- Choose branch. Can edit items directly linked from this report. (On Reports Webpages, 5/14/12) #cleanup

----------
*/

SELECT
  Concat('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=', biblio.biblionumber,'&itemnumber=', items.itemnumber, '#edititem\" target="_blank">', "Click to edit", '</a>') AS "edit barcode",
  items.barcode,
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  items.dateaccessioned,
  biblioitems.publicationyear,
  items.price,
  items.replacementprice
FROM
  items
  LEFT JOIN biblio ON items.biblionumber = biblio.biblionumber
  LEFT JOIN biblioitems ON biblio.biblionumber = biblioitems.biblionumber
WHERE
  items.homebranch LIKE <<Choose library|ZBRAN>> AND
  Coalesce(items.replacementprice, 0) >= <<Replacement price greater than or equal to:>> AND
  Coalesce(items.replacementprice, 0) <= <<Replacement price greater than or equal to:>>
GROUP BY
  items.itemnumber
ORDER BY
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title



