/*
R.003327

----------

Name: GHW - 942e - Phase 5
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-05-09 23:03:27
Modified on: 2020-05-10 00:27:13
Date last run: 2020-05-10 00:27:17

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  items.biblionumber,
  GROUP_CONCAT(DISTINCT items.location ORDER BY items.location) AS LOCATIONS,
  GROUP_CONCAT(DISTINCT items.permanent_location ORDER BY items.permanent_location) AS PERM_LOCATION,
  GROUP_CONCAT(DISTINCT items.itemcallnumber ORDER BY items.itemcallnumber) AS PERM_LOCATION,
  Count(items.location) AS COUNTT,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="a"]') AS TILE,
  Group_Concat(DISTINCT items.ccode) AS CCODES,
  Count(DISTINCT items.location) AS COUNTD,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="e"]') AS BIBLOCATION
FROM
  items JOIN
  biblio_metadata ON biblio_metadata.biblionumber = items.biblionumber
WHERE
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="e"]') <> "ADULT" AND
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="e"]') <> "CHILDRENS" AND
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="e"]') <> "YOUNGADULT"
GROUP BY
  items.biblionumber

























