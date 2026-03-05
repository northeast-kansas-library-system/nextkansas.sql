/*
R.003764

----------

Name: ADMINREPORT test
Created by: George Williams

----------

Group: -
     -

Created on: 2023-10-03 12:07:42
Modified on: 2023-10-03 12:07:42
Date last run: 2023-10-13 12:38:23

----------

Public: 0
Expiry: 300

----------

ADMINREPORT

----------
*/



SELECT
  biblio_metadata.biblionumber,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="100"]/@ind1') AS INDICATORA,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="100"]/@ind2') AS INDICATORB,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="100"]/subfield[@code="a"]') AS SUB_A,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="100"]/subfield[@code="c"]') AS SUB_C,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="100"]/subfield[@code="d"]') AS SUB_D,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="100"]/subfield[@code="e"]') AS SUB_E,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="100"]/subfield[@code="0"]') AS SUB_0,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="100"]/subfield[@code="9"]') AS SUB_9
FROM
  biblio_metadata
WHERE
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="100"]/subfield[@code="0"]') &lt;&gt; ''

























