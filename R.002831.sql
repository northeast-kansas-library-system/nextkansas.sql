/*
R.002831

----------

Name: GHW - Lost/missing items report for printing from Koha
Created by: George Williams

----------

Group: -
     -

Created on: 2016-11-23 11:11:59
Modified on: 2017-12-19 09:35:57
Date last run: 2024-08-23 14:12:29

----------

Public: 0
Expiry: 0

----------

&lt;p&gt;&lt;span style="background-color: darkred; color: white"&gt;Needs metadata conversion post 17.05&lt;/p&gt;

----------
*/



SELECT
  Concat_Ws('',CONCAT('Link to item'),
    Concat(items.barcode, ''),
    Concat('Home: ', items.homebranch),
    Concat('Current: ', items.holdingbranch)) AS BC_LIBRARY,
  Concat_Ws('', items.location, items.itype, authorised_values.lib, items.itemcallnumber) AS CLASSIFICATION,
  Concat_Ws('', Concat('AU: ', If(biblio.author IS NULL, '_', biblio.author)), 
    Concat('TI: ', (Concat_Ws('          ', biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')))), '') AS AUTH_TITLE,
  Concat_Ws('', (Concat('Added: ', items.dateaccessioned)), (Concat('Last borrowed: ', If(items.datelastborrowed IS NULL, 'Never', items.datelastborrowed))), (Concat('Last seen: ', items.datelastseen))) AS HISTORY,
  CONCAT_WS('',(CONCAT('Status: ',authorised_values1.lib)),CONCAT('Date: ',If(items.itemlost_on IS NULL, 'Lost before OCT-14', items.itemlost_on))) AS LOST
FROM
  items JOIN
  biblio_metadata
    ON items.biblionumber = biblio_metadata.biblionumber JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber LEFT JOIN
  authorised_values
    ON items.ccode = authorised_values.authorised_value LEFT JOIN
  authorised_values authorised_values1
    ON items.itemlost = authorised_values1.authorised_value
WHERE
  (authorised_values.category = 'CCODE' OR authorised_values.category IS NULL) AND
  (authorised_values1.category = 'LOST' OR authorised_values1.category IS NULL) AND
  items.homebranch LIKE &lt;&gt; AND
  items.itemlost LIKE &lt;&gt;
GROUP BY
  items.itemnumber
ORDER BY
  items.homebranch,
  CLASSIFICATION,
  AUTH_TITLE

























