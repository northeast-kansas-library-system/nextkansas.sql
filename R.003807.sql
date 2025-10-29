/*
R.003807

----------

Name: Control fields - LDR
Created by: George Williams

----------

Group: -
     -

Created on: 2024-03-07 16:01:47
Modified on: 2025-09-14 17:07:51
Date last run: 2025-09-14 17:06:55

----------

Public: 0
Expiry: 300

----------

<div id=""reportinfo"" class=""noprint reportInfo""> 
 
  <div class=""reportInfoContent""> 
 
    <p>Shows LDR positions</p> 

    <h3>00-04 - Record length</h3>
 
    <h3>05 - Record status</h3>
 
    <ul> 
      <li>a - Increase in encoding level</li> 
      <li>c - Corrected or revised</li> 
      <li>d - Deleted</li> 
    </ul> 

    <h3>06 - Type of record</h3>

    <ul>
      <li>a - Language material</li> 
      <li>c - Notated music</li> 
      <li>d - Manuscript notated music</li> 
      <li>  e - Cartographic material</li> 
      <li>f - Manuscript cartographic material</li> 
      <li>g - Projected medium</li> 
      <li>i - Nonmusical sound recording</li> 
      <li>j - Musical sound recording</li> 
      <li>k - Two-dimensional nonprojectable graphic</li> 
      <li>m - Computer file</li> 
      <li>o - Kit</li> 
      <li>p - Mixed materials</li> 
      <li>r - Three-dimensional artifact or naturally occurring object</li> 
      <li>t - Manuscript language material</li> 
    </ul>
    
    <h3>07 - Bibliographic level</h3>
 
    <ul> 
      <li>a - Monographic component part</li> 
      <li>b - Serial component part</li> 
      <li>c - Collection</li> 
      <li>d - Subunit</li> 
      <li>i - Integrating resource</li> 
      <li>m - Monograph/Item</li> 
      <li>s - Serial</li> 
    </ul> 

    <h3>08 - Type of control</h3>
 
    <ul> 
      <li># - No specified type</li> 
      <li>a - Archival</li> 
    </ul> 

    <h3>09 - Character coding scheme</h3>
 
    <ul> 
      <li># - MARC-8</li> 
      <li>a - UCS/Unicode</li> 
    </ul> 

    <h3>10 - Indicator count</h3>
 
    <ul> 
      <li>2 - Number of character positions used for indicators</li> 
    </ul> 

    <h3>11 - Subfield code count</h3>
 
    <ul> 
      <li>2 - Number of character positions used for a subfield code</li> 
    </ul> 

    <h3>12-16 - Base address of data</h3>
 
    <ul> 
      <li>[number] - Length of Leader and Directory</li> 
    </ul> 

    <h3>17 - Encoding level</h3>
 
    <ul> 
      <li># - Full level</li> 
      <li>1 - Full level, material not examined</li> 
      <li>2 - Less-than-full level, material not examined</li> 
      <li>3 - Abbreviated level</li> 
      <li>4 - Core level</li> 
      <li>5 - Partial (preliminary) level</li> 
      <li>7 - Minimal level</li> 
      <li>8 - Prepublication level</li> 
      <li>u - Unknown</li> 
      <li>z - Not applicable</li> 
    </ul> 

    <h3>18 - Descriptive cataloging form</h3>
 
    <ul> 
      <li># - Non-ISBD</li> 
      <li>a - AACR 2</li> 
      <li>c - ISBD punctuation omitted</li> 
      <li>i - ISBD punctuation included</li> 
      <li>n - Non-ISBD punctuation omitted</li> 
      <li>u - Unknown</li> 
    </ul> 

    <h3>19 - Multipart resource record level</h3>
 
    <ul> 
      <li># - Not specified or not applicable</li> 
      <li>a - Set</li> 
      <li>b - Part with independent title</li> 
      <li>c - Part with dependent title</li> 
    </ul> 

    <h3>20 - Length of the length-of-field portion</h3>
 
    <ul> 
      <li>4 - Number of characters in the length-of-field portion of a Directory entry</li> 
    </ul> 

    <h3>21 - Length of the starting-character-position portion</h3>

    <ul> 
      <li>5 - Number of characters in the starting-character-position portion of a Directory entry</li> 
    </ul> 

    <h3>22 - Length of the implementation-defined portion</h3>

    <ul> 
      <li>0 - Number of characters in the implementation-defined portion of a Directory entry</li> 
    </ul> 

    <h3>23 - Undefined</h3>

    <ul> 
      <li>0 - Undefined</li> 
    </ul> 
 
  </div> 
 
  <div class=""reportInfoNotes""> 
 
    <p> 
 
    </p> 
 
  </div> 
 
  <div id=""reportInfoTags""> 
 
    <p style=""display: none;""> 
      #controlfields
    </p> 
 
  </div> 
 
  <!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --> 
 
</div>

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
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) LIKE <>
GROUP BY
  biblio_metadata.biblionumber
ORDER BY
  BIBS

























