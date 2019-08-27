/*
R.002721

----------

Name: GHW - Items by date added
Created by: George H Williams

----------

Group: -
     -

Created on: 2016-08-06 12:00:04
Modified on: 2016-08-06 12:11:29
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT biblio.biblionumber, biblio.title, biblioitems.isbn
FROM biblio JOIN biblioitems ON biblio.biblionumber = biblioitems.biblionumber
WHERE biblio.datecreated BETWEEN <<Date added start|date>> AND <<Date added end|date>>



