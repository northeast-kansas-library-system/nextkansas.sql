/*
R.003099

----------

Name: GHW - Hoopla 002
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-07-02 15:38:36
Modified on: 2018-10-03 14:23:35
Date last run: 2020-01-31 17:18:31

----------

Public: 0
Expiry: 300

----------

Run after #2 to download data for comparison

----------
*/

SELECT
  items.itemnumber,
  items.biblionumber,
  items.ccode,
  items.homebranch,
  items.itemcallnumber,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="037"]/subfield[@code="a"]') AS STOCK_NUMBER,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="856"]/subfield[@code="y"]') AS YX,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="856"]/subfield[@code="z"]') AS Z
FROM
  items
  JOIN biblio_metadata ON items.biblionumber = biblio_metadata.biblionumber
WHERE
  items.itemcallnumber = 'Hoopla'
GROUP BY
  STOCK_NUMBER



