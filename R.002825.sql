/*
R.002825

----------

Name: GHW - Newly added - not indexed
Created by: George H Williams

----------

Group: Catalog Records and Items
     Fix Items

Created on: 2016-11-15 16:41:08
Modified on: 2018-04-16 11:05:33
Date last run: 2020-11-10 15:50:16

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Shows titles that haven't indexed properly since 2016.11.10</p>
<ul><li>Shows items added since 2016.11.10</li>
<li>At the library you specify</li>
<li>sorted by homebranch, shelving location, item type, collection code, call number, author, and title</li>
<li>contains links to the bibliographic record of the item</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>This report was created to help catalogers find items that can't be searched because of the indexing problems we are currently having.</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2825&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">', biblio.biblionumber, '</a>') AS LINK_TO_TITLE,
  biblio.biblionumber,
  Coalesce(items.barcode, '') AS BARCODE,
  Coalesce(items.homebranch, '') AS HOMEBRANCH,
  Coalesce(items.location, '') AS LOCATION,
  Coalesce(items.itype, '') AS ITYPE,
  Coalesce(items.ccode, '') AS CCODE,
  Coalesce(items.itemcallnumber, '') AS CALL_NUMBER,
  biblio.author,
  biblio.title
FROM
  biblio LEFT JOIN
  items
    ON items.biblionumber = biblio.biblionumber INNER JOIN
  biblioitems
    ON biblioitems.biblionumber = biblio.biblionumber
WHERE
  biblio.biblionumber > '769233' AND
  Coalesce(items.homebranch, '') LIKE <<Choose a branch|LBRANCH>>
ORDER BY
  HOMEBRANCH,
  LOCATION,
  ITYPE,
  CCODE,
  CALL_NUMBER,
  biblio.author,
  biblio.title

























