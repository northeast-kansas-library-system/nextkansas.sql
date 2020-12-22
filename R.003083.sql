/*
R.003083

----------

Name: GHW - Hoopla Monthly Maintenence
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-06-18 09:36:26
Modified on: 2020-07-21 17:04:55
Date last run: 2020-10-06 09:31:01

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
  items.itemcallnumber = 'Hoopla' AND
  items.itemnumber > '2153653'
GROUP BY
  items.itemnumber



