/*
R.003638

----------

Name: 2022 cleanup - biblio type
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-01-05 00:33:22
Modified on: 2022-01-26 21:36:28
Date last run: 2022-10-24 17:10:37

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblio_metadata.biblionumber,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="c"]') AS metadata,
  Group_Concat(DISTINCT items.itype) AS Group_Concat_itype,
  Group_Concat(DISTINCT items.ccode) AS Group_Concat_ccode
FROM
  biblio_metadata JOIN
  items ON items.biblionumber = biblio_metadata.biblionumber
WHERE
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="c"]') = 'AUDIOBOOK' OR
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="c"]') = 'AUDIOBOOK'
GROUP BY
  biblio_metadata.biblionumber

























