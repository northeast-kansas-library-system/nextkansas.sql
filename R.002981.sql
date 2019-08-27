/*
R.002981

----------

Name: GHW - Holding branch is LIBRARY A, but Home branch is LIBRARY B
Created by: George H Williams

----------

Group: -
     -

Created on: 2017-08-07 09:45:47
Modified on: 2018-12-09 21:16:24
Date last run: 2018-12-09 21:18:40

----------

Public: 0
Expiry: 300

----------

DRAFT - This report runs but is still in progress.
<p><span style="background-color: darkred; color: white">Needs metadata conversion post 17.05</p>

----------
*/

SELECT
  Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">',
  biblio.biblionumber, '</a>') AS LINK_TO_TITLE,
  items.itemnumber,
  items.homebranch,
  items.holdingbranch,
  Concat("-", Coalesce(items.barcode, "-"), "-") AS BARCODE,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  Concat_Ws(' ', biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="245"]/subfield[@code="n"]')) AS FULL_TITLE,
  items.dateaccessioned,
  items.datelastborrowed,
  items.datelastseen,
  Sum((Coalesce(items.issues, 0)) + Coalesce(items.renewals, 0)) AS CHECKOUTS_PLUS_RENEWALS,
  items.onloan AS CHECKED_OUT,
  damagedt.lib AS DAMAGED,
  lostt.lib AS LOST,
  withdrawnt.lib AS WITHDRAWN,
  items.itemnotes,
  items.itemnotes_nonpublic,
  items.price,
  items.replacementprice
FROM
  items
  JOIN biblio ON items.biblionumber = biblio.biblionumber
  JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber AND items.biblionumber =
    biblio_metadata.biblionumber
  LEFT JOIN (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'DAMAGED') damagedt ON items.damaged = damagedt.authorised_value
  LEFT JOIN (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOST') lostt ON items.itemlost = lostt.authorised_value
  LEFT JOIN (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'WITHDRAWN') withdrawnt ON items.withdrawn = withdrawnt.authorised_value
  LEFT JOIN (SELECT
      branchtransfers.itemnumber,
      branchtransfers.datearrived,
      branchtransfers.datesent
    FROM
      branchtransfers
    WHERE
      branchtransfers.datearrived IS NULL) transferst ON items.itemnumber = transferst.itemnumber
  LEFT JOIN (SELECT
      reserves.itemnumber,
      reserves.found
    FROM
      reserves) reservest ON items.itemnumber = reservest.itemnumber
WHERE
  items.onloan IS NULL AND
  transferst.datesent IS NULL AND
  reservest.found IS NULL AND
  (items.holdingbranch NOT LIKE @brn := <<Choose your library|ZBRAN>> COLLATE utf8mb4_unicode_ci) AND
  items.homebranch LIKE @brn
GROUP BY
  items.itemnumber
ORDER BY
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  FULL_TITLE



