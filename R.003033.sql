/*
R.003033

----------

Name: GHW - Fixing 856u
Created by: George Williams

----------

Group: Administrative Reports
     -

Created on: 2018-01-08 16:23:36
Modified on: 2018-01-08 16:29:48
Date last run: 2018-05-04 17:41:43

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  CONCAT("Edit in new window") AS LINK,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="856"]//subfield[@code="u"]') AS URI
FROM
  biblio_metadata
WHERE
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="856"]//subfield[@code="u"]') LIKE "%overdrive%"
GROUP BY
  biblio_metadata.biblionumber

























