/*
R.002652

----------

Name: Title report for json
Created by: Heather Braum

----------

Group: Administrative Reports
     -

Created on: 2015-12-31 15:46:13
Modified on: 2015-12-31 15:46:13
Date last run: -

----------

Public: 1
Expiry: 1

----------



----------
*/

SELECT biblio.biblionumber, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(title, ' /', ''), ',', ''), ' :', ''), '"', ''), ';', ''), '\"', ''), '/', ''), REPLACE(author, ',', '')  FROM biblio



