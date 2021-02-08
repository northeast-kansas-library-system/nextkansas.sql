/*
R.003263

----------

Name: GHW - 3:1 requests ratio report
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-09-10 11:59:57
Modified on: 2019-11-04 15:28:45
Date last run: 2021-02-06 10:54:07

----------

Public: 0
Expiry: 10

----------

<div id=reportinfo>
<p>Presents a list of items that have a higher than 3:1 requests to copies ratio.</p>
<ul><li>Shows titles that currently have more than 3 requests per copy</li>
<li>system wide</li>
<li>grouped by biblio number</li>
<li>sorted by highest ratio to lowest ratio</li>
<li>contains links to the bibliographic records</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Notes go here.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports= XX PUT REPORTNUMBER HERE and remove XXs and Spaces XX &phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">Link to title</a>') AS 'LINK_TO_TITLE',
  Concat_Ws("<br />", biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]')) AS TITLE,
  Count(DISTINCT reserves.borrowernumber) AS HOLDCOUNT,
  Count(DISTINCT items.itemnumber) AS ITEMCOUNT,
  Concat(Format(Count(DISTINCT reserves.borrowernumber) / Count(DISTINCT items.itemnumber), 2), " : 1") AS RATIO,
  GROUP_CONCAT(DISTINCT items.homebranch SEPARATOR ' // ') AS HOMEBRANCHES,
  GROUP_CONCAT(DISTINCT itypess.description SEPARATOR ' // ') AS ITYPES,
  GROUP_CONCAT(DISTINCT items.itemcallnumber SEPARATOR ' // ') AS CALLNUMBERS,
  GROUP_CONCAT(DISTINCT nfl.lib SEPARATOR ' ') AS NOTLOAN
FROM
  reserves
  LEFT JOIN items
    ON items.biblionumber = reserves.biblionumber
  LEFT JOIN biblio
    ON reserves.biblionumber = biblio.biblionumber
  INNER JOIN biblio_metadata
    ON biblio_metadata.biblionumber = biblio.biblionumber
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'NOT_LOAN'
  ) nfl
    ON nfl.authorised_value = items.notforloan
  LEFT JOIN (
    SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes
  ) itypess
    ON itypess.itemtype = items.itype
WHERE
  items.itemlost = 0 AND
  items.damaged = 0
GROUP BY
  biblio.biblionumber,
  biblio_metadata.metadata
HAVING
  (Count(DISTINCT reserves.borrowernumber) / Count(DISTINCT items.itemnumber)) > 3
ORDER BY
  (Count(DISTINCT reserves.borrowernumber) / Count(DISTINCT items.itemnumber)) DESC



