/*
R.002778

----------

Name: GHW - Holds Queue with scannable barcodes
Created by: George H Williams

----------

Group: Holds-Reserves
     -

Created on: 2016-09-25 22:37:09
Modified on: 2021-02-08 14:51:49
Date last run: 2021-07-21 13:14:19

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo class="noPrint">
<p>Print holds queue report with scannable barcodes</p>
<ul><li>Shows items in the current holds queue</li>
<li>at the location you specify</li>
<li>grouped by specified location, items home branch, call number, author, and title</li>
<li>contains links to the bibliographic records</li>
</ul><br />
</div>



----------
*/

SELECT
  Concat_Ws('<br />', 
    Concat('Current: ', hold_fill_targets.source_branchcode),
    Concat('Owned by: ', items.homebranch), 
    Concat('Last seen: ', items.datelastseen),
    (Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">Go to biblio</a>'))
  ) AS INFO,
  Concat_Ws('<br />', 
    If(LOCATIONS.lib = PERM_LOCATIONS.lib, LOCATIONS.lib, Concat(PERM_LOCATIONS.lib, " (", LOCATIONS.lib, ")")), 
    ITEMTYPESS.description,
    CCODES.lib, 
    items.itemcallnumber, 
    items.copynumber
  ) AS CALL_NUMBER,
  Concat_Ws('<br />', 
    biblio.author, 
    (Concat_Ws('<br />', 
      biblio.title, 
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'))
    )
  ) AS AUTHOR_TITLE,
  Concat_Ws('<br />', 
    (Concat('<img src="/cgi-bin/koha/svc/barcode?barcode=', '*', Upper(items.barcode), '*', '&type=Code39"></img>')), 
    items.barcode
  ) AS BARCODE
FROM
  biblio LEFT JOIN
  ((hold_fill_targets LEFT JOIN
  items ON hold_fill_targets.itemnumber = items.itemnumber) LEFT JOIN
  biblio_metadata ON items.biblionumber = biblio_metadata.biblionumber) ON
      biblio.biblionumber = biblio_metadata.biblionumber LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE') CCODES ON CCODES.authorised_value =
      items.ccode LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') PERM_LOCATIONS ON
      PERM_LOCATIONS.authorised_value = items.permanent_location LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') LOCATIONS ON
      LOCATIONS.authorised_value = items.location LEFT JOIN
  (SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes) ITEMTYPESS ON ITEMTYPESS.itemtype = items.itype
WHERE
  hold_fill_targets.source_branchcode LIKE <<Select your branch|LBRANCH>>
GROUP BY
  hold_fill_targets.itemnumber
ORDER BY
  items.homebranch,
  If(LOCATIONS.lib = PERM_LOCATIONS.lib, LOCATIONS.lib, Concat(PERM_LOCATIONS.lib, " (", LOCATIONS.lib, ")")),
  ITEMTYPESS.description,
  CCODES.lib,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  items.barcode



