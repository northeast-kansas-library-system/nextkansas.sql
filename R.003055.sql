/*
R.003055

----------

Name: GHW - count of items
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-03-02 15:29:41
Modified on: 2018-03-02 15:29:41
Date last run: 2019-01-15 21:24:55

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', items.biblionumber, '\" target="_blank">',
  items.biblionumber, '</a>') AS LINK_TO_TITLE,
  items.biblionumber,
  items.itemnumber,
  Concat("-", Coalesce(items.barcode, "-"), "-") AS BARCODE,
  items.homebranch,
  Coalesce(items.location, "-") AS LOCATION,
  Coalesce(items.itype, "-") AS ITYPE,
  Coalesce(items.ccode, "-") AS CCODE,
  items.itemcallnumber,
  biblio.author,
  Concat_Ws(" ", biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')) AS FULL_TITLE,
  biblioitems.publicationyear,
  items.itemnotes,
  items.itemnotes_nonpublic,
  Concat('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=', items.biblionumber, '&itemnumber=',
  items.itemnumber, '#edititem\" target="_blank">Edit item</a>') AS EDIT_ITEM,
  copies_in_system.Count_itemnumber AS TOTAL_COPIES_IN_SYSTEM
FROM
  items
  JOIN biblio ON items.biblionumber = biblio.biblionumber
  JOIN biblio_metadata ON items.biblionumber = biblio_metadata.biblionumber
  JOIN biblioitems ON items.biblioitemnumber = biblioitems.biblioitemnumber
  INNER JOIN (SELECT
        items.biblionumber,
        Count(DISTINCT items.itemnumber) AS Count_itemnumber
      FROM
        items
      GROUP BY
        items.biblionumber) copies_in_system ON items.biblionumber = copies_in_system.biblionumber
WHERE
  Coalesce(items.location, "-") LIKE '%' AND
  Coalesce(items.itype, "-") LIKE '%' AND
  Coalesce(items.ccode, "-") LIKE '%' AND
  copies_in_system.Count_itemnumber >= 5
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



