/*
R.003534

----------

Name: GHW - Items with a "Not for loan" status
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-07-28 15:14:53
Modified on: 2021-07-28 15:30:11
Date last run: 2022-02-23 11:23:15

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Lists items with a specific "Not for loan" status</p>
<ul><li>Shows items that currently have a "Not for loan" status</li>
<li>at the library you specify</li>
<li>grouped by biblio.biblionumber and items.itemnumber</li>
<li>sorted by the standard Next Search Catalog classification scheme</li>
<li>links to the bibliographic record for the item</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p>Not for loan statuses include:
  <ul>
    <li>Download or Online Access (5)</li>
    <li>In Processing (7)</li>
    <li>Migration (3)</li>
    <li>Not For Loan (1)</li>
    <li>Online Access (6)</li>
    <li>Ordered (-1)</li>
    <li>Paola processing (-9)</li>
    <li>Paola repair/mending (-8)</li>
    <li>Staff Collection (2)</li>
  </ul>
</p>
<p></p>
<p>This report replaces the following reports:
  <ul>
    <li>1307 - Not For Loan Items</li>
    <li>1407 - Not For Loan Status</li>
    <li>1412 - All items in a specific not for loan status</li>
  </ul>
</p>
<p></p>
<p class= "notetags" style="display: none;">#ultimate #notloan not for loan</p>
</div>

----------
*/



SELECT
  CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblio.biblionumber, ' " target="_blank">Link</a>') AS LINK,
  items.homebranch,
  If(
    items.permanent_location = items.location, 
    permlocs.lib,
    Concat(permlocs.lib, ' (', locs.lib, ')')
  ) AS LOCATION,
  itypes.description AS ITYPE,
  ccodes.lib AS CCODE,
  items.itemcallnumber,
  biblio.author,
  Concat_Ws(" ", 
    biblio.title, 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="c"]')
  ) AS FULL_TITLE,
  items.barcode,
  not_loans.lib AS NOT_FOR_LOAN,
  items.dateaccessioned AS DATE_ADDED,
  items.onloan AS DATE_DUE
FROM
  biblio JOIN
  biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
   JOIN
  items ON items.biblionumber = biblio.biblionumber LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') permlocs ON
      permlocs.authorised_value = items.permanent_location LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') locs ON locs.authorised_value =
      items.location LEFT JOIN
  (SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes) itypes ON itypes.itemtype = items.itype LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'ccode') ccodes ON ccodes.authorised_value =
      items.ccode LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'NOT_LOAN') not_loans ON
      not_loans.authorised_value = items.notforloan
WHERE
  items.homebranch LIKE <<Choose your library|LBRANCH>> AND
  (items.notforloan LIKE <<Not for loan status|NOT_LOAN:all>> AND
   items.notforloan <> '')
GROUP BY
  biblio.biblionumber,
  items.itemnumber
ORDER BY
  items.homebranch,
  permlocs.lib,
  ITYPE,
  CCODE,
  items.itemcallnumber,
  biblio.author,
  FULL_TITLE,
  items.barcode

























