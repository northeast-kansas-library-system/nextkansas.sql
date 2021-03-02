/*
R.002757

----------

Name: GHW - 245h
Created by: George H Williams

----------

Group: -
     -

Created on: 2016-09-02 17:24:17
Modified on: 2018-01-24 16:59:27
Date last run: 2017-12-18 22:15:38

----------

Public: 0
Expiry: 0

----------

Holds ratio

----------
*/

SELECT
  biblio.biblionumber,
  biblio.author,
  Concat(biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')) AS FULL_TITLE,
  Coalesce(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'), "-") AS MEDIUM
FROM
  biblio
  JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
GROUP BY
  biblio.biblionumber
ORDER BY
  biblio.biblionumber,
  biblio.author,
FULL_TITLE



