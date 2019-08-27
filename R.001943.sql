/*
R.001943

----------

Name: Number of Bib Records created Per Day
Created by: Heather Braum

----------

Group: Administrative Reports
     Catalog-admin

Created on: 2013-07-17 14:46:07
Modified on: 2013-11-17 12:34:28
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

select datecreated, count(biblionumber) FROM biblio GROUP BY datecreated LIMIT 5000



