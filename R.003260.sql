/*
R.003260

----------

Name: admin report
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-09-06 22:12:52
Modified on: 2019-09-06 22:22:55
Date last run: 2019-11-15 22:24:04

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">', items.barcode, '</a>') AS 'CLICKABLEBC',
  Concat_WS("<br />",
    items.location,
    items.itype,
    authorised_values.lib,
    items.itemcallnumber,
    biblio.author,
    biblio.title
  ) AS ITEM_INFO,
  Concat_WS("<br />",
    Concat("Home: ", items.homebranch),
    Concat("From: ", branchtransfers.frombranch),
    Concat("To: ", branchtransfers.tobranch),
    Concat("Shipped on: ", branchtransfers.datesent)
  ) AS SENT_TO,
  Concat("-",items.barcode,"-") AS BC,
  items.datelastseen
FROM
  (items
  JOIN branchtransfers ON items.itemnumber = branchtransfers.itemnumber)
  JOIN biblio ON items.biblionumber = biblio.biblionumber
  LEFT JOIN authorised_values ON items.ccode = authorised_values.authorised_value
WHERE
  (items.datelastseen <= Now() - INTERVAL 7 DAY) AND
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

























