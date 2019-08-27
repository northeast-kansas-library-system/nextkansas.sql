/*
R.002832

----------

Name: GHW - Lost status for download to spreadsheet
Created by: George H Williams

----------

Group: -
     -

Created on: 2016-11-23 11:29:35
Modified on: 2017-12-19 09:36:17
Date last run: 2017-09-11 13:45:29

----------

Public: 0
Expiry: 0

----------

<p><span style="background-color: darkred; color: white">Needs metadata conversion post 17.05</p>

----------
*/

SELECT
  items.barcode,
  items.homebranch,
  items.holdingbranch,
  items.location,
  items.itype,
  authorised_values.lib AS CCODE,
  items.itemcallnumber,
  biblio.author,
  Concat_Ws(' ', biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')) AS FULL_TITLE,
  authorised_values1.lib AS LOST_STATUS,
  items.itemlost_on AS DATE_MARKED_LOST,
  items.dateaccessioned,
  items.datelastborrowed,
  items.datelastseen
FROM
  items INNER JOIN
  biblio_metadata
    ON items.biblionumber = biblio_metadata.biblionumber INNER JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber LEFT JOIN
  authorised_values
    ON items.ccode = authorised_values.authorised_value LEFT JOIN
  authorised_values authorised_values1
    ON items.itemlost = authorised_values1.authorised_value
WHERE
  items.homebranch LIKE <<Choose Item home branch|ZBRAN>> AND
  (authorised_values.category = 'CCODE' OR
    authorised_values.category IS NULL) AND
  (authorised_values1.category = 'LOST' OR
    authorised_values1.category IS NULL) AND
  items.itemlost LIKE <<Choose Lost/Missing status|LLOST>>
GROUP BY
  items.itemnumber
ORDER BY
  items.homebranch,
  items.location,
  items.itype,
  CCODE,
  items.itemcallnumber,
  biblio.author,
  FULL_TITLE



