/*
R.003346

----------

Name: GHW - Sandbox
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-08-14 15:14:53
Modified on: 2021-07-02 20:36:07
Date last run: 2021-07-02 20:36:19

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  items.itemnumber,
  items.barcode,
  branchess.branchname,
  PERMLOCS.lib AS PERM_LOCATION,
  LOCS.lib AS LOCATION,
  itemtypes.description AS ITEM_TYPE,
  CCODES.lib AS COLLECTION_CODE,
  items.itemcallnumber,
  biblio.author,
  Concat_Ws(' ', 
    biblio.title, 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]')
  ) AS FULL_TITLE,
  items.dateaccessioned
FROM
  items JOIN
  biblio ON items.biblionumber = biblio.biblionumber RIGHT JOIN
  (SELECT
      branches.branchcode,
      branches.branchname
    FROM
      branches) branchess ON items.homebranch = branchess.branchcode LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') PERMLOCS ON
      PERMLOCS.authorised_value = items.permanent_location LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') LOCS ON LOCS.authorised_value =
      items.location LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE') CCODES ON CCODES.authorised_value =
      items.ccode LEFT JOIN
  itemtypes ON itemtypes.itemtype = items.itype INNER JOIN
  biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
WHERE
  (items.itype IS NULL OR
      items.itype = "XXX") AND
  branchess.branchcode LIKE <<Choose your library|LBRANCH:all>>
GROUP BY
  items.itemnumber,
  biblio.biblionumber
ORDER BY
  branchess.branchname,
  PERM_LOCATION,
  ITEM_TYPE,
  COLLECTION_CODE,
  items.itemcallnumber,
  biblio.author,
  FULL_TITLE

























