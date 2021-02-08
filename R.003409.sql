/*
R.003409

----------

Name: koha-US test 2203
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-01-15 13:58:19
Modified on: 2021-01-15 13:58:19
Date last run: 2021-01-25 10:17:28

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  biblio_metadata.biblionumber,
  biblio.author,
  biblio.title,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="490"]/@ind1') AS FIRST_INDICATOR,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="490"]/@ind2') AS SECOND_INDICATOR,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="490"]/subfield[@code="a"]') AS SERIES,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="490"]/subfield[@code="v"]') AS VOLUME
FROM
  biblio_metadata JOIN
  biblio ON biblio_metadata.biblionumber = biblio.biblionumber
WHERE
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="490"]/subfield[@code="a"]') NOT LIKE ''
GROUP BY
  biblio_metadata.biblionumber,
  biblio.author,
  biblio.title
ORDER BY
  biblio_metadata.biblionumber,
  biblio.author,
  SERIES



