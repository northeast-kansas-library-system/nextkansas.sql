/*
R.003211

----------

Name: GHW - Rotating collections - Report 3
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-06-10 14:24:32
Modified on: 2019-06-10 15:05:06
Date last run: 2019-06-10 15:06:37

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Items in a specific "Rotating collections" group for editing</p>
<ul><li>Shows all items in the group you specify</li>
<li>grouped by collection id, biblionumber, and item number</li>
<li>sorted by the standard Next classification pattern</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Once you no longer need a group, all items must be removed from the group before it can be deleted.  If you accidentally delete a group before removing the items from the group, contact Nexthelp@nekls.org for assistance.</p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3211&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  CONCAT("Collection: ", collections.colTitle, "<br />ID: ", collections.colId) AS COLLECTION,
  CONCAT_WS(
    "<br />", 
    CONCAT_WS(
      "<br />",
      items.homebranch,
      Concat(itemtypes.description, " (", items.itype, ")"),
      ccodes.lib,
      items.itemcallnumber,
      biblio.author,
      Concat_Ws(
        " ",
        biblio.title,
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'),
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]')
      )
    ),
    CONCAT_WS(
      " ",
      IF(Coalesce(nfl.lib, " ") = " ", "", "<br /><big><b>Not for loan</b></big>"),
      IF(Coalesce(damageds.lib, " ") = " ", "", "<br /><big><b>Damaged</b></big>"),
      IF(Coalesce(losts.lib, " ") = " ", "", "<br /><big><b>Lost or missing</b></big>"),
      IF(Coalesce(withdrawns.lib, " ") = " ", "", "<br /><big><b>Withdrawn</b></big>"),
      IF(Coalesce(items.onloan, "") <> "", "<br /><big><b>CHECKED OUT</b></big>", "")
    ),
    "<br />",
    Concat_Ws('<br />', (Concat('<img src="/cgi-bin/koha/svc/barcode?barcode=', '*', Upper(items.barcode), '*', '&type=Code39"></img>')), items.barcode)
  ) AS ITEMS_IN_COLLECTION,
  items.itemnumber
FROM
  biblio
  JOIN biblio_metadata
    ON biblio_metadata.biblionumber = biblio.biblionumber
  JOIN items
    ON items.biblionumber = biblio.biblionumber
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE'
    GROUP BY
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
  ) ccodes
    ON items.ccode = ccodes.authorised_value
  JOIN biblioitems
    ON biblioitems.biblionumber = biblio.biblionumber AND
      items.biblioitemnumber = biblioitems.biblioitemnumber
  INNER JOIN itemtypes
    ON items.itype = itemtypes.itemtype
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
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'DAMAGED'
  ) damageds
    ON damageds.authorised_value = items.damaged
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOST'
  ) losts
    ON losts.authorised_value = items.itemlost
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'WITHDRAWN'
  ) withdrawns
    ON withdrawns.authorised_value = items.withdrawn
  JOIN collections_tracking
    ON collections_tracking.itemnumber = items.itemnumber
  JOIN collections
    ON collections.colId = collections_tracking.colId
WHERE
  collections.colId = <<Enter collection ID number>>
GROUP BY
  collections.colId,
  biblio.biblionumber,
  items.itemnumber
ORDER BY
  items.homebranch,
  items.itype,
  ccodes.lib,
  items.itemcallnumber,
  biblio.author,
  biblio.title



