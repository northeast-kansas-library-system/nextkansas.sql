/*
R.003625

----------

Name: Report from Wiki
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-11-30 12:43:25
Modified on: 2021-11-30 12:43:25
Date last run: 2022-12-14 11:52:05

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT  ' ' AS Checkbox, b.title, b.author, i.itemcallnumber, i.barcode
FROM items i
JOIN biblio b USING (biblionumber)
WHERE i.homebranch=<<Branch|branches>> AND 
      b.author LIKE CONCAT(<<Author: Last Name, First Name>>,'%')
ORDER BY b.title

























