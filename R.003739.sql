/*
R.003739

----------

Name: LINKED authorities
Created by: George Williams

----------

Group: -
     -

Created on: 2023-06-17 19:57:02
Modified on: 2023-06-17 19:57:02
Date last run: 2023-06-26 14:32:23

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  biblio_metadata.biblionumber,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="100"]/subfield[@code="9"]') As '100',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="110"]/subfield[@code="9"]') As '110',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="111"]/subfield[@code="9"]') As '111',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="130"]/subfield[@code="9"]') As '130',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="240"]/subfield[@code="9"]') As '240',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="243"]/subfield[@code="9"]') As '243',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="400"]/subfield[@code="9"]') As '400',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="410"]/subfield[@code="9"]') As '410',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="411"]/subfield[@code="9"]') As '411',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="440"]/subfield[@code="9"]') As '440',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="600"]/subfield[@code="9"]') As '600',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="610"]/subfield[@code="9"]') As '610',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="611"]/subfield[@code="9"]') As '611',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="630"]/subfield[@code="9"]') As '630',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="648"]/subfield[@code="9"]') As '648',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="650"]/subfield[@code="9"]') As '650',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="651"]/subfield[@code="9"]') As '651',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="654"]/subfield[@code="9"]') As '654',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="655"]/subfield[@code="9"]') As '655',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="656"]/subfield[@code="9"]') As '656',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="657"]/subfield[@code="9"]') As '657',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="658"]/subfield[@code="9"]') As '658',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="662"]/subfield[@code="9"]') As '662',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="690"]/subfield[@code="9"]') As '690',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="691"]/subfield[@code="9"]') As '691',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="696"]/subfield[@code="9"]') As '696',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="697"]/subfield[@code="9"]') As '697',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="698"]/subfield[@code="9"]') As '698',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="699"]/subfield[@code="9"]') As '699',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="700"]/subfield[@code="9"]') As '700',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="710"]/subfield[@code="9"]') As '710',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="711"]/subfield[@code="9"]') As '711',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="730"]/subfield[@code="9"]') As '730',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="796"]/subfield[@code="9"]') As '796',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="797"]/subfield[@code="9"]') As '797',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="798"]/subfield[@code="9"]') As '798',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="799"]/subfield[@code="9"]') As '799',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="800"]/subfield[@code="9"]') As '800',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="830"]/subfield[@code="9"]') As '830',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="810"]/subfield[@code="9"]') As '810',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="811"]/subfield[@code="9"]') As '811',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="896"]/subfield[@code="9"]') As '896',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="897"]/subfield[@code="9"]') As '897',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="898"]/subfield[@code="9"]') As '898',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="899"]/subfield[@code="9"]') As '899'
From
  biblio_metadata
Where
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="100"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="110"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="111"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="130"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="240"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="243"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="400"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="410"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="411"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="440"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="600"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="610"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="611"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="630"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="648"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="650"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="651"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="654"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="655"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="656"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="657"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="658"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="662"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="690"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="691"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="696"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="697"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="698"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="699"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="700"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="710"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="711"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="730"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="796"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="797"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="798"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="799"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="800"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="830"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="810"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="811"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="896"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="897"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="898"]/subfield[@code="9"]') Not Like '') Or
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="899"]/subfield[@code="9"]') Not Like '')
Group By
  biblio_metadata.biblionumber

























