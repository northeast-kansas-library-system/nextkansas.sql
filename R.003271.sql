/*
R.003271

----------

Name: ADMINREPORT - Media 942c
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-09-30 01:41:46
Modified on: 2019-10-04 14:20:40
Date last run: 2019-10-04 14:20:42

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  CONCAT('') AS biblionumber,
  COUNT(*) AS BIB_ITYPE
FROM
  biblio_metadata
WHERE
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="c"]') = 'MEDIA'
UNION
SELECT
  biblio_metadata.biblionumber,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="c"]') AS BIB_ITYPE
FROM
  biblio_metadata
WHERE
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="c"]') = 'MEDIA'
GROUP BY
  biblio_metadata.biblionumber
LIMIT 1999



