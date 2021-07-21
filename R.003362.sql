/*
R.003362

----------

Name: GHW - Items at a library without a replacement cost
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-11-04 09:24:50
Modified on: 2021-01-29 16:09:10
Date last run: 2021-07-13 11:39:13

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Searches for items where the "Cost, replacement price" is blank or = $0.00</p>
<ul><li>Shows items currently in the catalog</li>
<li>at the library you specify</li>
<li>grouped by item number </li>
<li>sorted by the standard Next Search Catalog classification scheme</li>
<li>contains links to the item's bibliographic record and the edit item page for each individual item</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>If an item's "Cost, replacement price" field is left blank or is set to $0.00, any patron keeping that item overdue for more than 45 days will not be billed for the replacement of that item.  If no replacement cost is defined for an item, or of the replacement cost is $0.00, the system will try to bill the patron $0.00 and if the amount due on a lost item invoice is $0.00, the system will simply not print a lost item invoice.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3362&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">replacement price, item fixup</p>
</div>

----------
*/

SELECT
  Concat(
    '<a class= "clicked" href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
    items.biblionumber, 
    '\" target="_blank">', 
    items.biblionumber, 
    '</a>'
  ) AS LINK_TO_TITLE,
  Concat(
    '<a class= "clicked" href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=', 
    items.biblionumber, 
    '&itemnumber=', 
    items.itemnumber, 
    '#edititem\" target="_blank">Edit item</a>'
  ) AS EDIT_ITEM,
  items.itemnumber AS ITEM_NUMBER,
  Concat("-", Coalesce(items.barcode, "-"), "-") AS BARCODE,
  items.homebranch,
  items.holdingbranch,
  Coalesce(plocs.lib, "-") AS PERMANENT_LOCATION,
  Coalesce(locs.lib, "-") AS LOCATION,
  Coalesce(itypes.description, "-") AS ITYPE,
  Coalesce(ccodes.lib, "-") AS CCODE,
  items.itemcallnumber,
  items.copynumber,
  biblio.author,
  Concat_Ws(" ", 
    biblio.title, 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')
  ) AS FULL_TITLE,
  items.replacementprice
FROM
  items JOIN
  biblio ON items.biblionumber = biblio.biblionumber JOIN
  biblio_metadata ON items.biblionumber = biblio_metadata.biblionumber JOIN
  biblioitems ON items.biblioitemnumber = biblioitems.biblioitemnumber LEFT JOIN
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
      itemtypes) itypes ON itypes.itemtype = items.itype LEFT JOIN
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
      authorised_values.category = 'LOC') plocs ON plocs.authorised_value =
      items.permanent_location
WHERE
  items.homebranch Like <<Choose your library|ZBRAN>> AND
  Coalesce(items.replacementprice, 0) = 0
GROUP BY
  items.itemnumber
ORDER BY
  items.homebranch,
  PERMANENT_LOCATION,
  ITYPE,
  CCODE,
  items.itemcallnumber,
  items.copynumber,
  Trim(REGEXP_REPLACE(biblio.author, "[.,:;\/]", "")),
  Trim(REGEXP_REPLACE(Trim(LEADING 'a ' FROM Trim(LEADING 'an ' FROM Trim(LEADING 'the ' FROM Lower(biblio.title)))), "[.:;\"\'\/]", "")),
  Trim(REGEXP_REPLACE(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), "[.:;\"\'\/]", "")),
  Trim(REGEXP_REPLACE(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'), "[.:;\"\'\/]", "")),
  Trim(REGEXP_REPLACE(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), "[.:;\"\'\/]", ""))



