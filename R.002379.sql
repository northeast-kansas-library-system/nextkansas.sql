/*
R.002379

----------

Name: Most-Circulated Report at Your Library, limited by Shelving Location
Created by: Heather Braum

----------

Group: Popular Reports
     -

Created on: 2014-09-26 14:59:34
Modified on: 2015-08-16 20:39:00
Date last run: 2019-07-09 17:33:49

----------

Public: 0
Expiry: 0

----------

Shows items with more than XX total circs for various shelving locations.  Enhanced. Run and choose home branch; location; and enter minimum number of circs. #circ

----------
*/

SELECT items.barcode, items.itemcallnumber, CONCAT( '<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblio.biblionumber,'\" target="_blank">',biblio.biblionumber,'</a>' ) as 'Link to Record', biblio.title, t.publicationyear as 'Copyright', items.dateaccessioned as 'Accessioned', items.itype, items.ccode, items.issues, items.renewals,(IFNULL(items.issues,0)+IFNULL(items.renewals,0)) as
Total_Circ,items.datelastborrowed,items.itemlost,items.onloan,items.damaged,items.itemnotes FROM items LEFT JOIN biblio USING(biblionumber)  LEFT JOIN biblioitems t USING(biblionumber) WHERE items.homebranch=<<Pick Transacting Branch|branches>> AND items.issues > <<Minimum Number of Circs>> and items.location = <<location|LOC>> 
ORDER BY Total_Circ DESC



