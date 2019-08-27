/*
R.002199

----------

Name: Eudora Call Numbers to Fix
Created by: Heather Braum

----------

Group: Library-Specific
     Eudora

Created on: 2014-03-11 12:49:22
Modified on: 2014-03-11 14:07:16
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

select i.itemcallnumber, b.title, i.barcode, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',b.biblionumber,'&itemnumber=',i.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit item" from biblio b left join items i using (biblionumber) 
where i.homebranch='EUDORA' AND i.ccode NOT IN ('MAGAZINE','BOOKONCD','DVD','LARGEPRINT') AND 
(i.itemcallnumber LIKE '% 0%' OR i.itemcallnumber LIKE '% 1%' OR i.itemcallnumber LIKE '% 2%' OR i.itemcallnumber LIKE '% 3%' OR i.itemcallnumber LIKE '% 4%' OR i.itemcallnumber LIKE '% 5%' OR i.itemcallnumber LIKE '% 6%' OR i.itemcallnumber LIKE '% 7%' OR i.itemcallnumber LIKE '% 8%' OR i.itemcallnumber LIKE '% 9%' OR i.itemcallnumber LIKE ' %' OR i.itemcallnumber LIKE '%  %' OR i.itemcallnumber LIKE '  %') ORDER BY i.itemcallnumber



