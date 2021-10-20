/*
R.003557

----------

Name: GHW - Items with a specific barcode number length
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-09-08 16:13:34
Modified on: 2021-09-08 17:56:27
Date last run: 2021-09-08 17:56:57

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Lists all items at a library with a specific item barcode number length</p>
<ul><li>Shows items currently in the catalog</li>
<li>At the library you specify and with the item barcode number length you specify</li>
<li>grouped by itemnumber and biblionumber</li>
<li>sorted by the standard Next Search Catalog classification scheme</li>
<li>contains links to the bibliographic record</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>The easiest way to run this report is to run report 3558 for your library and then choose which length barcode for your library you want to list from the right hand column.</p>
<p class= "notetags" style="display: none;">#item #barcode #length #count</p>
</div>

----------
*/



SELECT
  Concat(
    "<a href='/cgi-bin/koha/catalogue/detail.pl?biblionumber=",
    biblio.biblionumber, 
    "' target='_blank'>go to the bibliographic record</a>"
  )
  AS LINK,
  biblio.biblionumber,
  items.itemnumber,
  items.barcode,
  items.homebranch,
  items.holdingbranch,
  plocs.lib AS "PERMANENT LOCATION",
  locs.lib AS LOCATION,
  itypes.description AS ITYPE,
  ccodes.lib AS CCODE,
  items.itemcallnumber AS "Call number",
  items.copynumber,
  biblio.author,
  Concat_Ws(" ", 
    biblio.title, 
    biblio.subtitle, 
    biblioitems.number, 
    biblio.part_name
  ) AS "Full title",
  items.dateaccessioned AS "Date added",
  Coalesce(Length(items.barcode), 0) AS "Barcode length"
FROM
  items JOIN
  biblio ON items.biblionumber = biblio.biblionumber JOIN
  biblioitems ON biblioitems.biblionumber = biblio.biblionumber AND
      items.biblioitemnumber = biblioitems.biblioitemnumber LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') plocs ON plocs.authorised_value =
      items.permanent_location LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') locs ON locs.authorised_value =
      items.location LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'ccode') ccodes ON ccodes.authorised_value =
      items.ccode LEFT JOIN
  (SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes) itypes ON itypes.itemtype = items.itype
WHERE
    items.homebranch LIKE <<Choose your library|ZBRAN>> AND
    Coalesce(Length(items.barcode), 0) LIKE <<Enter barcode length>>
GROUP BY
  biblio.biblionumber,
  items.itemnumber,
  Coalesce(Length(items.barcode), 0)
ORDER BY
  items.homebranch,
  "PERMANENT LOCATION",
  ITYPE,
  CCODE,
  "Call number",
  items.copynumber,
  biblio.author,
  "Full title"

























