/*
R.003220

----------

Name: GHW - AUDIOBOOK item/bibliographic record problem
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-07-15 22:41:45
Modified on: 2019-07-15 22:52:01
Date last run: 2019-07-15 23:04:31

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT Concat_Ws("<br />",
  "nexthelp@nekls.org<br />",
  branches.branchemail,
  Concat("<br />AUDIOBOOK Item record/bibliogrphic record problem - ", items.biblionumber, "<br /><br />Hello at ", items.homebranch, ",<br />"),
  "There is an item owned by your library and the details for the item record are problematic.  The details are as follow:<br />",
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
  "<br /><br />The problems with this item are:<br />", "<ul>",
  Concat("<li>The item type on your item (", itemtypes.description, ") doesn't match the item types of the other items on this bibliographic record.</li><br />"),
  Concat("<li>The item type on your item (", itemtypes.description, ") is for a physical item, but the bibliographic record you've attached your item to is for an electronic edition.</li><br />"),
  Concat("<li>The item type on your item (", itemtypes.description, ") doesn't match many of the descriptive elements on this bibliographic record.</li><br />"),
  Concat("<li>The collection code on your item (", ccodes.lib, ") doesn't match many of the descriptive elements on this bibliographic record.</li><br />"),
  Concat("<li>The collection code on your item (", ccodes.lib, ") isn't one of the collection codes that normally go with the item type on this item (", itemtypes.description, ").</li><br />"),
  Concat(
    "<li>The collection code (",
    ccodes.lib,
    ") on your item doesn't match the system requirements for this item listed in the 538 field of the bibliographic record:",
    Concat(
      "<br />538$a: ",
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="538"]/subfield[@code="a"]')
    ),
    "</li><br />"
  ),
                              
  Concat(
    "<li>The collection code (",
    ccodes.lib,
    ") on your item doesn't match the edition statement for this item listed in the 250 field of the bibliographic record:",
    Concat(
      "<br />250$a: ",
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="250"]/subfield[@code="a"]')
    ),
    "</li><br />"
  ),
                              
  Concat(
    "<li>The collection code (",
    ccodes.lib,
    ") and item type (",
    itemtypes.description,
    ") on your item doesn't match the description of the item in the 300 field of the bibliographic record:",
    Concat(
      "<br />300$a: ",
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="300"]/subfield[@code="a"]'),
      "<br />300$b: ",
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="300"]/subfield[@code="b"]'),
      "<br />300$c: ",
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="300"]/subfield[@code="c"]')
    ),
    "</li><br />"
  ),
  "</ul>", 
  Concat("<br />Could you take a look at this item and bring the record up to date as needed.  If, for example, the item record is incorrect, you could just modify the record.  Or, if this item belongs on a different bibliographic record, could you move it to a different record or import a better bibliographic record and attach this item to that record?  If you need any help with this issue, please respond with the item barcode number from this item, the UPC code from the the item, plus the full title of the item as it appears on the cover or on the video game itself.  Also, if you need help, if you could actually take a photo of the cover of this item and send that in, although not necessary, that would be a big help too.<br /><br />Thanks,")
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
WHERE items.barcode = <<Enter item barcode>>
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



