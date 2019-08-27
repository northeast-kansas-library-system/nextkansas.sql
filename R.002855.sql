/*
R.002855

----------

Name: GHW - AR
Created by: George H Williams

----------

Group: -
     -

Created on: 2016-12-15 09:57:51
Modified on: 2017-12-19 09:36:57
Date last run: 2017-09-11 13:45:22

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  biblio.biblionumber,
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="526"]//subfield[@code="a"]') AS PROGRAM,
  ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="526"]//subfield[@code="b"]') AS INTEREST_LEVEL,
  ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="526"]//subfield[@code="c"]') AS READING_LEVEL,
  ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="526"]//subfield[@code="d"]') AS POINTS,
  biblio.author,
  biblio.title,
  authorised_values.lib
FROM
  biblio_metadata INNER JOIN
  items
    ON items.biblionumber = biblio_metadata.biblionumber INNER JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber INNER JOIN
  authorised_values
    ON items.ccode = authorised_values.authorised_value
WHERE
  items.homebranch = <<Enter branch code|branches>>
GROUP BY
  biblio.biblionumber, items.homebranch, items.location, items.itype,
  items.ccode, items.itemcallnumber, biblio.author, biblio.title,
  authorised_values.lib
HAVING
  PROGRAM LIKE "AR%"
ORDER BY
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber



