/*
R.003346

----------

Name: GHW - Sandbox
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-08-14 15:14:53
Modified on: 2021-11-16 10:01:10
Date last run: 2021-11-16 10:01:53

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat('<a class="clicked btn btn-default" href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', items.biblionumber, '\" target="_blank">Go to title</a>') AS LINK_TO_TITLE,
  biblio.biblionumber,
  items.itemnumber AS ITEM_NUMBER,
  Concat('-', items.barcode, '-') AS BARCODE,
  items.homebranch,
  items.holdingbranch,
  perm_locs.lib AS PERMANENT_LOCATION,
  current_locs.lib AS LOCATION,
  itemtypes.description AS ITYPE,
  ccodes.lib AS CCODE,
  items.itemcallnumber,
  biblio.author,
  Concat_Ws(" ", biblio.title, ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="245"]/subfield[@code="h"]'),
  ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="245"]/subfield[@code="b"]'),
  ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="245"]/subfield[@code="p"]'),
  ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="245"]/subfield[@code="n"]')) AS FULL_TITLE,
  biblioitems.publicationyear,
  items.dateaccessioned,
  items.datelastborrowed,
  items.datelastseen,
  items.issues,
  items.renewals,
  Sum((Coalesce(items.issues, 0)) + (Coalesce(items.renewals, 0))) AS
  CHECKOUTS_PLUS_RENEWALS,
  If(items.onloan IS NULL, 'No', 'Yes') AS CHECKED_OUT_NOW,
  not_loans.lib,
  damageds.lib AS lib1,
  items.damaged_on,
  losts.lib AS lib2,
  items.itemlost_on,
  withdrawns.lib AS lib3,
  items.withdrawn_on,
  items.itemnotes,
  items.itemnotes_nonpublic,
  items.copynumber,
  items.replacementprice
FROM
  biblio JOIN
  biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber JOIN
  items ON items.biblionumber = biblio.biblionumber LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') perm_locs ON
      perm_locs.authorised_value = items.permanent_location LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') current_locs ON
      current_locs.authorised_value = items.location LEFT JOIN
  itemtypes ON itemtypes.itemtype = items.itype LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE') ccodes ON ccodes.authorised_value =
      items.ccode JOIN
  biblioitems ON biblioitems.biblionumber = biblio.biblionumber LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'NOT_LOAN') not_loans ON
      not_loans.authorised_value = items.notforloan LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'damaged') damageds ON
      damageds.authorised_value = items.damaged LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'lost') losts ON losts.authorised_value =
      items.itemlost LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'withdrawn') withdrawns ON
      withdrawns.authorised_value = items.withdrawn
WHERE
  items.homebranch = 'PAOLA'
GROUP BY
  biblio.biblionumber,
  items.itemnumber
ORDER BY
  items.homebranch,
  PERMANENT_LOCATION,
  ITYPE,
  CCODE,
  items.itemcallnumber,
  biblio.author,
  FULL_TITLE

























