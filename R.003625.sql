/*
R.003625

----------

Name: Report from Wiki
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-11-30 12:43:25
Modified on: 2023-03-29 08:58:26
Date last run: 2023-03-29 09:00:17

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT  ' ' AS Checkbox, b.title, b.author, i.itemcallnumber, i.barcode
FROM items i
JOIN biblio b USING (biblionumber)
WHERE i.homebranch=<<Choose your library|branches>> AND 
      b.author LIKE CONCAT(<<Author: Last Name, First Name>>,'%')
ORDER BY b.title

























