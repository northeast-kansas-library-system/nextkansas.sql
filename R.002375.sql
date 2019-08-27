/*
R.002375

----------

Name: unknown
Created by: Heather Braum

----------

Group: -
     -

Created on: 2014-09-13 18:09:16
Modified on: 2015-12-09 15:29:28
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

select t.publishercode, t.pages, b.seriestitle, b.biblionumber, CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',b.biblionumber,'\" target="_blank">',b.biblionumber,'</a>'), b.title, b.author, CONCAT('<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=ti&q=',b.title,'&sort_by=title_az\" target="_blank">',b.title,'</a>') AS "Title Search", CONCAT('<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=au&q=',b.author,'&sort_by=title_az\" target="_blank">',b.author,'</a>') AS "Author Search" from items i left join biblio b using (biblionumber) left join biblioitems t using (biblionumber) WHERE b.seriestitle LIKE '%Dear America%' group by b.author ORDER BY b.author



