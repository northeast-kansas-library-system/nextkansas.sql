/*
R.003137

----------

Name: Indicators ADMINREPORT
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-11-28 10:05:20
Modified on: 2018-11-28 17:17:25
Date last run: 2018-11-28 17:17:27

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblio_metadata.biblionumber AS biblionumber1,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/@ind2') AS SECOND_IND,
  REGEXP_REPLACE(Concat_Ws(" ", ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="a"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]')), '[[:space:]]+', ' ')
  AS FULL_TITLE
FROM
  biblio_metadata
WHERE
  (biblio_metadata.biblionumber > 959565 AND
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/@ind2') <> 2 AND
  REGEXP_REPLACE(Concat_Ws(" ", ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="a"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]')), '[[:space:]]+', ' ')
  LIKE "A %") OR
  (biblio_metadata.biblionumber > 959565 AND
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/@ind2') <> 3 AND
  REGEXP_REPLACE(Concat_Ws(" ", ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="a"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]')), '[[:space:]]+', ' ')
  LIKE "An %") OR
  (biblio_metadata.biblionumber > 959565 AND
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/@ind2') <> 4 AND
  REGEXP_REPLACE(Concat_Ws(" ", ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="a"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]')), '[[:space:]]+', ' ')
  LIKE "The %")
GROUP BY
  biblio_metadata.biblionumber
ORDER BY
  FULL_TITLE

























