/*
R.003808

----------

Name: 000 Sandbox ADMINREPORT
Created by: George Williams

----------

Group: -
     -

Created on: 2024-03-08 17:09:02
Modified on: 2024-03-08 17:09:02
Date last run: 2025-05-12 11:40:06

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblio_metadata.biblionumber AS BIBS,
  ExtractValue(biblio_metadata.metadata, '//leader') AS 'LDR',
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 1 FOR 5 ) AS
  RECORD_SIZE,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 6 FOR 1 ) AS
  RECORD_STATUS,
  CASE
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 'a'
    THEN 'Language material'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 'c'
    THEN 'Notated music'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 'd'
    THEN 'Manuscript notated music'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 'e'
    THEN 'Cartographic material'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 'f'
    THEN 'Manuscript cartographic material'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 'g'
    THEN 'Projected medium'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 'i'
    THEN 'Nonmusical sound recording'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 'j'
    THEN 'Musical sound recording'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 'k'
    THEN 'Two-dimensional nonprojectable graphic'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 'm'
    THEN 'Computer file'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 'o'
    THEN 'Kit'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 'p'
    THEN 'Mixed materials'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 'r'
    THEN 'Three-dimensional artifact or naturally occurring object'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 't'
    THEN 'Manuscript language material'
    ELSE 'ERROR'
  END AS TYPE_OF_RECORD,
  CASE
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 8 FOR 1
      ) = 'a'
    THEN 'Monographic component part'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 8 FOR 1
      ) = 'b'
    THEN 'Serial component part'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 8 FOR 1
      ) = 'c'
    THEN 'Collection'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 8 FOR 1
      ) = 'd'
    THEN 'Subunit'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 8 FOR 1
      ) = 'i'
    THEN 'Integrating resource'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 8 FOR 1
      ) = 'm'
    THEN 'Monograph/Item'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 8 FOR 1
      ) = 's'
    THEN 'Serial'
    ELSE 'ERROR'
  END ASBIB_LEVEL,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 9 FOR 1 ) AS
  TYPE_OF_CONTROL,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 10
  FOR 1 ) AS CODING_SCHEME,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 11
  FOR 5 ) AS INDICATOR_SUBFIELD_SIZE,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 18
  FOR 1 ) AS ENCODING_LEVEL,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 19
  FOR 1 ) AS DESCRIPTIVE_FORM,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 20
  FOR 1 ) AS MULTIPART_LEVEL,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 21
  FOR 4 ) AS ENTRY_MAPS,
  biblioitems.itemtype
FROM
  biblio_metadata LEFT JOIN
  biblioitems ON biblioitems.biblionumber = biblio_metadata.biblionumber
WHERE
  CASE
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 'a'
    THEN 'Language material'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 'c'
    THEN 'Notated music'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 'd'
    THEN 'Manuscript notated music'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 'e'
    THEN 'Cartographic material'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 'f'
    THEN 'Manuscript cartographic material'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 'g'
    THEN 'Projected medium'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 'i'
    THEN 'Nonmusical sound recording'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 'j'
    THEN 'Musical sound recording'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 'k'
    THEN 'Two-dimensional nonprojectable graphic'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 'm'
    THEN 'Computer file'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 'o'
    THEN 'Kit'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 'p'
    THEN 'Mixed materials'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 'r'
    THEN 'Three-dimensional artifact or naturally occurring object'
    WHEN
      SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1
      ) = 't'
    THEN 'Manuscript language material'
    ELSE 'ERROR'
  END = 'Projected medium' AND
  biblioitems.itemtype NOT LIKE 'NVID%'
GROUP BY
  biblio_metadata.biblionumber,
  biblioitems.itemtype
ORDER BY
  BIBS

























