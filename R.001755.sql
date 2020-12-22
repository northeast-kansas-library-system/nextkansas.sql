/*
R.001755

----------

Name: Searching for a deleted barcode
Created by: BONNERSPGS TECH

----------

Group: Catalog Records and Items
     Weeding Criteria

Created on: 2013-02-12 15:49:46
Modified on: 2013-09-25 17:19:40
Date last run: 2020-12-18 11:06:42

----------

Public: 0
Expiry: 0

----------

#special

----------
*/

SELECT d.biblionumber,b.biblionumber, d.title, b.title, d.author, b.author, e.homebranch,e.barcode FROM deletedbiblio d LEFT JOIN deleteditems e USING(biblionumber) LEFT JOIN biblio b USING(biblionumber) WHERE e.barcode=<<enter/scan in barcode>>



