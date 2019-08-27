/*
R.001271

----------

Name: Search by Title, Limited by Collection Code (Linked)
Created by: Heather Braum

----------

Group: Administrative Reports
     Duplicate Records-admin

Created on: 2011-12-18 14:18:59
Modified on: 2014-01-15 00:40:07
Date last run: 2018-12-22 09:10:10

----------

Public: 0
Expiry: 0

----------

For Cleanup Purposes. Select Branch & Collection Code from dropdown. Titles are linked to a search by title in this version.

----------
*/

select i.barcode, b.biblionumber, i.itemcallnumber, i.ccode, i.itype, i.location, CONCAT('<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=ti&q=',b.title,'&sort_by=title_az\" target="_blank">',b.title,'</a>') AS "Title Search", b.author, i.homebranch, t.pages, t.size, t.isbn from biblio b join items i using (biblionumber) join biblioitems t using (biblionumber) where i.homebranch=<<homebranch|branches>> and i.ccode=<<ccode|CCODE>> group by b.biblionumber order by b.biblionumber DESC LIMIT 1000



