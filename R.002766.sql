/*
R.002766

----------

Name: GHW - PAOLA - Carousel Numbers
Created by: George H Williams

----------

Group: -
     -

Created on: 2016-09-08 10:00:42
Modified on: 2017-12-19 09:34:17
Date last run: 2018-07-06 10:36:25

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  items.copynumber,
  items.itemcallnumber,
  Concat_Ws(' ', biblio.title, ExtractValue(biblio_metadata.metadata,'//datafield[@tag="245"]/subfield[@code="b"]'),ExtractValue(biblio_metadata.metadata,'//datafield[@tag="245"]/subfield[@code="p"]'),ExtractValue(biblio_metadata.metadata,'//datafield[@tag="245"]/subfield[@code="n"]')) AS FULL_TITLE,
  items.barcode,
  items.onloan,
  items.itemlost,
  items.damaged
FROM
  items JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber JOIN
  biblio_metadata
    ON biblio_metadata.biblionumber = biblio.biblionumber AND
    items.biblionumber = biblio_metadata.biblionumber
WHERE
  items.homebranch = 'PAOLA' AND
  items.copynumber IS NOT NULL
GROUP BY
  items.copynumber, items.itemcallnumber, items.onloan, items.itemlost,
  items.damaged, items.homebranch
ORDER BY
  items.copynumber

























