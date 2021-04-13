/*
R.003481

----------

Name: test report
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-03-05 17:26:38
Modified on: 2021-04-12 13:54:46
Date last run: 2021-04-12 13:54:53

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  Concat(
    '<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
    biblio.biblionumber, 
    '\" target="_blank">', 
    biblio.biblionumber, 
    '</a>'
  ) AS LINK_TO_TITLE,
  Concat("-", items.barcode, "-") AS BARCODE,
  items.homebranch,
  Concat(itemtypes.description, " (", items.itype, ")") AS ITYPE,
  ccodes.lib AS CCODE,
  items.itemcallnumber,
  biblio.author,
  Concat_Ws(" ", 
    biblio.title, 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="c"]')
  ) AS FULL_TITLE,
  biblioitems.publicationyear,
  Greatest(Coalesce(CAST(items.dateaccessioned AS DATE), 0),
    Coalesce(CAST(items.datelastborrowed AS DATE), 0),
    Coalesce(CAST(items.datelastseen AS DATE), 0),
    Coalesce(CAST(items.itemlost_on AS DATE), 0),
    Coalesce(CAST(items.withdrawn_on AS DATE), 0),
    Coalesce(CAST(items.timestamp AS DATE), 0)) AS LAST_CHANGE,
  Greatest(Coalesce(CAST(items.dateaccessioned AS DATE), 0),
    Coalesce(CAST(items.datelastborrowed AS DATE), 0),
    Coalesce(CAST(items.datelastseen AS DATE), 0),
    Coalesce(CAST(items.itemlost_on AS DATE), 0),
    Coalesce(CAST(items.withdrawn_on AS DATE), 0),
    Coalesce(CAST(items.timestamp AS DATE), 0)) + INTERVAL 13 MONTH AS AUTO_DELETE_DATE,
  Concat(Coalesce(lcodes.lib, "-"), " | ", Coalesce(wcodes.lib, "-")) AS STATUS
FROM
  biblio
  JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
  JOIN items ON items.biblionumber = biblio.biblionumber
  LEFT JOIN (SELECT
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'CCODE') ccodes ON items.ccode = ccodes.authorised_value
  JOIN biblioitems ON biblioitems.biblionumber = biblio.biblionumber AND
    items.biblioitemnumber = biblioitems.biblioitemnumber
  JOIN itemtypes ON items.itype = itemtypes.itemtype
  LEFT JOIN (SELECT
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'LOST') lcodes ON items.itemlost = lcodes.authorised_value
  LEFT JOIN (SELECT
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'withdrawn') wcodes ON items.withdrawn = wcodes.authorised_value
WHERE
  items.homebranch LIKE <<Choose item home branch|branches:all>> AND
  ((items.itemlost > 0 AND
  (Greatest(Coalesce(CAST(items.dateaccessioned AS DATE), 0),
    Coalesce(CAST(items.datelastborrowed AS DATE), 0),
    Coalesce(CAST(items.datelastseen AS DATE), 0),
    Coalesce(CAST(items.itemlost_on AS DATE), 0),
    Coalesce(CAST(items.withdrawn_on AS DATE), 0),
    Coalesce(CAST(items.timestamp AS DATE), 0)) + INTERVAL 13 MONTH) < AddDate(Last_Day(SubDate(Now(), INTERVAL -2 MONTH)), 1)) OR
  (items.withdrawn > 0 AND
  (Greatest(Coalesce(CAST(items.dateaccessioned AS DATE), 0),
    Coalesce(CAST(items.datelastborrowed AS DATE), 0),
    Coalesce(CAST(items.datelastseen AS DATE), 0),
    Coalesce(CAST(items.itemlost_on AS DATE), 0),
    Coalesce(CAST(items.withdrawn_on AS DATE), 0),
    Coalesce(CAST(items.timestamp AS DATE), 0)) + INTERVAL 13 MONTH) < AddDate(Last_Day(SubDate(Now(), INTERVAL -2 MONTH)), 1)))
GROUP BY
  biblio.biblionumber,
  items.itemnumber
ORDER BY
  items.homebranch,
  ITYPE,
  CCODE,
  items.itemcallnumber,
  biblio.author,
  FULL_TITLE



