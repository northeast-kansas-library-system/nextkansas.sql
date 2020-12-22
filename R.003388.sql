/*
R.003388

----------

Name: GHW - Sandbox
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-11-27 01:04:08
Modified on: 2020-11-27 01:04:08
Date last run: 2020-11-27 01:16:02

----------

Public: 0
Expiry: 300

----------



----------
*/

Select
    biblio.biblionumber,
    biblio.author,
    biblio.title,
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]//subfield[@code="a"]') As TITLEA,
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]//subfield[@code="h"]') As TITLEH,
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]//subfield[@code="b"]') As TITLEB,
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]//subfield[@code="n"]') As TITLEN,
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]//subfield[@code="p"]') As TITLEP,
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]//subfield[@code="c"]') As TITLEC,
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="100"]//subfield[@code="a"]') As AUTHORXA,
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]//subfield[@code="e"]') As LOCATION,
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]//subfield[@code="c"]') As ITYPE,
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]//subfield[@code="h"]') As CCODE,
    Group_Concat(Distinct items.itype) As ITEM_ITYPE,
    Group_Concat(Distinct items.ccode) As ccode1,
    Count(items.itemnumber) As Count_itemnumber,
    items.itemcallnumber
From
    biblio Join
    biblio_metadata On biblio_metadata.biblionumber = biblio.biblionumber Inner Join
    items On items.biblionumber = biblio.biblionumber
Where
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]//subfield[@code="h"]') = ""
Group By
    biblio.biblionumber,
    biblio.author,
    biblio.title,
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]//subfield[@code="a"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]//subfield[@code="h"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]//subfield[@code="b"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]//subfield[@code="n"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]//subfield[@code="p"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]//subfield[@code="c"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="100"]//subfield[@code="a"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]//subfield[@code="e"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]//subfield[@code="c"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]//subfield[@code="h"]'),
    items.itemcallnumber
Having
    Group_Concat(Distinct items.ccode) = 'NONFICTION' And
    Count(items.itemnumber) = 1



