/*
R.003514

----------

Name: CCODE changer
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-06-01 10:53:32
Modified on: 2021-07-29 15:52:04
Date last run: 2021-07-29 15:52:07

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  items.itemnumber,
  items.ccode,
  items.itype,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]') AS GMD
FROM
  items JOIN
  biblio_metadata ON biblio_metadata.biblionumber = items.biblionumber
WHERE
  items.ccode LIKE '%DVD%' AND
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]') LIKE "%(DVD)%"



