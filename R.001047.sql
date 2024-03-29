/*
R.001047

----------

Name: Most-Circulated Report at Your Library, limited by Item Type and Shelving Location
Created by: -

----------

Group: Popular Reports
     -

Created on: 2011-02-22 10:13:01
Modified on: 2015-08-16 17:02:11
Date last run: 2023-02-02 10:06:41

----------

Public: 0
Expiry: 0

----------

Shows items with more than XX total circs for various Item Types and shelving locations.  Enhanced. Run and choose itemtype; home branch; location; and enter minimum number of circs. #circ

----------
*/



SELECT items.barcode, items.itemcallnumber, CONCAT( '<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblio.biblionumber,'\" target="_blank">',biblio.biblionumber,'</a>' ) as 'Link to Record', biblio.title, biblioitems.publicationyear as 'Copyright', items.dateaccessioned as 'Accessioned', items.itype, items.ccode, items.issues, items.renewals,(IFNULL(items.issues,0)+IFNULL(items.renewals,0)) as
Total_Circ,items.datelastborrowed,items.itemlost,items.onloan,items.damaged,items.itemnotes FROM items LEFT JOIN biblio USING(biblionumber) LEFT JOIN biblioitems USING(biblionumber) WHERE items.homebranch=<<Pick Transacting Branch|branches>> AND items.itype=<<Pick your Item Type|itemtypes>> AND items.location = <<location|LOC>> AND items.issues > <<Minimum Number of Circs>>
ORDER BY Total_Circ DESC

























