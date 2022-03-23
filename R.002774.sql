/*
R.002774

----------

Name: GHW - Missing In Transit last 6 months list
Created by: George H Williams

----------

Group: Circulation
     Transfers

Created on: 2016-09-14 09:59:41
Modified on: 2022-03-22 14:52:03
Date last run: 2022-03-21 17:27:43

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Report is inaccurate since last upgrade.  Work is in progress to correct issues.</p>
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

























