/*
R.002945

----------

Name: GHW - Missing In Transit last 6 months e-mail
Created by: George H Williams

----------

Group: Circulation
     Transfers

Created on: 2017-05-09 21:42:07
Modified on: 2018-12-09 21:17:12
Date last run: 2022-03-03 12:21:04

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Generates e-mail messages for missing in transit items owned by a library, shipped from a library, or shipped to a library</p>
<ul><li>Shows items that have been in transit between 7 and 180 days ago</li>
<li>Shows items owned by, shipped from, or shipped to the library you specify</li>
<li>grouped by item barcode</li>
<li>sorted by standard NExpress classification</li>
<li>contains links to the item's bibliographic record</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Use this list to generate a list of items to search for on the shelves at your library</p>
<p>Use report 2774 to generate a list of items to search for<br /></p>
<p><a href="http://news.nexpresslibrary.org/missing-in-transit-items/"  target="_blank">Open the missing-in-transit report form in a new window</a><br /></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2945&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  CONCAT_WS("<br />", Concat("The following item has been missing in transit for more than 7 days:<br />"),
  Concat("Home Lib: ", items.homebranch),
  Concat("Location: ", items.location),
  Concat("Itemtype: ",  items.itype),
  Concat("CCode: ", authorised_values.lib),
  Concat("Call#: ", items.itemcallnumber),
  Concat("Author: ", biblio.author),
  Concat("Title: ", biblio.title),
  Concat("Bcode: ", items.barcode),
  Concat("Home Lib: ", items.homebranch),
  Concat("Shipped from: ", branchtransfers.frombranch),
  Concat("Shipped to: ", branchtransfers.tobranch),
  Concat("Shipped on:  ", branchtransfers.datesent),
  Concat("Last seen: ", items.datelastseen, "<br />"),
  Concat("Could you please check the shelves at your library for this item?<br /><br />.page.")) AS LETTER_CONTENT
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

























