/*
R.001307

----------

Name: Not For Loan Items
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Not For Loan

Created on: 2012-01-30 10:48:39
Modified on: 2013-11-17 13:54:18
Date last run: 2019-10-17 13:38:54

----------

Public: 0
Expiry: 0

----------

Bib number is linked to bib record and title is linked to  a search by title. Choose branch. #notforloan

----------
*/

select CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',b.biblionumber,'\" target="_blank">',b.biblionumber,'</a>') as "Linked Record", CONCAT('<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=ti&q=',b.title,'&sort_by=title_az\">',b.title,'</a>') AS "Title Search", i.homebranch, i.ccode, i.itype from biblio b left join items i using (biblionumber) where i.homebranch=<<branch|branches>> AND i.notforloan !='0' order by i.itype, i.ccode DESC




