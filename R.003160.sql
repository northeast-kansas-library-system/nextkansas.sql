/*
R.003160

----------

Name: GHW - Materials added in the previous calendar month
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-01-27 22:47:48
Modified on: 2019-01-28 01:30:53
Date last run: 2019-10-17 12:15:59

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Generates a list of items added in the previous calendar month</p>
<ul><li>Only shows items added in the previous calendar month</li>
<li>at the library you specify</li>
<li>grouped by biblio number and item number</li>
<li>sorted by home branch, shelving location, item type, collection code, call number, author, and title</li>
<li>contains links to the item's bibliographic record</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Partially replaces report 536</p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3160&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  Concat(
    '<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">',
    biblio.biblionumber,
    '</a>'
  ) AS LINK_TO_TITLE,
  Concat(
    "-",
    Coalesce(items.barcode, "-"),
    "-"
  ) AS BARCODE,
  items.homebranch,
  locations.lib AS LOCATION,
  itemtypes.description AS ITYPE,
  ccodes.lib AS CCODE,
  items.itemcallnumber,
  biblio.author,
  Concat_Ws(
    " ",
    biblio.title,
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')
  ) AS FULL_TITLE,
  items.dateaccessioned,
  items.price,
  items.replacementprice,
  items.timestamp
FROM
  items
  JOIN biblio ON biblio.biblionumber = items.biblionumber
  JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
  LEFT JOIN (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE') ccodes ON ccodes.authorised_value = items.ccode
  LEFT JOIN (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') locations ON locations.authorised_value = items.location
  LEFT JOIN itemtypes ON itemtypes.itemtype = items.itype
WHERE
  items.homebranch = <<Choose your library|LBRANCH>> AND
  Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
  Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH)
GROUP BY
  items.biblionumber,
  items.itemnumber
ORDER BY
  items.homebranch,
  LOCATION,
  ITYPE,
  CCODE,
  items.itemcallnumber,
  biblio.author,
  FULL_TITLE



