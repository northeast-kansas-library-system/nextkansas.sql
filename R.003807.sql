/*
R.003807

----------

Name: Control fields - LDR
Created by: George Williams

----------

Group: -
     -

Created on: 2024-03-07 16:01:47
Modified on: 2025-12-28 22:36:04
Date last run: 2025-12-30 21:07:41

----------

Public: 0
Expiry: 300

----------

&lt;div id=""reportinfo"" class=""noprint reportInfo""&gt; 
 
  &lt;div class=""reportInfoContent""&gt; 
 
    &lt;p&gt;Shows LDR positions&lt;/p&gt; 

    &lt;h3&gt;00-04 - Record length&lt;/h3&gt;
 
    &lt;h3&gt;05 - Record status&lt;/h3&gt;
 
    &lt;ul&gt; 
      &lt;li&gt;a - Increase in encoding level&lt;/li&gt; 
      &lt;li&gt;c - Corrected or revised&lt;/li&gt; 
      &lt;li&gt;d - Deleted&lt;/li&gt; 
    &lt;/ul&gt; 

    &lt;h3&gt;06 - Type of record&lt;/h3&gt;

    &lt;ul&gt;
      &lt;li&gt;a - Language material&lt;/li&gt; 
      &lt;li&gt;c - Notated music&lt;/li&gt; 
      &lt;li&gt;d - Manuscript notated music&lt;/li&gt; 
      &lt;li&gt;  e - Cartographic material&lt;/li&gt; 
      &lt;li&gt;f - Manuscript cartographic material&lt;/li&gt; 
      &lt;li&gt;g - Projected medium&lt;/li&gt; 
      &lt;li&gt;i - Nonmusical sound recording&lt;/li&gt; 
      &lt;li&gt;j - Musical sound recording&lt;/li&gt; 
      &lt;li&gt;k - Two-dimensional nonprojectable graphic&lt;/li&gt; 
      &lt;li&gt;m - Computer file&lt;/li&gt; 
      &lt;li&gt;o - Kit&lt;/li&gt; 
      &lt;li&gt;p - Mixed materials&lt;/li&gt; 
      &lt;li&gt;r - Three-dimensional artifact or naturally occurring object&lt;/li&gt; 
      &lt;li&gt;t - Manuscript language material&lt;/li&gt; 
    &lt;/ul&gt;
    
    &lt;h3&gt;07 - Bibliographic level&lt;/h3&gt;
 
    &lt;ul&gt; 
      &lt;li&gt;a - Monographic component part&lt;/li&gt; 
      &lt;li&gt;b - Serial component part&lt;/li&gt; 
      &lt;li&gt;c - Collection&lt;/li&gt; 
      &lt;li&gt;d - Subunit&lt;/li&gt; 
      &lt;li&gt;i - Integrating resource&lt;/li&gt; 
      &lt;li&gt;m - Monograph/Item&lt;/li&gt; 
      &lt;li&gt;s - Serial&lt;/li&gt; 
    &lt;/ul&gt; 

    &lt;h3&gt;08 - Type of control&lt;/h3&gt;
 
    &lt;ul&gt; 
      &lt;li&gt;# - No specified type&lt;/li&gt; 
      &lt;li&gt;a - Archival&lt;/li&gt; 
    &lt;/ul&gt; 

    &lt;h3&gt;09 - Character coding scheme&lt;/h3&gt;
 
    &lt;ul&gt; 
      &lt;li&gt;# - MARC-8&lt;/li&gt; 
      &lt;li&gt;a - UCS/Unicode&lt;/li&gt; 
    &lt;/ul&gt; 

    &lt;h3&gt;10 - Indicator count&lt;/h3&gt;
 
    &lt;ul&gt; 
      &lt;li&gt;2 - Number of character positions used for indicators&lt;/li&gt; 
    &lt;/ul&gt; 

    &lt;h3&gt;11 - Subfield code count&lt;/h3&gt;
 
    &lt;ul&gt; 
      &lt;li&gt;2 - Number of character positions used for a subfield code&lt;/li&gt; 
    &lt;/ul&gt; 

    &lt;h3&gt;12-16 - Base address of data&lt;/h3&gt;
 
    &lt;ul&gt; 
      &lt;li&gt;[number] - Length of Leader and Directory&lt;/li&gt; 
    &lt;/ul&gt; 

    &lt;h3&gt;17 - Encoding level&lt;/h3&gt;
 
    &lt;ul&gt; 
      &lt;li&gt;# - Full level&lt;/li&gt; 
      &lt;li&gt;1 - Full level, material not examined&lt;/li&gt; 
      &lt;li&gt;2 - Less-than-full level, material not examined&lt;/li&gt; 
      &lt;li&gt;3 - Abbreviated level&lt;/li&gt; 
      &lt;li&gt;4 - Core level&lt;/li&gt; 
      &lt;li&gt;5 - Partial (preliminary) level&lt;/li&gt; 
      &lt;li&gt;7 - Minimal level&lt;/li&gt; 
      &lt;li&gt;8 - Prepublication level&lt;/li&gt; 
      &lt;li&gt;u - Unknown&lt;/li&gt; 
      &lt;li&gt;z - Not applicable&lt;/li&gt; 
    &lt;/ul&gt; 

    &lt;h3&gt;18 - Descriptive cataloging form&lt;/h3&gt;
 
    &lt;ul&gt; 
      &lt;li&gt;# - Non-ISBD&lt;/li&gt; 
      &lt;li&gt;a - AACR 2&lt;/li&gt; 
      &lt;li&gt;c - ISBD punctuation omitted&lt;/li&gt; 
      &lt;li&gt;i - ISBD punctuation included&lt;/li&gt; 
      &lt;li&gt;n - Non-ISBD punctuation omitted&lt;/li&gt; 
      &lt;li&gt;u - Unknown&lt;/li&gt; 
    &lt;/ul&gt; 

    &lt;h3&gt;19 - Multipart resource record level&lt;/h3&gt;
 
    &lt;ul&gt; 
      &lt;li&gt;# - Not specified or not applicable&lt;/li&gt; 
      &lt;li&gt;a - Set&lt;/li&gt; 
      &lt;li&gt;b - Part with independent title&lt;/li&gt; 
      &lt;li&gt;c - Part with dependent title&lt;/li&gt; 
    &lt;/ul&gt; 

    &lt;h3&gt;20 - Length of the length-of-field portion&lt;/h3&gt;
 
    &lt;ul&gt; 
      &lt;li&gt;4 - Number of characters in the length-of-field portion of a Directory entry&lt;/li&gt; 
    &lt;/ul&gt; 

    &lt;h3&gt;21 - Length of the starting-character-position portion&lt;/h3&gt;

    &lt;ul&gt; 
      &lt;li&gt;5 - Number of characters in the starting-character-position portion of a Directory entry&lt;/li&gt; 
    &lt;/ul&gt; 

    &lt;h3&gt;22 - Length of the implementation-defined portion&lt;/h3&gt;

    &lt;ul&gt; 
      &lt;li&gt;0 - Number of characters in the implementation-defined portion of a Directory entry&lt;/li&gt; 
    &lt;/ul&gt; 

    &lt;h3&gt;23 - Undefined&lt;/h3&gt;

    &lt;ul&gt; 
      &lt;li&gt;0 - Undefined&lt;/li&gt; 
    &lt;/ul&gt; 
 
  &lt;/div&gt; 
 
  &lt;div class=""reportInfoNotes""&gt; 
 
    &lt;p&gt; 
 
    &lt;/p&gt; 
 
  &lt;/div&gt; 
 
  &lt;div id=""reportInfoTags""&gt; 
 
    &lt;p style=""display: none;""&gt; 
      #controlfields
    &lt;/p&gt; 
 
  &lt;/div&gt; 
 
  &lt;!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt; 
 
&lt;/div&gt;

----------
*/



SELECT
  Concat( 
    'Bibliographic record' 
  ) AS LINK,
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

























