/*
R.003849

----------

Name: Test for kus
Created by: George Williams

----------

Group: -
     -

Created on: 2024-06-19 11:46:30
Modified on: 2024-06-19 14:47:13
Date last run: 2024-06-19 14:45:28

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) AS metadata, 
  Count(biblio_metadata.biblionumber) AS BIBS, 
  CASE 
    WHEN SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) 
      IN ('a', 'c', 'd', 'e', 'f', 'g', 'i', 'j', 'k', 'm', 'o', 'p', 'r', 't') 
      THEN SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) 
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

























