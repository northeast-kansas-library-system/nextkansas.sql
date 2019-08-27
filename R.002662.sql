/*
R.002662

----------

Name: NEKLS Prof Collection - PEOPLE
Created by: Heather Braum

----------

Group: Library-Specific
     NEKLS

Created on: 2016-02-02 11:35:28
Modified on: 2016-02-02 11:35:28
Date last run: 2018-10-07 16:06:07

----------

Public: 1
Expiry: 300

----------

PEOPLE call number prefix

----------
*/

SELECT biblio.biblionumber, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(title, ' /', ''), ',', ''), ' :', ''), '"', ''), ';', ''), '\"', ''), '/', ''), REPLACE(author, ',', '') FROM biblio LEFT JOIN items USING(biblionumber) WHERE items.homebranch='nekls' and items.itemcallnumber LIKE 'PEOPLE %'



