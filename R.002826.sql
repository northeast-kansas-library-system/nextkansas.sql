/*
R.002826

----------

Name: GHW - Item data by barcode number
Created by: George H Williams

----------

Group: Catalog Records and Items
     Fix Items

Created on: 2016-11-15 16:53:28
Modified on: 2018-04-16 11:05:31
Date last run: 2019-02-18 15:29:37

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Shows information on an item based on its barcode number</p>
<ul><li>shows current data on that item's record</li>
<li>on any item in NExpress</li>
<li>sorted by homebranch, shelving location, item type, collection code, call number, author, and title</li>
<li>contains links to the bibliographic record of the item</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>This report was created to help find items while we work through our indexing problems.</p>
<p>The input field in this report can accept the standard SQL wildcard characters (%, _, [charlist], [^charlist], [!charlist]).</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2826&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
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
  Coalesce(items.barcode, '') LIKE <<Enter item barcode number (you can use SQL wildcards)>>
ORDER BY
  HOMEBRANCH,
  LOCATION,
  ITYPE,
  CCODE,
  CALL_NUMBER,
  biblio.author,
  biblio.title



