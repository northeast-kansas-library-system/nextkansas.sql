/*
R.002663

----------

Name: NEKLS Prof Collection - PLAN
Created by: Heather Braum

----------

Group: Library-Specific
     NEKLS

Created on: 2016-02-02 11:35:55
Modified on: 2016-02-02 11:35:55
Date last run: 2018-07-02 17:28:01

----------

Public: 1
Expiry: 300

----------

PLAN call number prefix

----------
*/

SELECT biblio.biblionumber, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(title, ' /', ''), ',', ''), ' :', ''), '"', ''), ';', ''), '\"', ''), '/', ''), REPLACE(author, ',', '') FROM biblio LEFT JOIN items USING(biblionumber) WHERE items.homebranch='nekls' and items.itemcallnumber LIKE 'PLAN %'



