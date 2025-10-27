/*
R.003534

----------

Name: GHW - Items with a "Not for loan" status
Created by: George Williams

----------

Group: -
     -

Created on: 2021-07-28 15:14:53
Modified on: 2024-01-17 11:28:13
Date last run: 2025-10-08 10:51:17

----------

Public: 0
Expiry: 300

----------

 
Lists items with a specific "Not for loan" status
Shows items that currently have a "Not for loan" status
at the library you specify
grouped by biblio.biblionumber and items.itemnumber
sorted by the standard Next Search Catalog classification scheme
links to the bibliographic record for the item

Notes:
Not for loan statuses include:
  
    Download or Online Access (5)
    In Processing (7)
    Migration (3)
    Not For Loan (1)
    Online Access (6)
    Ordered (-1)
    Paola processing (-9)
    Paola repair/mending (-8)
    Staff Collection (2)
  


This report replaces the following reports:
  
    1307 - Not For Loan Items
    1407 - Not For Loan Status
    1412 - All items in a specific not for loan status
  


#ultimate #notloan not for loan


----------
*/



SELECT
  CONCAT(
    'Go to title'
  ) AS LINK,
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
  items.homebranch LIKE &lt;&gt; AND
  (items.notforloan LIKE &lt;&gt; AND
   items.notforloan &lt;&gt; '')
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

























