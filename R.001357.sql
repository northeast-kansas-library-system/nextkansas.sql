/*
R.001357

----------

Name: Materials added between dates
Created by: Heather Braum

----------

Group: Catalog Records and Items
     New Materials

Created on: 2012-04-23 14:44:49
Modified on: 2016-08-22 16:31:23
Date last run: 2022-12-02 11:24:41

----------

Public: 0
Expiry: 0

----------

Limited by branch. Only by dates. #added

----------
*/



select i.dateaccessioned, CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',b.biblionumber,'\" target="_blank">',b.biblionumber,'</a>') as "Linked Record", CONCAT('<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=ti&q=',b.title,'&sort_by=title_az\" target="_blank">',b.title,'</a>') AS "Title Search", i.ccode, i.homebranch, t.pages, t.size, t.isbn from biblio b join items i using (biblionumber) join biblioitems t using (biblionumber) where i.homebranch=<<branch|branches>>  AND i.dateaccessioned >= <<Date you want to count (example: 2011-11-16)|date>> AND i.dateaccessioned <= <<Day after the Date you want to count (example: 2011-11-17)|date>> GROUP BY b.biblionumber order by b.title ASC

























