/*
R.003515

----------

Name: GHW - 942H update
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-06-01 14:14:17
Modified on: 2021-06-03 22:00:17
Date last run: 2021-06-03 22:00:21

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  biblio.biblionumber,
  biblio.medium,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]') AS GMD,
  biblioitems.cn_class,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="h"]') AS CCODEX
FROM
  biblio JOIN
  biblioitems ON biblioitems.biblionumber = biblio.biblionumber JOIN
  biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
WHERE
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="h"]') LIKE "%VIDPLAYER%"



