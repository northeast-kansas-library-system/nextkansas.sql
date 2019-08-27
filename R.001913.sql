/*
R.001913

----------

Name: Search by Title
Created by: Heather Braum

----------

Group: Administrative Reports
     Catalog-admin

Created on: 2013-06-21 16:14:17
Modified on: 2013-06-24 21:59:01
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

select CONCAT ('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',b.biblionumber,'\" target="_blank">'"link to record"'</a>') AS "Linked Record", b.biblionumber, b.title, b.author, count(i.itemnumber), CONCAT('<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=ti&q=',b.title,'&sort_by=title_az\" target="_blank">',b.title,'</a>') AS "Title Search" from biblio b join items i using (biblionumber) left join biblioitems t using (biblionumber) WHERE b.title LIKE <<title>> AND i.itype <> 'AUDIOBOOK' group by b.biblionumber HAVING count(i.itemnumber) > 0 order by b.title, t.pages, t.publishercode LIMIT 1000



