/*
R.003032

----------

Name: SANDBOX - newsbox
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-01-05 10:34:49
Modified on: 2019-05-29 18:09:59
Date last run: 2019-05-29 18:10:01

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  biblio_metadata.biblionumber,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="520"]/subfield[@code="a"]') AS metadata,
  Length(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="520"]/subfield[@code="a"]')) AS metadata1
FROM
  biblio_metadata
WHERE
  Length(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="520"]/subfield[@code="a"]')) BETWEEN 100 and 250
ORDER BY
  metadata1 DESC



