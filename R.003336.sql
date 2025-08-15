/*
R.003336

----------

Name: GHW - Items checked out during a date range
Created by: George Williams

----------

Group: -
     -

Created on: 2020-06-19 15:55:38
Modified on: 2024-01-17 12:04:43
Date last run: 2021-07-23 12:11:38

----------

Public: 0
Expiry: 300

----------

 
Shows items checked out or renewed during a date range
Shows items checked out or renewed during the date range you specify
at the library you specify
grouped by itemnumber, biblionumber, and the timestamp for the checkout/renewal
sorted by the checkout or renewal date, the item homebranch, the item permanent location, the item type, the collection code, the call number, the author, and the title

Notes:

Report created by George Williams.
Click here to run in a new window


----------
*/



SELECT
  statistics.branch,
  items.barcode,
  items.homebranch,
  permlocations.lib AS PERM_LOCATION,
  itypes.description AS ITYPE,
  ccodes.lib AS CCODE,
  items.itemcallnumber,
  biblio.author,
  Concat_Ws(" ", biblio.title, ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="245"]/subfield[@code="h"]'),
  ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="245"]/subfield[@code="b"]'),
  ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="245"]/subfield[@code="p"]'),
  ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="245"]/subfield[@code="n"]')) AS FULL_TITLE,
  Date_Format(statistics.datetime, '%Y.%m.%d') AS CKO_RENEW_DATE
FROM
  statistics JOIN
  items ON items.itemnumber = statistics.itemnumber JOIN
  biblio ON items.biblionumber = biblio.biblionumber JOIN
  biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
  LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') permlocations ON
      permlocations.authorised_value = items.permanent_location LEFT JOIN
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
      items.ccode
WHERE
  statistics.datetime BETWEEN &lt;&gt; AND (&lt;&gt; + interval 1 day) AND
  (statistics.type = 'issue' OR
      statistics.type = 'renew') AND
  statistics.branch = &lt;&gt;
GROUP BY
  items.itemnumber,
  biblio.biblionumber,
  statistics.datetime
ORDER BY
  CKO_RENEW_DATE DESC,
  items.homebranch,
  PERM_LOCATION,
  ITYPE,
  CCODE,
  items.itemcallnumber,
  biblio.author,
  FULL_TITLE

























