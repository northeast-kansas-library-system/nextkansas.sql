/*
R.003218

----------

Name: GHW - VIDEO Problem item/record
Created by: George Williams

----------

Group: -
     -

Created on: 2019-07-14 23:26:46
Modified on: 2019-07-15 17:32:40
Date last run: 2023-11-08 13:37:38

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT Concat_Ws("",
  "nexthelp@nekls.org",
  branches.branchemail,
  Concat("DVD/BLU-RAY/TV SERIES Item record/bibliogrphic record problem - ", items.biblionumber, "Hello at ", items.homebranch, ","),
  "There is an item owned by your library and the details for the item record are problematic.  The details are as follow:",
  Concat("Barcode: ", items.barcode),
  Concat("Homebranch: ", items.homebranch),
  Concat("Location: ", Coalesce(locs.lib, "-")),
  Concat("Item type: ", Coalesce(Concat(itemtypes.description, " (", items.itype, ")"), "-")),
  Concat("Collection code: ", ccodes.lib),
  Concat("Call number: ", Coalesce(items.itemcallnumber, "-")),
  Concat("Author: ", biblio.author),
  Concat("Title: ", Concat_Ws(" ",
    biblio.title,
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="c"]'))
  ),
  "The problems with this item are:", "",
  Concat("The item type on your item (", itemtypes.description, ") doesn't match the item types of the other items on this bibliographic record."),
  Concat("The item type on your item (", itemtypes.description, ") is for a physical item, but the bibliographic record you've attached your item to is for an electronic edition."),
  Concat("The item type on your item (", itemtypes.description, ") doesn't match many of the descriptive elements on this bibliographic record."),
  Concat("The collection code on your item (", ccodes.lib, ") isn't one of the collection codes that normally go with the item type on this item (", itemtypes.description, ")."),
  Concat(
    "The collection code (",
    ccodes.lib,
    ") and item type (",
    itemtypes.description,
    ") on your item doesn't match the description of the item in the 300 field of the bibliographic record:",
    Concat(
      "300$a: ",
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="300"]/subfield[@code="a"]'),
      "300$b: ",
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="300"]/subfield[@code="b"]'),
      "300$c: ",
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="300"]/subfield[@code="c"]')
    ),
    ""
  ),
  "", 
  Concat("Could you take a look at this item and u","pdate the item record if necessary.  If you need any help with this issue, please respond with the item barcode number from this item, the UPC code from the the item, plus the full title of the item as it appears on the cover or on the disc itself.  Also, if you need help, if you could actually take a photo of the cover of this item and send that in, although not necessary, that would be a big help too.Thanks,")
) AS INFO
FROM biblio
JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
JOIN items ON items.biblionumber = biblio.biblionumber
LEFT JOIN
  ( SELECT authorised_values.category,
           authorised_values.authorised_value,
           authorised_values.lib
   FROM authorised_values
   WHERE authorised_values.category = 'CCODE'
   GROUP BY authorised_values.category,
            authorised_values.authorised_value,
            authorised_values.lib ) ccodes ON items.ccode = ccodes.authorised_value
JOIN biblioitems ON biblioitems.biblionumber = biblio.biblionumber
AND items.biblioitemnumber = biblioitems.biblioitemnumber
JOIN itemtypes ON items.itype = itemtypes.itemtype
LEFT JOIN
  ( SELECT authorised_values.category,
           authorised_values.authorised_value,
           authorised_values.lib
   FROM authorised_values
   WHERE authorised_values.category = 'NOT_LOAN' ) nfl ON nfl.authorised_value = items.notforloan
LEFT JOIN
  ( SELECT authorised_values.category,
           authorised_values.authorised_value,
           authorised_values.lib
   FROM authorised_values
   WHERE authorised_values.category = 'DAMAGED' ) damageds ON damageds.authorised_value = items.damaged
LEFT JOIN
  ( SELECT authorised_values.category,
           authorised_values.authorised_value,
           authorised_values.lib
   FROM authorised_values
   WHERE authorised_values.category = 'LOST' ) losts ON losts.authorised_value = items.itemlost
LEFT JOIN
  ( SELECT authorised_values.category,
           authorised_values.authorised_value,
           authorised_values.lib
   FROM authorised_values
   WHERE authorised_values.category = 'WITHDRAWN' ) withdrawns ON withdrawns.authorised_value = items.withdrawn
LEFT JOIN
  ( SELECT authorised_values.category,
           authorised_values.authorised_value,
           authorised_values.lib
   FROM authorised_values
   WHERE authorised_values.category = 'LOC' ) locs ON locs.authorised_value = items.location
INNER JOIN branches ON branches.branchcode = items.homebranch
WHERE items.barcode = <>
GROUP BY
  biblio.biblionumber,
  items.itemnumber,
  locs.lib,
  branches.branchemail
ORDER BY
  items.homebranch,
  items.location,
  items.itype,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title

























