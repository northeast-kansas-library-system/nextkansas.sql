/*
R.002659

----------

Name: NEKLS Prof Collection - CHILD
Created by: Heather Braum

----------

Group: Library-Specific
     NEKLS

Created on: 2016-02-02 11:33:10
Modified on: 2016-02-02 11:33:10
Date last run: -

----------

Public: 1
Expiry: 300

----------

CHILD call number

----------
*/

SELECT biblio.biblionumber, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(title, ' /', ''), ',', ''), ' :', ''), '"', ''), ';', ''), '\"', ''), '/', ''), REPLACE(author, ',', '') FROM biblio LEFT JOIN items USING(biblionumber) WHERE items.homebranch='nekls' and items.itemcallnumber LIKE 'CHILD %'



