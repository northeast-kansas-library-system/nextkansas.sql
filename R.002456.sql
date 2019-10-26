/*
R.002456

----------

Name: Items lost report
Created by: Heather Braum

----------

Group: -
     -

Created on: 2015-02-05 14:43:34
Modified on: 2015-12-09 15:27:22
Date last run: 2019-06-03 16:56:34

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT items.itemnumber FROM items WHERE (((items.itemlost IN ('1','2','3','4')) OR items.withdrawn <> '0') AND items.timestamp < adddate(m,-13,getdate())) OR ((items.itemlost IN ('1','2','3','4')) AND items.itemlost_on < adddate(m,-13,getdate())) OR (items.withdrawn <> '0' AND items.itemwithdrawn_on < adddate(m,-13,getdate()))


