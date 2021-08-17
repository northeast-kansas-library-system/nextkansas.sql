/*
R.002942

----------

Name: GHW - Price repair - Excludes Donations and ILL
Created by: George H Williams

----------

Group:  BONNERSPGS
     -

Created on: 2017-05-05 10:10:00
Modified on: 2021-08-16 20:41:45
Date last run: 2017-12-14 15:36:08

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  Concat('<a href=https://staff.nexpresslibrary.org/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=', items.biblionumber, '&itemnumber=', items.itemnumber, '\" target="_blank">', biblio.biblionumber, '</a>') AS LINK_TO_ITEM,
  items.barcode,
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  Concat_Ws(' ', biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')) AS FULL_TITLE,
  items.dateaccessioned,
  Coalesce(items.booksellerid, "-") AS SOURCE,
  Coalesce(items.price, 0) AS PRICE,
  items.price,
  items.replacementprice
FROM
  items
  JOIN biblio ON items.biblionumber = biblio.biblionumber
  JOIN biblioitems ON items.biblioitemnumber = biblioitems.biblioitemnumber
  INNER JOIN biblio_metadata ON items.biblionumber = biblio_metadata.biblionumber
WHERE
  items.dateaccessioned BETWEEN <<Items added after|date>> AND <<but before|date>> AND
  items.homebranch = "BONNERSPGS" AND
  items.location LIKE <<Enter shelving location|LLOC>> AND
  items.itype <> "ILL" AND
  items.ccode LIKE <<Enter item collection code|LCCODE>> AND
  Coalesce(items.price, 0) < .01
GROUP BY
  items.barcode
HAVING
  SOURCE <> "Donation"
ORDER BY
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title
LIMIT 100000



