/*
R.000214

----------

Name: GHW - Items with important fields that are blank or have problematic values
Created by: -

----------

Group: -
     -

Created on: 2009-01-26 12:07:07
Modified on: 2021-09-08 16:04:27
Date last run: 2022-03-17 09:12:51

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo class=noprint>
<p>Shows item records with important fields that are blank or may be problematic</p>
<ul>
  <li>Shows items currently in the catalog with the following fields left blank (or in some cases "Unclassified"):</li>
    <ul>
      <li>barcode</li>
      <li>permanent shelving location (blank or cataloging, processing, or recently returned)</li>
      <li>item type (blank or unclassified)</li>
      <li>collection code (blank or unclassified)</li>
      <li>call number</li>
      <li>replacement price</li>
    </ul>
  <li>at the library you specify; and with the blank field you specify</li>
  <li>grouped by biblio number and item number</li>
  <li>sorted by item home branch, location, item type, collection code, call number, author, and title</li>
  <li>contains links to the bibliographic record</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Replaces reports:</p>
<ul>
  <li>214 - Null Report - Missing Item Type report for all libraries (previous version)</li>
  <li>1285 - Null Report - Missing Collection Codes all</li>
  <li>1398 - Collection Codes to Fix</li>
  <li>1401 - Item Types to Fix</li>
  <li>1402 - Missing Replacement Prices</li>
  <li>1404 - Shelving Locations to fix</li>
  <li>1405 - Missing Call Number</li>
  <li>1782 - Home or Current Branch is Null</li>
  <li>1912 - Null report -- Missing Shelving Location all</li>
  <li>3057 - GHW - Empty LOCATION/ITYPE/CCODES</li>
  <li>3362 - GHW - Items at a library without a replacement cost</li>
</ul>
<p></p>
<p class= "notetags" style="display: none;">tag goes here</p>
</div>



----------
*/



SELECT
  Concat(
    "<a href='/cgi-bin/koha/catalogue/detail.pl?biblionumber=", 
    biblio.biblionumber, 
    "' target='_blank'>go to the bibliographic record</a>"
  ) AS LINK,
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
  Concat_Ws(" ", biblio.title, biblio.subtitle, biblioitems.number,
  biblio.part_name) AS "Full title",
  items.replacementprice AS "Replacement price",
  items.dateaccessioned AS "Date added",
  Concat_Ws("", 
    If(items.barcode IS NULL, "Empty barcode / ", ""), 
    If(plocs.lib IS NULL, "Empty permanent location / ", 
      If(plocs.lib LIKE "%Cataloging%", "Cataloging location / ", 
        If(plocs.lib LIKE "%Processing%", "Processing location / ", 
          If(plocs.lib LIKE "%Recently%", "Recently returned location / ", "")
        )
      )
    ), 
    If(ccodes.lib IS NULL, "Empty collection code / ", 
      If(ccodes.lib LIKE "%(UN%", "(Unclassified) collection code / ", "")
    ), 
    If(itypes.description IS NULL, "Empty item type ", 
      If(itypes.description LIKE "%(UN%", "(Unclassified) item type / ", "")
    ), 
    If(items.itemcallnumber IS NULL, "Empty call number / ", ""), 
    If(items.replacementprice IS NULL, "Empty replacement price / ", 
      If(items.replacementprice = 0, "$0.00 replacement price / ", "")
    )
  ) AS "Problem field"
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
  items.homebranch LIKE <<Item home library|ZBRAN>> AND
  ((items.barcode IS NULL) OR
    (plocs.lib IS NULL) OR
    (plocs.lib LIKE "%Cataloging%") OR
    (plocs.lib LIKE "%Processing%") OR
    (plocs.lib LIKE "%Recently%") OR
    (ccodes.lib IS NULL) OR
    (ccodes.lib LIKE "%(UN%") OR
    (itypes.description IS NULL) OR
    (itypes.description LIKE "%(UN%") OR
    (items.itemcallnumber IS NULL) OR
    (items.replacementprice IS NULL)) AND
  Concat(
    If(items.barcode IS NULL, "BE", ""), 
    If(plocs.lib IS NULL, "LE3", 
      If(plocs.lib LIKE "%Cataloging%", "LG3", 
        If(plocs.lib LIKE "%Processing%", "LG3", 
          If(plocs.lib LIKE "%Recently%", "LG3", "")
        )
      )
    ), 
    If(ccodes.lib IS NULL, "CE3", 
      If(ccodes.lib LIKE "%(UN%", "CG3", "")
    ), 
    If(itypes.description IS NULL, "IE3", 
      If(itypes.description LIKE "%(UN%", "IG3", "")
    ), 
    If(items.itemcallnumber IS NULL, "NE", ""), 
    If(items.replacementprice IS NULL, "PE", 
      If(items.replacementprice = 0, "PE", "")
    )
  ) LIKE Concat("%", <<Empty or problematic field in item record|XS_NULLS>>, "%")
GROUP BY
  biblio.biblionumber,
  items.itemnumber
ORDER BY
  items.homebranch,
  PERMANENT_LOCATION,
  ITYPE,
  CCODE,
  items.itemcallnumber,
  items.copynumber,
  biblio.author,
  "Full title"

























