/*
R.002648

----------

Name: New NEKLS Childrens Report
Created by: Heather Braum

----------

Group: Administrative Reports
     -

Created on: 2015-12-30 15:52:25
Modified on: 2015-12-31 15:27:05
Date last run: -

----------

Public: 1
Expiry: 0

----------



----------
*/

SELECT biblio.biblionumber, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(title, ' /', ''), ',', ''), ' :', ''), '"', ''), ';', ''), '\"', ''), '/', ''), REPLACE(author, ',', '')  FROM biblio LEFT JOIN items USING(biblionumber) WHERE homebranch='NEKLS' and itemcallnumber LIKE 'CHILD%'



