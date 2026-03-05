/*
R.003881

----------

Name: GHW - video test
Created by: George Williams

----------

Group: -
     -

Created on: 2025-04-21 15:07:12
Modified on: 2025-04-21 15:07:12
Date last run: 2025-04-27 00:20:02

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblio.biblionumber,
  biblio.author,
  biblio.title,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]') AS H,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]') AS B,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]') AS N,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]') AS P,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="c"]') AS C,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="e"]') AS B_LOC,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="c"]') AS B_ITYPE,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="h"]') AS B_CCODE,
  Group_Concat(DISTINCT items.permanent_location) AS I_LOC,
  Group_Concat(DISTINCT items.itype) AS I_ITYPE,
  Group_Concat(DISTINCT items.ccode) AS I_CCODE
FROM
  biblio JOIN
  biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber JOIN
  items ON items.biblionumber = biblio.biblionumber
WHERE
  ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="942"]/subfield[@code="c"]') LIKE "NV%"
GROUP BY
  biblio.biblionumber,
  biblio.title
ORDER BY
  biblio.title

























