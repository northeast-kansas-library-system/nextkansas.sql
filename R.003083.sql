/*
R.003083

----------

Name: GHW - Hoopla Monthly Maintenence
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-06-18 09:36:26
Modified on: 2018-06-18 10:25:24
Date last run: 2018-12-05 15:13:05

----------

Public: 0
Expiry: 300

----------



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
  INNER JOIN biblio_metadata ON items.biblionumber = biblio_metadata.biblionumber
WHERE
  items.itemcallnumber = 'Hoopla'
GROUP BY
  items.itemnumber


