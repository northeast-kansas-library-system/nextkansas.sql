/*
R.002786

----------

Name: GHW - Flexible New Items Report
Created by: George H Williams

----------

Group: -
     -

Created on: 2016-10-05 14:39:48
Modified on: 2020-11-19 18:26:05
Date last run: 2020-11-19 18:23:40

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>This report shows all items added to Next Search Catalog at a specific library branch during a date range</p>
<ul><li>Shows items that are currently still in Next Search Catalog</li>
<li>Allows user to specify the item's homebranch, shelving location, item type, collection code, and the item's date added</li>
<li>grouped by biblionumber and itemnumber</li>
<li>sorted by homebranch, location, itype, collection code, call number, author, title</li>
<li>contains links directly to the item's bibliographic record in the OPAC</li>
</ul><br />
</div>

----------
*/

SELECT
  Concat(
    '<a class="btn btn-default" href="https://nextkansas.org/cgi-bin/koha/opac-detail.pl?biblionumber=', 
    biblio.biblionumber, 
    '\" target="_blank">Go to OPAC</a>'
  ) AS LINK_TO_OPAC,
  items.biblionumber,
  items.itemnumber,
  items.barcode,
  items.homebranch,
  items.holdingbranch,
  LOCATIONSP.lib AS PERM_LOCATION,
  LOCATIONS.lib AS LOCATION,
  ITYPES.description AS ITEM_TYPE,
  CCODES.lib AS COLLECTION,
  items.itemcallnumber,
  biblio.author,
  Concat_Ws(' ', 
    biblio.title, 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')
  ) AS FULL_TITLE,
  items.dateaccessioned,
  If(items.onloan IS NULL, ' ', 'Currently checked out') AS CHECKED_OUT,
  If(Sum(items.damaged + items.itemlost + items.withdrawn) = 0, ' ', 'Damaged, lost, or withdrawn') AS STATUS_PROBLEMS
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
      authorised_values.category = 'LOC') LOCATIONSP ON
      LOCATIONSP.authorised_value = items.permanent_location LEFT JOIN
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
      itemtypes) ITYPES ON ITYPES.itemtype = items.itype LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE') CCODES ON CCODES.authorised_value = items.ccode
WHERE
  items.homebranch LIKE <<Item home library|LBRANCH>> AND
  items.location LIKE <<Item shelving location|LLOC>> AND
  items.itype LIKE <<Item type|LITYPES>> AND
  items.ccode LIKE <<Item collection code|LCCODE>> AND
  items.dateaccessioned BETWEEN <<Start date|date>> AND <<end date|date>>
GROUP BY
  items.biblionumber,
  items.itemnumber
ORDER BY
  items.homebranch,
  PERM_LOCATION,
  ITEM_TYPE,
  COLLECTION,
  items.itemcallnumber,
  biblio.author,
  FULL_TITLE



