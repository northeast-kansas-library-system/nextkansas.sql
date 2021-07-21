/*
R.000214

----------

Name: Null Report - Missing Item Type report for all libraries
Created by: -

----------

Group: -
     -

Created on: 2009-01-26 12:07:07
Modified on: 2020-12-24 17:37:16
Date last run: 2021-07-15 11:17:59

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Shows items with Unknown (itype code XXX) item type or no item type</p>
<ul><li>Shows items that currently have an empty item type or an "(Unclassified)" item type</li>
<li>shows items at the library or libraries you choose</li>
<li>grouped by itemnumber and biblionumber</li>
<li>sorted in the standard Next Search Catalog sort order</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p>Should be run monthly</p>
<p>Report created by Heather Braum.  Explanatory notes added by GHW on 2016.08.19.</p>
<p>Report updated 2020.12.24</p>
</div>

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
  branchess.branchcode LIKE <<Choose your library|LBRANCH>>
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



