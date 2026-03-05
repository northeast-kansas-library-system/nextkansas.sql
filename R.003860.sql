/*
R.003860

----------

Name: Items by biblio count
Created by: George Williams

----------

Group: -
     -

Created on: 2024-09-25 15:47:27
Modified on: 2024-09-25 15:47:59
Date last run: 2025-03-28 17:32:25

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  items.biblionumber,
  COUNT(items.itemnumber)
FROM items 
GROUP BY 
  items.biblionumber
ORDER BY 
  COUNT(items.itemnumber) DESC
LIMIT 100

























