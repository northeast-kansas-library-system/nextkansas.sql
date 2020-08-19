/*
R.003326

----------

Name: GHW - 942e phase 4
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-05-09 21:22:43
Modified on: 2020-05-09 22:33:38
Date last run: 2020-05-09 22:33:42

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  items.biblionumber,
  Group_Concat(DISTINCT items.location ORDER BY items.location ASC) AS LOCATIONS,
  GROUP_CONCAT(DISTINCT items.itemcallnumber ORDER BY items.itemcallnumber ASC) AS Group_Concat_itemcallnumber,
  Count(items.location) AS COUNTT,
  Count(DISTINCT items.location) AS COUNTD,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="e"]') AS BIBLOCATION
FROM
  items JOIN
  biblio_metadata ON biblio_metadata.biblionumber = items.biblionumber
GROUP BY
  items.biblionumber
HAVING
  Count(DISTINCT items.location) > 2



