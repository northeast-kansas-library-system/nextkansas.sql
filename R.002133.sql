/*
R.002133

----------

Name: Iniitial OVERBROOK notforloan report
Created by: Heather Braum

----------

Group: Library-Specific
     -

Created on: 2013-12-20 14:24:52
Modified on: 2013-12-20 14:32:02
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT barcode FROM items WHERE holdingbranch='OVERBROOK' AND homebranch='OVERBROOK' AND notforloan <> '1'



