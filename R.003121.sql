/*
R.003121

----------

Name: GHW - ADMINREPORT
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-09-18 09:43:36
Modified on: 2018-12-09 21:10:37
Date last run: 2018-12-09 21:11:51

----------

Public: 0
Expiry: 300

----------



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

























