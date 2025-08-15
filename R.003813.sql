/*
R.003813

----------

Name: NON standard record types
Created by: George Williams

----------

Group: -
     -

Created on: 2024-03-19 20:08:08
Modified on: 2024-03-20 22:32:51
Date last run: 2025-07-23 09:10:27

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  Concat(
    '',
    'Go to record'
  ) AS LINK_1,
  Concat(
    '',
    'Edit record'
  ) AS LINK_2,
  biblio_metadata.biblionumber As BIBS,
  biblio.frameworkcode,
  ExtractValue(biblio_metadata.metadata, '//leader') As 'LDR',
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') From 1 For 5 ) As RECORD_SIZE,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') From 6 For 1 ) As RECORD_STATUS,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') From 7 For 1 ) As TYPE_OF_RECORD,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') From 8 For 1 ) As BIB_LEVEL,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') From 9 For 1 ) As TYPE_OF_CONTROL,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') From 10 For 1 ) As CODING_SCHEME,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') From 11 For 5 ) As INDICATOR_SUBFIELD_SIZE,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') From 18 For 1 ) As ENCODING_LEVEL,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') From 19 For 1 ) As DESCRIPTIVE_FORM,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') From 20 For 1 ) As MULTIPART_LEVEL,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') From 21 For 4 ) As ENTRY_MAPS
From
  biblio_metadata Join
  biblio On biblio_metadata.biblionumber = biblio.biblionumber
Where
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') From 7 For 1 ) Not In ('a', 'c', 'd', 'e', 'f', 'g', 'i', 'j', 'k', 'm', 'o', 'p', 'r', 't')
Group By
  biblio_metadata.biblionumber,
  biblio.frameworkcode
Order By
  biblio.frameworkcode,
  BIBS

























