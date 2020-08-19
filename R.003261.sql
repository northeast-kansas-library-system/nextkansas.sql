/*
R.003261

----------

Name: GHW - Deleted items list by date the item was marked "Lost"
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-09-10 10:46:16
Modified on: 2019-09-10 10:56:32
Date last run: 2020-07-09 12:13:58

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Lists items that have been marked as lost and have been deleted</p>
<ul><li>Shows items marked lost during the date range you specify that have already been deleted</li>
<li>at the library you specify</li>
<li>grouped by item number</li>
<li>sorted in the standard Next classification order</li>
</ul><br />
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3261&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  deleteditems.barcode,
  deleteditems.homebranch,
  deleteditems.holdingbranch,
  location.lib AS LOCATION,
  itemtypes.description AS ITYPE,
  ccode.lib AS CCODE,
  deleteditems.itemcallnumber,
  Coalesce(biblio.author, deletedbiblio.author) AS AUTHOR,
  Coalesce(biblio.title, deletedbiblio.title) AS TITLE,
  deleteditems.price,
  deleteditems.replacementprice,
  deleteditems.timestamp AS DELETED_ON,
  losts.lib,
  deleteditems.itemlost_on,
  deleteditems.withdrawn,
  deleteditems.withdrawn_on
FROM
  deleteditems
  LEFT JOIN biblio
    ON deleteditems.biblionumber = biblio.biblionumber
  LEFT JOIN deletedbiblio
    ON deleteditems.biblionumber = deletedbiblio.biblionumber
  LEFT JOIN itemtypes
    ON deleteditems.itype = itemtypes.itemtype
  LEFT JOIN (
    SELECT
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE'
    GROUP BY
      authorised_values.authorised_value,
      authorised_values.lib
  ) ccode
    ON deleteditems.ccode = ccode.authorised_value
  LEFT JOIN (
    SELECT
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC'
    GROUP BY
      authorised_values.authorised_value,
      authorised_values.lib
  ) location
    ON deleteditems.location = location.authorised_value
  LEFT JOIN (
    SELECT
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOST'
  ) losts
    ON losts.authorised_value = deleteditems.itemlost
WHERE
  deleteditems.homebranch LIKE <<Choose item home library|LBRANCH>> AND
  Coalesce(deleteditems.location, "-") LIKE <<Choose location|LLOC>> AND
  Coalesce(deleteditems.itype, "-") LIKE <<Choose item type|LITYPES>> AND
  Coalesce(deleteditems.ccode, "-") LIKE <<Choose collection code|LCCODE>> AND
  deleteditems.itemlost_on BETWEEN <<Between the beginning of the day on|date>> AND (<<and the end of the day on|date>> + INTERVAL 1 DAY)
GROUP BY
  deleteditems.itemnumber
ORDER BY
  deleteditems.homebranch,
  LOCATION,
  ITYPE,
  CCODE,
  AUTHOR,
  TITLE,
  deleteditems.itemcallnumber



