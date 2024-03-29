/*
R.003170

----------

Name: GHW - ADMINREPORT - Biblio/Item/Call number ITYPE confusion
Created by: George H Williams

----------

Group: Administrative Reports
     -

Created on: 2019-02-12 15:43:52
Modified on: 2019-03-07 22:50:19
Date last run: 2019-09-26 18:33:48

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat(
    "Bibliographic record / item record confusion - ",
    UPPER(biblio.title),
    "<br /><br />Hello at ",
    items.homebranch,
    ",<br /> <br />There is a problem with an item/biblio at your library.  The details are as follow:<br />",
    Concat_Ws('<br />',
      Concat('Item homebranch: ', items.homebranch),
      Concat('Current branch: ', items.holdingbranch),
      Concat('Shelving location: ', items.location),
      Concat('Item type: ', items.itype),
      Concat('Collection code: ', ccodes.lib),
      Concat('Call#: ', items.itemcallnumber),
      Concat('Author: ', biblio.author),
      Concat(
        'Title: ',
        Concat_Ws(' ',
          '<span style="text-transform: uppercase">',
          biblio.title,
          ExtractValue(biblio_metadata.metadata,'//datafield[@tag="245"]/subfield[@code="b"]'),
          ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
          ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'),
          '</span>'
        )
      ),
      Concat('Barcode: ', items.barcode)
    ),
    "<br /><br />The issue here is that<br /><br />",
    "the item type on the bibliographic record is ", ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="h"]'), "<br /><br />",
    "the collection code on the bibliographic record is ", ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="c"]'), "<br /><br />",
    "the description on the bibliographic (300$a) record is ", ExtractValue(biblio_metadata.metadata, '//datafield[@tag="300"]/subfield[@code="a"]'), "<br /><br />",

    "the item type on your item is ", ccodes.lib, "<br /><br />",
    "the collection code on your item is ", items.itype, "<br /><br />",
    "the call number on this item is ", ccodes.lib, "<br /><br />",
    " but <br /><br />",
    " so the description for this title and item in the catalog is going to be confusing to patrons because of this discrepancy.<br /><br />Could you take a look at your item and see if this item belongs on a different bibliographic record or if the bibliographic record or the item record needs to be updated or if this item just belongs on a different bibliographic record altogether?<br /><br />Thanks,<br /><br />George"
  ) AS MESSAGE
FROM
  items
  JOIN biblio ON items.biblionumber = biblio.biblionumber
  JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber AND
    items.biblionumber = biblio_metadata.biblionumber
  LEFT JOIN (SELECT
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
      authorised_values.lib) ccodes ON items.ccode = ccodes.authorised_value
WHERE
  items.barcode LIKE Concat("%", <<barcode number>>, "%")
GROUP BY
  items.itemnumber
ORDER BY
  items.homebranch,
  items.location,
  items.itype,
  ccodes.lib,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  items.barcode

























