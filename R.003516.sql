/*
R.003516

----------

Name: GHW - experimental - Holds queue report for receipt printer
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-06-04 08:59:07
Modified on: 2021-07-16 16:45:36
Date last run: 2021-07-20 08:45:44

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat_Ws("<br />----------------------<br />",
    "<style type='text/css'>.receipt {width: 45mm; min-height: 297mm; padding: 2mm; color: black;}</style><span class='receipt'>", 
    Concat_Ws('<br />', 
      Concat('Current: ', hold_fill_targets.source_branchcode), 
      Concat('Owned by: ', items.homebranch), 
      Concat('Last seen: ', items.datelastseen)
    ), 
    Concat_Ws('<br />', 
      If(LOCATIONS.lib = PERM_LOCATIONS.lib, LOCATIONS.lib, Concat(PERM_LOCATIONS.lib, " (", LOCATIONS.lib, ")")), 
      ITEMTYPESS.description, 
      CCODES.lib, 
      items.itemcallnumber, 
      items.copynumber
    ), 
    Concat_Ws('<br />', 
      biblio.author, 
      (Concat_Ws('', 
        biblio.title, 
        If(
          ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]') = "", 
          "", 
          Concat("<br />", ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'))
        ), 
        If(
          ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]') = "", 
          "", 
          Concat("<br />", ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'))
        ), 
        If(
          ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]') = "", 
          "", 
          Concat("<br />", ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'))
        ), 
        If(
          ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]') = "", 
          "", 
          Concat("<br />", ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')))
        )
    )
    ), 
    Concat_Ws('<br />', 
      (Concat(
        '<img style="width: 75px; height: 75px;" src="/cgi-bin/koha/svc/barcode?barcode=', 
        Upper(items.barcode), 
        '&type=QRcode"></img>')
      ), 
      items.barcode, 
      "<br />==============================</span>"
    )
  ) AS HOLDS_QUEUE
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
  hold_fill_targets.source_branchcode LIKE <<Choose your library|branches>>
GROUP BY
  hold_fill_targets.itemnumber
ORDER BY
  items.homebranch,
  PERM_LOCATIONS.lib,
  ITEMTYPESS.description,
  CCODES.lib,
  biblio.author,
  biblio.title,
  items.itemcallnumber

























