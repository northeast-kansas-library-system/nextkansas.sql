/*
R.002720

----------

Name: GHW - Duplicates
Created by: George H Williams

----------

Group: Administrative Reports
     Duplicate Records-admin

Created on: 2016-08-05 02:33:20
Modified on: 2018-04-15 17:13:48
Date last run: 2019-04-25 16:43:19

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT GROUP_CONCAT(items.barcode SEPARATOR ' / ') AS ITEMbarcodes,
     GROUP_CONCAT(items.biblionumber SEPARATOR ' / ') AS ITEMbiblionumber,
     GROUP_CONCAT(items.itemcallnumber SEPARATOR ' / ') AS ITEMcallunumbers,
     GROUP_CONCAT(items.homebranch SEPARATOR ' / ') AS ITEMhomebranch,
     GROUP_CONCAT(items.location SEPARATOR ' / ') AS ITEMlocation,
     biblio.title, biblio.author, GROUP_CONCAT(items.dateaccessioned SEPARATOR ' / ') AS ITEMdateaccessioned, Count(items.barcode) AS CountOfbarcode,
     GROUP_CONCAT(ExtractValue(items.more_subfields_xml,'//datafield[@tag="999"]/subfield[@code="x"]')SEPARATOR ' / ') AS NONPUBNOTE,
     GROUP_CONCAT(items.itemlost SEPARATOR ' / ') AS LOST,
     GROUP_CONCAT(items.damaged SEPARATOR ' / ') AS MENDING,
     GROUP_CONCAT(items.itype SEPARATOR ' / ') AS TYPE
  FROM biblio INNER JOIN items ON biblio.biblionumber = items.biblionumber
  WHERE items.itype = "MEDIA" OR items.itype = "LOCALHOLD1" OR items.itype = "NEWMEDIA" or items.itype = "WALKIN1"
  GROUP BY biblio.title, biblio.author
  HAVING (((Count(items.barcode))>1))



