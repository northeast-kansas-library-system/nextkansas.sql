/*
R.002774

----------

Name: GHW - Missing In Transit last 6 months list
Created by: George H Williams

----------

Group: Circulation
     Transfers

Created on: 2016-09-14 09:59:41
Modified on: 2018-12-14 11:06:35
Date last run: 2019-10-17 15:46:44

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Generates a list of missing in transit items owned by a library, shipped from a library, or shipped to a library</p>
<ul><li>Shows items that have been in transit between 7 and 180 days ago</li>
<li>Shows items owned by, shipped from, or shipped to the library you specify</li>
<li>grouped by item barcode</li>
<li>sorted by standard NExpress classification</li>
<li>contains links to the item's bibliographic record</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Use this list to generate a list of items to search for on the shelves at your library</p>
<p>Use report 2945 to generate an e-mail message to send to other libraries</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2774&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">', items.barcode, '</a>') AS 'CLICKABLEBC',
  items.location,
  items.itype,
  authorised_values.lib AS COLLECTION_CODE,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  Concat("-",items.barcode,"-") AS BC,
  items.homebranch AS OWNED_BY,
  branchtransfers.frombranch AS SENT_FROM,
  branchtransfers.datesent AS SHIPPED_DATE,
  branchtransfers.tobranch AS SENT_TO,
  items.datelastseen
FROM
  (items
  JOIN branchtransfers ON items.itemnumber = branchtransfers.itemnumber)
  JOIN biblio ON items.biblionumber = biblio.biblionumber
  LEFT JOIN authorised_values ON items.ccode = authorised_values.authorised_value
WHERE
  (items.datelastseen BETWEEN NOW() - INTERVAL 180 DAY AND Now() - INTERVAL 7 DAY) AND
  authorised_values.category = "ccode" AND
  branchtransfers.datearrived IS NULL AND
  ((items.homebranch = @brn := <<Choose your library|branches>> COLLATE utf8mb4_unicode_ci) OR
  (branchtransfers.frombranch = @brn) OR
  (branchtransfers.tobranch = @brn))
GROUP BY
  items.barcode
ORDER BY
  items.homebranch,
  items.location,
  items.itype,
  authorised_values.lib,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  items.barcode


