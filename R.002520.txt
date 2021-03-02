/*
R.002520

----------

Name: Fixing Booksellerid, source of acquisition
Created by: Heather Braum

----------

Group: Library-Specific
     Holton

Created on: 2015-06-04 12:45:47
Modified on: 2015-08-16 19:58:25
Date last run: 2019-02-26 14:43:51

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT i.dateaccessioned,b.title, b.author,t.publicationyear, i.location,i.itype,i.itemcallnumber,i.barcode, i.booksellerid, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',b.biblionumber,'&itemnumber=',i.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit barcode" FROM items i LEFT JOIN biblio b USING (biblionumber) LEFT JOIN biblioitems t USING(biblionumber) WHERE homebranch='HOLTON' and (booksellerid NOT IN ('Abe Books','ABI-CLIO','Alibris','Amazon','Amer. Kids','American Library','Artist','Author','B&N.com','Basehor ','Best Buy','Better World','BMI','Book Farm','Books are Fun','Books on Tape','Books R Fun','Bookworm','Borders','Cathy Boyd','Cengage','Centerpoint','Chandler','Childrens Plus','Child%s World','Christian Book & Gift','Costco','Curley Books','Dillons','Doubleday','ebay','Free State Press','Gale','Garage Sale','Gift','Grey House Publishing','Grolier','GS','Guideposts','Gum%rop','Guys Read Grant - State Library of Kansas','Hastings','Hesston Lib.','Holton Country Mart','HyVee','I love a mystery','Indie Ink','Jo-Ann','Johns Hopkins','Kansas Heritage Center','Kansas Heritage Center','King Souper','Kmart','Knowbuddy Resources','Kohls','Large Print Overstocks','Library Choice','Lifeway','Linwood PL','LPO','Lulu','McNaughton','MicroMarketing','MidAmerica','National Geographic','NEKLS','Ollis Books','Paper Source','PCUniverse','Penworthy','Quill.com','Randy Sauer','Recorded Books','Reminise','Rosie Cutrer','Sagebrush','Salem','Sams','Scholastic','SEBCO','Sentimental Productions','S%ow Me Books','Southeastern','State Library','Sunflower Supply','Tandem Books','Taped Editions','Target','Taste of Home','The Raven','Thrift Book','Today S%ow','Walmart','Wamego Library','Watermark','World Book'))
ORDER BY i.dateaccessioned desc



