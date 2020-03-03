/*
R.001825

----------

Name: When was an item deleted, based on barcode?
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Weeding Criteria

Created on: 2013-05-03 13:05:44
Modified on: 2013-06-19 12:54:14
Date last run: 2020-01-07 12:12:50

----------

Public: 0
Expiry: 0

----------

Gives a timestamp and itemnumber and biblionumber from the deleteditems table for a barcode that was suspected to have been deleted. 

----------
*/

SELECT timestamp, itemnumber, bibilonumber FROM deleteditems WHERE barcode=<<enter barcode>>



