/*
R.002816

----------

Name: GHW - Quick list of titles by an author
Created by: George H Williams

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2016-11-04 16:40:55
Modified on: 2018-04-16 11:02:00
Date last run: 2020-12-03 10:28:39

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>What it does generates a list of all titles by an author by brief title</p>
<ul><li>Shows items currently in the catalog</li>
<li>shows items at a specified library by a specified author</li>
<li>grouped by classification, call number, author, and title information</li>
<li>sorted by title</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Report created at the request of Baldwin Public Library.</p>
<p>The author's name must be entered as SURNAME, FIRSTNAME or the report will not work</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2816&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  items.location,
  items.itype,
  authorised_values.lib AS COLLECTION_CODE,
  items.itemcallnumber AS CALL_NUMBER,
  biblio.author,
  biblio.title
FROM
  items LEFT JOIN
  biblioitems
    ON items.biblioitemnumber = biblioitems.biblioitemnumber LEFT JOIN
  biblio
    ON biblioitems.biblionumber = biblio.biblionumber LEFT JOIN
  authorised_values
    ON items.ccode = authorised_values.authorised_value
WHERE
  items.homebranch LIKE <<Items owned by|LBRANCH>> AND
  items.itype LIKE <<Enter item type|LITYPES>> AND
  biblio.author LIKE concat('%',<<Enter part of author's name in Last, First format>>, '%') AND
  authorised_values.category = "CCODE"
ORDER BY
  biblio.title

























