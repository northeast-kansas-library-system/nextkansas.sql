/*
R.003132

----------

Name: SDR
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-10-21 12:30:56
Modified on: 2018-10-21 12:30:56
Date last run: 2019-07-03 10:19:25

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  items.biblionumber,
  items.homebranch,
  items.itype,
  Concat_Ws('<br />', items.location, authorised_values.lib, items.itemcallnumber) AS CALL_NUMBER,
  biblio.author,
  biblio.title,
  items.itemnotes,
  items.itemnotes_nonpublic,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="526"]//subfield[@code="a"]') AS PROGRAM,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="526"]//subfield[@code="b"]') AS INTEREST_LEVEL,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="526"]//subfield[@code="c"]') AS READING_LEVEL,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="526"]//subfield[@code="d"]') AS POINTS,
  Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber,
  '\" target="_blank">Go to staff client</a>') AS LINK_TO_STAFF,
  Concat('<a href=\"https://nextkansas.org/cgi-bin/koha/opac-detail.pl?biblionumber=', biblio.biblionumber,
  '\" target="_blank">Go to OPAC</a>') AS LINK_TO_OPAC
FROM
  items
  JOIN biblio ON items.biblionumber = biblio.biblionumber
  JOIN authorised_values ON items.ccode = authorised_values.authorised_value
  JOIN biblio_metadata ON items.biblionumber = biblio_metadata.biblionumber
WHERE
  authorised_values.category = "CCODE"
GROUP BY
  items.biblionumber,
  items.itemnumber
ORDER BY
  PROGRAM,
  INTEREST_LEVEL,
  READING_LEVEL,
  POINTS



