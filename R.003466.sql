/*
R.003466

----------

Name: GHW - Update bib locations desc
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-02-28 18:30:11
Modified on: 2021-02-28 19:41:52
Date last run: 2021-03-02 10:37:24

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblio_metadata.biblionumber,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="e"]') AS LOC
FROM
  biblio_metadata
WHERE
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="e"]') = 'YOUNGADULT'
ORDER BY
  biblio_metadata.biblionumber DESC
LIMIT 999

























