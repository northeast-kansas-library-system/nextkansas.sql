/*
R.001797

----------

Name: NULL ISBNs PH libraries
Created by: Heather Braum

----------

Group: Administrative Reports
     School Libraries-admin

Created on: 2013-04-18 17:51:37
Modified on: 2016-05-05 14:25:28
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT t.publicationyear, CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',b.biblionumber,'\" target="_blank">',b.biblionumber,'</a>') as "Linked Record", CONCAT('<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=ti&q=',b.title,'&sort_by=title_az\" target="_blank">',b.title,'</a>') AS "Title Search", CONCAT('<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=au&q=',b.author,'&sort_by=title_az\" target="_blank">',b.author,'</a>') AS "Author Search" from biblio b join items i using (biblionumber) left join biblioitems t using (biblionumber) where i.homebranch IN ('PHSMS') AND t.isbn IS NULL AND t.issn IS NULL AND i.itype NOT IN ('MAGAZINE','EQUIPMENT') AND b.biblionumber >= "550000" and b.biblionumber NOT IN ('566832','569147','568083','567350','563924','571253','571252','571251','571250','569527','569523','569522','571059','571221','571274','571420','571832','569215','569275','569313','569559','504126','569896','570282','570521','570553','570549','570588','570791','570912','571024','571059','571153','567312','571621','504845','571832','571892','576188','576187','576186','570719','569830','569352','569353','569504','569506','569524','559717','563850570559','561015','571249','568920','567174','563230','562849','561352','570541','565805','565798','565791','565782','565624','563874','563868','563858','563850','559717','570903','570559','569677','569676','569675','569351','567438','567376','565737','564664','564623','564085','563808','562815','562814','562813','562812','562811','562810','562809','562808','551195','562807','562806','572144','572143','572142','572141','572140','572139','572138','572136','572135','572134','572133','572132','572131','572130','572129','572128','572127','574347','574270','572237','573506') group by b.biblionumber order by t.publicationyear desc, b.biblionumber DESC



