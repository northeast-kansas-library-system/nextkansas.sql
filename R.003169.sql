/*
R.003169

----------

Name: GHW - ADMINREPORT - ISBN / UPC followup
Created by: George H Williams

----------

Group: Administrative Reports
     -

Created on: 2019-02-12 12:23:57
Modified on: 2019-02-12 15:42:50
Date last run: 2019-03-07 22:34:08

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  Concat(
    "Information needed for ",
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
    "<br /><br />Could you send me the ISBN from your copy of this item?<br /><br />Could you send me the UPC number from your copy of this item?<br /><br />Could you send me more information about your copy of this item?<br /><br />George"
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
  items.barcode LIKE Concat("%", <<Enter item barcode>>, "%")
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



