/*
R.003848

----------

Name: Titles with X in position 6 of the LDR
Created by: George Williams

----------

Group: -
     -

Created on: 2024-06-19 09:18:19
Modified on: 2024-06-19 14:45:05
Date last run: 2025-07-22 13:54:07

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) AS LDR_POSITION_6,
  biblio_metadata.biblionumber AS BIBLIO_NUMBER,
  Concat(
    'Title'
  ) AS LINK,
  ExtractValue(biblio_metadata.metadata, '//leader') AS LDR,
  ExtractValue(metadata,'//controlfield[@tag="006"]') AS FIELD_006,
  ExtractValue(metadata,'//controlfield[@tag="007"]') AS FIELD_007,
  ExtractValue(metadata,'//controlfield[@tag="008"]') AS FIELD_008,
  biblio.author,
  biblio.title,
  ExtractValue(metadata,'//datafield[@tag="942"]/subfield[@code="c"]') AS BIB_ITYPE
FROM
  biblio_metadata JOIN
  biblio ON biblio_metadata.biblionumber = biblio.biblionumber
WHERE
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) = &lt;&gt;

























