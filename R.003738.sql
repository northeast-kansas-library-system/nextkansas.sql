/*
R.003738

----------

Name: AK
Created by: George Williams

----------

Group: -
     -

Created on: 2023-06-16 18:33:58
Modified on: 2023-06-16 18:33:58
Date last run: 2023-06-26 14:32:29

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblio_metadata.biblionumber
FROM
  biblio_metadata
WHERE
  ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="800"]/subfield[@code="9"]') &lt;&gt; ""
GROUP BY
  biblio_metadata.biblionumber

























