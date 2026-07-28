/*
R.003966

----------

Name: Fixer
Created by: George Williams

----------

Group: -
     -

Created on: 2026-07-17 16:15:50
Modified on: 2026-07-17 17:23:54
Date last run: 2026-07-17 17:25:59

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblio_metadata.biblionumber AS BIBLIO,
  ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="245"]/subfield[@code="h"]') AS GMD,
  ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="245"]/subfield[@code="a"]') AS A,
  ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="245"]/subfield[@code="h"]') AS H,
  ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="245"]/subfield[@code="b"]') AS B,
  ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="245"]/subfield[@code="n"]') AS N,
  ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="245"]/subfield[@code="p"]') AS P,
  ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="245"]/subfield[@code="c"]') AS C,
  ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="300"]/subfield[@code="a"]') AS DESCRIPTION,
  ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="942"]/subfield[@code="e"]') AS nine_e,
  ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="942"]/subfield[@code="c"]') AS nine_c,
  ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="942"]/subfield[@code="h"]') AS nine_h
FROM
  biblio_metadata
WHERE
  ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="942"]/subfield[@code="c"]') =  <<Item type|itemtypes>> 
GROUP BY
  biblio_metadata.biblionumber
ORDER BY
  nine_h,
  B,
  N,
  P,
  C

























