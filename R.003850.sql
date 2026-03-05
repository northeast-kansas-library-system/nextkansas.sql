/*
R.003850

----------

Name: Report in progress
Created by: George Williams

----------

Group: -
     -

Created on: 2024-06-26 17:56:36
Modified on: 2024-06-27 10:33:39
Date last run: 2024-06-27 10:34:23

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblio_metadata.biblionumber AS BIBS,
  ExtractValue(biblio_metadata.metadata, '//leader') AS 'LDR',
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 1 FOR 5 ) AS  RECORD_SIZE,
  CASE
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 6 FOR 1 ), ' ', '#') = 'a'
    THEN 'a - Increase in encoding level'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 6 FOR 1 ), ' ', '#') = 'c'
    THEN 'c - Corrected or revised'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 6 FOR 1 ), ' ', '#') = 'd' 
    THEN 'd - Deleted'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 6 FOR 1 ), ' ', '#') = 'n' 
    THEN 'n - New'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 6 FOR 1 ), ' ', '#') = 'p' 
    THEN'p - Increase in encoding level from prepublication'
    ELSE Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 6 FOR 1 ), ' ', '#')
  END
  AS RECORD_STATUS,
  CASE
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ), ' ', '#') = 'a'
    THEN 'a - Language material'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ), ' ', '#') = 'c'
    THEN 'c - Notated music'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ), ' ', '#') = 'd'
    THEN 'd - Manuscript notated music'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ), ' ', '#') = 'e'
    THEN 'e - Cartographic material'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ), ' ', '#') = 'f'
    THEN 'f - Manuscript cartographic material'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ), ' ', '#') = 'g'
    THEN 'g - Projected medium'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ), ' ', '#') = 'i'
    THEN 'i - Nonmusical sound recording'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ), ' ', '#') = 'j'
    THEN 'j - Musical sound recording'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ), ' ', '#') = 'k'
    THEN 'k - Two-dimensional nonprojectable graphic'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ), ' ', '#') = 'm'
    THEN 'm - Computer file'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ), ' ', '#') = 'o'
    THEN 'o - Kit'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ), ' ', '#') = 'p'
    THEN 'p - Mixed materials'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ), ' ', '#') = 'r'
    THEN 'r - Three-dimensional artifact or naturally occurring object'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ), ' ', '#') = 't'
    THEN 't - Manuscript language material'
    ELSE Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ), ' ', '#')
  END AS TYPE_OF_RECORD,
  CASE
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 8 FOR 1 ), ' ', '#') = 'a'
    THEN 'a - Monographic component part'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 8 FOR 1 ), ' ', '#') = 'b'
    THEN 'b - Serial component part'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 8 FOR 1 ), ' ', '#') = 'c'
    THEN 'c - Collection'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 8 FOR 1 ), ' ', '#') = 'd'
    THEN 'd - Subunit'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 8 FOR 1 ), ' ', '#') = 'i'
    THEN 'i - Integrating resource'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 8 FOR 1 ), ' ', '#') = 'm'
    THEN 'm - Monograph/Item'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 8 FOR 1 ), ' ', '#') = 's'
    THEN 's - Serial'
    ELSE Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 8 FOR 1 ), ' ', '#')
  END AS BIB_LEVEL,
  CASE 
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 9 FOR 1 ), ' ', '#') = '#'
    THEN '# - No specified type'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 9 FOR 1 ), ' ', '#') = 'a'
    THEN 'a - Archival'
    ELSE Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 9 FOR 1 ), ' ', '#')
  END AS TYPE_OF_CONTROL,
  CASE 
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 10 FOR 1 ), ' ', '#') = '#'
    THEN '# - MARC-8'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 10 FOR 1 ), ' ', '#') = 'a'
    THEN 'a - UCS/Unicode'
    ELSE Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 10 FOR 1 ), ' ', '#')
  END AS CODING_SCHEME,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 11 FOR 7 ) AS INDICATOR_SUBFIELD_SIZE,
  CASE 
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 18 FOR 1 ), ' ', '#') = '#'
    THEN '# - Full level'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 18 FOR 1 ), ' ', '#') = '1'
    THEN '1 - Full level, material not examined'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 18 FOR 1 ), ' ', '#') = '2'
    THEN '2 - Less-than-full level, material not examined'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 18 FOR 1 ), ' ', '#') = '3'
    THEN '3 - Abbreviated level'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 18 FOR 1 ), ' ', '#') = '4'
    THEN '4 - Core level'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 18 FOR 1 ), ' ', '#') = '5'
    THEN '5 - Partial (preliminary) level'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 18 FOR 1 ), ' ', '#') = '7'
    THEN '7 - Minimal level'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 18 FOR 1 ), ' ', '#') = '8'
    THEN '8 - Prepublication level'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 18 FOR 1 ), ' ', '#') = 'u'
    THEN 'u - Unknown'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 18 FOR 1 ), ' ', '#') = 'z'
    THEN 'z - Not applicable'
    ELSE Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 18 FOR 1 ), ' ', '#')
  END AS ENCODING_LEVEL,
  CASE 
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 19 FOR 1 ), ' ', '#') = '#'
    THEN '# - Non-ISBD' 
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 19 FOR 1 ), ' ', '#') = 'a'
    THEN 'a - AACR 2' 
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 19 FOR 1 ), ' ', '#') = 'c'
    THEN 'c - ISBD punctuation omitted' 
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 19 FOR 1 ), ' ', '#') = 'i'
    THEN 'i - ISBD punctuation included' 
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 19 FOR 1 ), ' ', '#') = 'n'
    THEN 'n - Non-ISBD punctuation omitted' 
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 19 FOR 1 ), ' ', '#') = 'u'
    THEN 'u - Unknown' 
    ELSE Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 19 FOR 1 ), ' ', '#')
  END AS DESCRIPTIVE_FORM,
  CASE 
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 20 FOR 1 ), ' ', '#') = '#'
    THEN '# - Not specified or not applicable'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 20 FOR 1 ), ' ', '#') = 'a'
    THEN 'a - Set'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 20 FOR 1 ), ' ', '#') = 'b'
    THEN 'b - Part with independent title'
    WHEN Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 20 FOR 1 ), ' ', '#') = 'c'
    THEN 'c - Part with dependent title'
    ELSE Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 20 FOR 1 ), ' ', '#')
  END  AS MULTIPART_LEVEL,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 21 FOR 4 ) AS ENTRY_MAPS
FROM
  biblio_metadata
WHERE
  biblio_metadata.biblionumber LIKE '%'
  AND Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 6 FOR 1 ), ' ', '#') not in ('a', 'd', 'c', 'n', 'p')
  /&ast; AND Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ), ' ', '#') LIKE '%' &ast;/
  /&ast; AND Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 8 FOR 1 ), ' ', '#') LIKE '%' &ast;/
  /&ast; AND Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 9 FOR 1 ), ' ', '#') LIKE '%' &ast;/
  /&ast; AND Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 10 FOR 1 ), ' ', '#') LIKE '%' &ast;/ 
  /&ast; AND Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 18 FOR 1 ), ' ', '#') LIKE '%' &ast;/
  /&ast; AND Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 19 FOR 1 ), ' ', '#') LIKE '%' &ast;/
  /&ast; AND Replace(SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 20 FOR 1 ), ' ', '#') LIKE '%' &ast;/
GROUP BY
  biblio_metadata.biblionumber
ORDER BY
  BIBS

























