/*
R.002995

----------

Name: GHW - TEST AR
Created by: George H Williams

----------

Group: -
     -

Created on: 2017-09-11 16:10:54
Modified on: 2017-12-19 09:38:18
Date last run: 2017-09-11 17:03:02

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  items.homebranch,
  items.itype,
  CONCAT_WS('<br />',items.location, authorised_values.lib, items.itemcallnumber) AS CALL_NUMBER,
  biblio.author,
  biblio.title,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="526"]//subfield[@code="a"]') AS PROGRAM,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="526"]//subfield[@code="b"]') AS INTEREST_LEVEL,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="526"]//subfield[@code="c"]') AS READING_LEVEL,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="526"]//subfield[@code="d"]') AS POINTS,
  CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblio.biblionumber,'\" target="_blank">Go to biblio</a>') AS LINK_TO_BIBLIO,
  CONCAT('<a href=\"/cgi-bin/koha/cataloguing/editor.pl#catalog/',biblio.biblionumber,'\" target="_blank">Go to biblio</a>') AS LINK_TO_EDIT
FROM
  biblio_metadata INNER JOIN
  items
    ON items.biblionumber = biblio_metadata.biblionumber INNER JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber JOIN
  authorised_values
    ON items.ccode = authorised_values.authorised_value
WHERE
  items.homebranch LIKE <<Choose item home branch|branches>> AND
  authorised_values.category = "CCODE"
GROUP BY
  items.homebranch, items.location, items.itype, items.ccode,
  items.itemcallnumber, biblio.author, biblio.title
HAVING
  PROGRAM = 'Accelerated Reader' AND
  INTEREST_LEVEL LIKE <<Interest level|ZINTEREST>> AND
  READING_LEVEL LIKE <<Reading level|ZPOINTS>> AND
  POINTS LIKE <<Test points|ZPOINTS>>
ORDER BY
  PROGRAM, INTEREST_LEVEL, READING_LEVEL, POINTS



