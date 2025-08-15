/*
R.003809

----------

Name: Count by LDR position 6 - Type of record
Created by: George Williams

----------

Group: -
     -

Created on: 2024-03-08 17:09:40
Modified on: 2024-06-19 15:21:38
Date last run: 2024-09-18 09:08:11

----------

Public: 0
Expiry: 300

----------

 

Valid data =

    
      a - Language material 
      c - Notated music 
      d - Manuscript notated music 
      e - Cartographic material 
      f - Manuscript cartographic material 
      g - Projected medium 
      i - Nonmusical sound recording 
      j - Musical sound recording 
      k - Two-dimensional nonprojectable graphic 
      m - Computer file 
      o - Kit 
      p - Mixed materials 
      r - Three-dimensional artifact or naturally occurring object 
      t - Manuscript language material 
    





----------
*/



SELECT
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) AS metadata,
  Count(biblio_metadata.biblionumber) AS BIBS,
  CASE
    WHEN SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) = 'a' THEN 'a - Language material' 
    WHEN SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) = 'c' THEN 'c - Notated music' 
    WHEN SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) = 'd' THEN 'd - Manuscript notated music' 
    WHEN SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) = 'e' THEN 'e - Cartographic material' 
    WHEN SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) = 'f' THEN 'f - Manuscript cartographic material' 
    WHEN SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) = 'g' THEN 'g - Projected medium' 
    WHEN SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) = 'i' THEN 'i - Nonmusical sound recording'
    WHEN SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) = 'j' THEN 'j - Musical sound recording' 
    WHEN SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) = 'k' THEN 'k - Two-dimensional nonprojectable graphic' 
    WHEN SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) = 'm' THEN 'm - Computer file' 
    WHEN SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) = 'o' THEN 'o - Kit' 
    WHEN SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) = 'p' THEN 'p - Mixed materials' 
    WHEN SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) = 'r' THEN 'r - Three-dimensional artifact or naturally occurring object' 
    WHEN SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) = 't' THEN 't - Manuscript language material' 
    ELSE Concat('',  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ), ' - Invalid code')
  END AS LDR_POSITION_6, 
  Concat( 
    'Report 3848' 
  ) AS LINK 
FROM
  biblio_metadata
GROUP BY
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 )
ORDER BY
  metadata

























