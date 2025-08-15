/*
R.003807

----------

Name: Control fields - LDR
Created by: George Williams

----------

Group: -
     -

Created on: 2024-03-07 16:01:47
Modified on: 2024-03-18 23:21:41
Date last run: 2025-07-22 11:38:04

----------

Public: 0
Expiry: 300

----------

 
 
   
 
    Shows LDR positions 

    00-04 - Record length
 
    05 - Record status
 
     
      a - Increase in encoding level 
      c - Corrected or revised 
      d - Deleted 
     

    06 - Type of record

    
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
    
    
    07 - Bibliographic level
 
     
      a - Monographic component part 
      b - Serial component part 
      c - Collection 
      d - Subunit 
      i - Integrating resource 
      m - Monograph/Item 
      s - Serial 
     

    08 - Type of control
 
     
      # - No specified type 
      a - Archival 
     

    09 - Character coding scheme
 
     
      # - MARC-8 
      a - UCS/Unicode 
     

    10 - Indicator count
 
     
      2 - Number of character positions used for indicators 
     

    11 - Subfield code count
 
     
      2 - Number of character positions used for a subfield code 
     

    12-16 - Base address of data
 
     
      [number] - Length of Leader and Directory 
     

    17 - Encoding level
 
     
      # - Full level 
      1 - Full level, material not examined 
      2 - Less-than-full level, material not examined 
      3 - Abbreviated level 
      4 - Core level 
      5 - Partial (preliminary) level 
      7 - Minimal level 
      8 - Prepublication level 
      u - Unknown 
      z - Not applicable 
     

    18 - Descriptive cataloging form
 
     
      # - Non-ISBD 
      a - AACR 2 
      c - ISBD punctuation omitted 
      i - ISBD punctuation included 
      n - Non-ISBD punctuation omitted 
      u - Unknown 
     

    19 - Multipart resource record level
 
     
      # - Not specified or not applicable 
      a - Set 
      b - Part with independent title 
      c - Part with dependent title 
     

    20 - Length of the length-of-field portion
 
     
      4 - Number of characters in the length-of-field portion of a Directory entry 
     

    21 - Length of the starting-character-position portion

     
      5 - Number of characters in the starting-character-position portion of a Directory entry 
     

    22 - Length of the implementation-defined portion

     
      0 - Number of characters in the implementation-defined portion of a Directory entry 
     

    23 - Undefined

     
      0 - Undefined 
     
 
   
 
   
 
     
 
     
 
   
 
   
 
     
      #controlfields
     
 
   
 
   
 
 

----------
*/



SELECT
  biblio_metadata.biblionumber AS BIBS,
  ExtractValue(biblio_metadata.metadata, '//leader') AS 'LDR',
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 1 FOR 5 ) AS RECORD_SIZE,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 6 FOR 1 ) AS RECORD_STATUS,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) AS TYPE_OF_RECORD,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 8 FOR 1 ) AS BIB_LEVEL,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 9 FOR 1 ) AS TYPE_OF_CONTROL,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 10 FOR 1 ) AS CODING_SCHEME,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 11 FOR 5 ) AS INDICATOR_SUBFIELD_SIZE,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 18 FOR 1 ) AS ENCODING_LEVEL,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 19 FOR 1 ) AS DESCRIPTIVE_FORM,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 20 FOR 1 ) AS MULTIPART_LEVEL,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 21 FOR 4 ) AS ENTRY_MAPS
FROM
  biblio_metadata
WHERE 
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) LIKE &lt;&gt;
GROUP BY
  biblio_metadata.biblionumber
ORDER BY
  BIBS

























