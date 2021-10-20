/*
R.003046

----------

Name: GHW - 245h project
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-01-23 19:42:44
Modified on: 2018-01-23 19:42:44
Date last run: 2018-01-23 19:43:25

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblio.biblionumber,
  items.itemnumber,
  items.barcode,
  items.homebranch,
  items.itype,
  ccodes.lib AS CCODE,
  items.itemcallnumber,
  biblio.author,
  Concat(biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')) AS FULL_TITLE,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]') AS MEDIUM
FROM
  biblio
  JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
  JOIN items ON items.biblionumber = biblio.biblionumber
  LEFT JOIN (SELECT
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'CCODE'
      GROUP BY
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib) ccodes ON items.ccode = ccodes.authorised_value
WHERE
  (biblio.biblionumber <> 0) AND
  (items.itype LIKE "%MEDIA%" OR
  items.itype LIKE "%1")
GROUP BY
  biblio.biblionumber,
  items.itemnumber
ORDER BY
  items.homebranch,
  items.itype,
  CCODE,
  items.itemcallnumber,
  biblio.author,
  FULL_TITLE

























