/*
R.002804

----------

Name: GHW - Accelerated Reader - Search by Interest level, Reading level, or Points
Created by: George H Williams

----------

Group: Catalog Records and Items
     Reading Program Reports

Created on: 2016-10-11 19:15:05
Modified on: 2018-10-18 11:26:49
Date last run: 2020-08-13 15:02:55

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Accelerated reader report</p>
<ul><li>Shows items currently in the catalog with "Accelerated Reader" information in the 526a field</li>
<li>at a specified branch</li>
<li>grouped by item home branch, call number information, author, and title</li>
<li>sorted by interest level, grade level, and AR points</li>
<li>contains links to the title's bibliographic record</li>
</ul><br />
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2804&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  items.homebranch,
  items.itype,
  Concat_Ws('<br />', items.location, authorised_values.lib, items.itemcallnumber) AS CALL_NUMBER,
  biblio.author,
  biblio.title,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="526"]//subfield[@code="a"]') AS PROGRAM,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="526"]//subfield[@code="b"]') AS INTEREST_LEVEL,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="526"]//subfield[@code="c"]') AS READING_LEVEL,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="526"]//subfield[@code="d"]') AS POINTS,
  Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">Go to staff client</a>') AS LINK_TO_STAFF,
  Concat('<a href=\"https://nextkansas.org/cgi-bin/koha/opac-detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">Go to OPAC</a>') AS LINK_TO_OPAC
FROM
  items
  JOIN biblio ON items.biblionumber = biblio.biblionumber
  JOIN authorised_values ON items.ccode = authorised_values.authorised_value
  JOIN biblio_metadata ON items.biblionumber = biblio_metadata.biblionumber
WHERE
  items.homebranch LIKE <<Choose item home branch|branches>> AND
  authorised_values.category = "CCODE"
GROUP BY
  items.itemnumber
HAVING
  PROGRAM = "Accelerated Reader" AND
  INTEREST_LEVEL LIKE <<Interest level|ZINTEREST>> AND
  READING_LEVEL LIKE <<Reading level|ZPOINTS>> AND
  POINTS LIKE <<est points|ZPOINTS>>
ORDER BY
  PROGRAM,
  INTEREST_LEVEL,
  READING_LEVEL,
  POINTS



