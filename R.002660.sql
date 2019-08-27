/*
R.002660

----------

Name: NEKLS Prof Collection - STORY
Created by: Heather Braum

----------

Group: Library-Specific
     NEKLS

Created on: 2016-02-02 11:33:59
Modified on: 2016-02-02 11:33:59
Date last run: -

----------

Public: 1
Expiry: 300

----------

STORY callnumber prefix

----------
*/

SELECT biblio.biblionumber, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(title, ' /', ''), ',', ''), ' :', ''), '"', ''), ';', ''), '\"', ''), '/', ''), REPLACE(author, ',', '') FROM biblio LEFT JOIN items USING(biblionumber) WHERE items.homebranch='nekls' and items.itemcallnumber LIKE 'STORY %'



