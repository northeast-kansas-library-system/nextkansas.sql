/*
R.003281

----------

Name: GHW - ADMINREPORT - is this large print?
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-11-21 15:16:31
Modified on: 2019-11-21 15:16:31
Date last run: 2019-11-21 15:22:00

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT Concat_Ws("<br />",
  "nexthelp@nekls.org<br />",
  branches.branchemail,
  Concat("<br />Large print item record/bibliogrphic record problem - ", items.biblionumber, "<br /><br />Hello at ", items.homebranch, ",<br />"),
  "There is an item owned by your library and the bibliogrpahic record and item record are problematic.  The details are as follow:<br />",
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
  "<br /><br />The specific things of note are:<br />", "<ul>",
                              
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
  Concat("<br />Could you take a look at this item and confirm that it is, in fact, a large print copy.  If this item belongs on a different bibliographic record, could you move it to a different record?  If there isn't already a regular print record, then could you import a better bibliographic record and attach this item to that record?  If you need any help with this issue, please respond with the item barcode number from this item, the UPC code from the the item, plus the full title of the item as it appears in the work itself.<br /><br />Thanks,")
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

























