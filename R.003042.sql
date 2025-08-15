/*
R.003042

----------

GHW - search for %efbfbd% characters
Created by: George Williams

----------

Group: -
     -

Created on: 2018-01-17 15:41:49
Modified on: 2018-01-19 08:34:14
Date last run: 2018-11-29 17:04:26

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblio_metadata.biblionumber,
  CONCAT("Go to record") AS LINK
FROM
  biblio_metadata
WHERE
  Hex(biblio_metadata.metadata) LIKE "%efbfbd%"
ORDER BY
  biblio_metadata.biblionumber
  DESC

























