/*
R.001784

----------

Name: Possible brief records
Created by: Heather Braum

----------

Group: Administrative Reports
     Fix Bib Records-admin

Created on: 2013-04-03 00:03:16
Modified on: 2013-06-17 01:54:36
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT t.isbn, b.biblionumber, CONCAT ('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',b.biblionumber,'\" target="_blank">'"link to record"'</a>') AS "Linked Record", b.title, CONCAT('<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=ti&q=',b.title,'&sort_by=title_az\">',b.title,'</a>') AS "Title Search" FROM biblio b left join biblioitems t using (biblionumber) WHERE t.isbn IS NOT NULL AND t.pages IS NULL AND t.publishercode IS NULL AND t.size IS NULL AND t.illus IS NULL AND t.place IS NULL group by b.biblionumber ORDER BY b.biblionumber DESC LIMIT 1000



