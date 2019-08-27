/*
R.002446

----------

Name: unknown
Created by: Heather Braum

----------

Group: -
     -

Created on: 2015-01-21 11:05:23
Modified on: 2015-12-09 15:27:58
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT biblio.title, items.homebranch, items.barcode, items.dateaccessioned,items.ccode,items.itype,items.location, coded_location_qualifier FROM items LEFT JOIN biblio USING(biblionumber) WHERE (itype LIKE 'WALKIN%' OR itype LIKE 'LOCALHOLD%') AND coded_location_qualifier IS NOT NULL



