/*
R.002309

----------

Name: Title, Series, and Circulation Info for a Collection Code
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Collection Statistics

Created on: 2014-08-05 10:12:05
Modified on: 2017-12-18 15:40:22
Date last run: 2020-10-29 09:49:06

----------

Public: 0
Expiry: 0

----------



----------
*/

select DISTINCT CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',b.biblionumber,'\" target="_blank">',b.biblionumber,'</a>'), b.title, b.author, i.itemcallnumber, ExtractValue(t.metadata, '//datafield[@tag="440"]/subfield[@code>="a"]') as "440 series info", ExtractValue(t.metadata, '//datafield[@tag="490"]/subfield[@code>="z"]') as "490 series info", (IFNULL(i.issues,0)+IFNULL(i.renewals,0)) as Total_Circ from biblio b left join biblio_metadata t using (biblionumber) join items i using (biblionumber) WHERE i.homebranch=<<choose library|branches>> AND i.ccode=<<collection code|CCODE>> GROUP BY i.biblionumber



