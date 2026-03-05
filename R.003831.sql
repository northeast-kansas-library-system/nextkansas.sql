/*
R.003831

----------

Name: Fixed Fields Helper
Created by: George Williams

----------

Group: -
     -

Created on: 2024-05-05 23:39:26
Modified on: 2025-07-22 14:11:15
Date last run: 2025-07-22 14:27:37

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  biblio.biblionumber,
  items.itemnumber,
  Concat_Ws('<br />', 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag=245]/subfield[@code="a"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag=245]/subfield[@code="n"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag=245]/subfield[@code="p"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag=245]/subfield[@code="h"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag=245]/subfield[@code="b"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag=245]/subfield[@code="c"]')
  ) As TITLE,
  items.permanent_location,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag=942]/subfield[@code="e"]') As BIB_LOC,
  items.itype,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag=942]/subfield[@code="c"]') As BIB_ITYPE,
  items.ccode,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag=942]/subfield[@code="h"]') As BIB_CCODE,
  items.itemcallnumber,
  ExtractValue(biblio_metadata.metadata, '//leader') As 'LDR',
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) AS TYPE_OF_RECORD,
  ExtractValue(biblio_metadata.metadata, '//controlfield[@tag=006]') As '006',
  ExtractValue(biblio_metadata.metadata, '//controlfield[@tag=007]') As '007',
  ExtractValue(biblio_metadata.metadata, '//controlfield[@tag=008]') As '008',
  biblio.frameworkcode,
  items.homebranch
From
  biblio Join
  biblio_metadata On biblio_metadata.biblionumber = biblio.biblionumber Join
  items On items.biblionumber = biblio.biblionumber
Where
  items.homebranch LIKE <<Choose your library|lbranch>> AND 
  (
    SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) NOT IN ('a', 'c', 'd', 'e', 'f', 'g', 'i', 'j', 'k', 'm', 'o', 'p', 'r', 't') OR 
    SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) = ''
  )
Group By
  biblio.biblionumber,
  items.itemnumber,
  items.itemcallnumber
Order By
  items.permanent_location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  TITLE

























