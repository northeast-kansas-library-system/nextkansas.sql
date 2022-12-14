/*
R.003677

----------

Name: Sandbox - withdrawn items
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-11-08 16:11:07
Modified on: 2022-11-08 16:33:51
Date last run: 2022-11-16 18:08:37

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  borrowers.cardnumber as LAST_BORROWER,
  Concat_WS(' | ',
    Concat('Re-billing for withdrawn item'),
    Concat('Homebranch: ', items.homebranch),
    Concat_WS(' // ', Concat('Full call#: ', items.permanent_location), items.itype, ccodes.lib, items.itemcallnumber),
    Concat('Author: ', biblio.author),
    Concat('Title: ',
      Concat_Ws(' ',
        '<span style="text-transform: uppercase">',
        biblio.title,
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'),
        '</span>')
      ),
    Concat('Barcode: ', Upper(items.barcode)),
    Concat('Replacement price: ', items.replacementprice)
  ) AS INFO
FROM
  items JOIN
  biblio ON items.biblionumber = biblio.biblionumber JOIN
  biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber AND
      items.biblionumber = biblio_metadata.biblionumber LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE') ccodes ON items.ccode =
      ccodes.authorised_value LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'NOT_LOAN') nfl ON items.notforloan =
      nfl.authorised_value LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'DAMAGED') damagedi ON items.damaged =
      damagedi.authorised_value LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOST') losti ON items.itemlost =
      losti.authorised_value LEFT JOIN
  (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'WITHDRAWN'
  ) withdrawni ON
  items.withdrawn = withdrawni.authorised_value JOIN
  items_last_borrower ON items_last_borrower.itemnumber = items.itemnumber JOIN
  borrowers ON items_last_borrower.borrowernumber = borrowers.borrowernumber
WHERE
  items.withdrawn > 0 AND
  items.homebranch = 'OTTAWA'
GROUP BY
  items.itemnumber

























