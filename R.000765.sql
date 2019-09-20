/*
R.000765

----------

Name: Deleted items from a Year, Listed
Created by: NEKLS Administrator

----------

Group: Catalog Records and Items
     Weeded Already

Created on: 2010-01-06 10:21:41
Modified on: 2015-05-19 11:42:51
Date last run: 2019-09-17 14:03:56

----------

Public: 0
Expiry: 0

----------

Lists the items your library deleted in XXXX year. Pick your branch and insert the year.

----------
*/

SELECT deleteditems.homebranch, deleteditems.barcode,deleteditems.datelastseen, deleteditems.itype, deleteditems.ccode, deleteditems.timestamp, deletedbiblio.title AS "Title of Deleted Record", biblio.title AS "Title Still in Catalog", biblio.author FROM deleteditems LEFT JOIN deletedbiblio USING(biblionumber) LEFT JOIN biblio USING(biblionumber) WHERE deleteditems.homebranch = <<Pick your Branch|branches>> AND YEAR(deleteditems.timestamp) = << numericyear >> ORDER BY deleteditems.timestamp DESC



