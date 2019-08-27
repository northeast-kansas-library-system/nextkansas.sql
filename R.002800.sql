/*
R.002800

----------

Name: GHW - TEST
Created by: George H Williams

----------

Group: -
     -

Created on: 2016-10-10 17:15:09
Modified on: 2017-12-19 09:34:57
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  items.biblionumber,
  items.barcode,
  items.itemnotes,
  biblio_metadata.metadata,
  ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="526"]/subfield[@code="a"]') AS metadata1
FROM
  items INNER JOIN
  biblio_metadata
    ON items.biblionumber = biblio_metadata.biblionumber INNER JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber AND biblio_metadata.biblionumber =
    biblio.biblionumber
WHERE
  items.itemnotes LIKE 'AR %'



