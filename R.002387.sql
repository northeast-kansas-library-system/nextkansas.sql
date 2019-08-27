/*
R.002387

----------

Name: Call number prefixes to 6 characters
Created by: Heather Braum

----------

Group: Catalog Records and Items
     -

Created on: 2014-09-30 15:50:52
Modified on: 2014-09-30 15:55:38
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT itype,ccode, location, substring(itemcallnumber,1,6) AS callnumber, count(*) AS count FROM items WHERE items.homebranch=<<choose branch|branches>> 
GROUP BY itype, ccode, location, substring(itemcallnumber,1,6) 
ORDER BY callnumber



