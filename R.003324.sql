/*
R.003324

----------

Name: GHW - 942 fix part 3
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-05-03 23:35:39
Modified on: 2020-05-09 20:56:12
Date last run: 2021-10-14 13:29:12

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  items.biblionumber,
  Group_Concat(DISTINCT items.location) AS LOCATIONS,
  Count(items.location) AS COUNTT,
  Count(DISTINCT items.location) AS COUNTD,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="e"]') AS BIBLOCATION
FROM
  items JOIN
  biblio_metadata ON biblio_metadata.biblionumber = items.biblionumber
GROUP BY
  items.biblionumber
HAVING
  Count(DISTINCT items.location) = 1 AND
  LOCATIONS <> BIBLOCATION AND
  Group_Concat(DISTINCT items.location) = <<Choose bib level shelving location|BIBLOC>>

























