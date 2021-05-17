/*
R.003481

----------

Name: test report
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-03-05 17:26:38
Modified on: 2021-05-04 13:51:41
Date last run: 2021-05-04 13:51:58

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  biblio.biblionumber AS BIBLIO_NUMBER,
  items.itemnumber AS ITEM_NUMBER,
  Concat('-', items.barcode, '-') AS barcode,
  items.homebranch,
  items.holdingbranch,
  permlocs.lib AS PERM_LOCATION,
  locs.lib AS LOCATION,
  itypes.description AS ITYPE,
  ccodes.lib AS CCODE,
  items.itemcallnumber,
  items.copynumber,
  biblio.author,
  Concat_Ws(" ", 
    biblio.title, 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="c"]')
  ) AS FULL_TITLE,
  Coalesce(statisticss.Count_datetime, 0) AS CKO_RENEW_PREVIOUS_YEAR
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
      authorised_values.category = 'LOC') permlocs ON
      permlocs.authorised_value = items.permanent_location LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
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
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'ccode') ccodes ON ccodes.authorised_value =
      items.ccode LEFT JOIN
  (SELECT
      statistics.itemnumber,
      Count(DISTINCT statistics.datetime) AS Count_datetime
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      statistics.datetime > CurDate() - INTERVAL 1 YEAR
    GROUP BY
      statistics.itemnumber) statisticss ON statisticss.itemnumber =
      items.itemnumber
WHERE
  items.homebranch LIKE <<Item home library|ZBRAN>> AND
  Coalesce(items.permanent_location, 'ADULT') LIKE <<Permanent location|LLOC>> AND
  Coalesce(items.itype, 'PUNC') LIKE <<Item type|LITYPES>> AND
  Coalesce(items.ccode, 'XXX') LIKE <<Collection code|LCCODE>>
GROUP BY
  biblio.biblionumber,
  items.itemnumber
ORDER BY
  items.homebranch,
  PERM_LOCATION,
  ITYPE,
  CCODE,
  items.itemcallnumber,
  items.copynumber,
  biblio.author,
  FULL_TITLE,
  items.barcode



