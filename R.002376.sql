/*
R.002376

----------

Name: Most-Circulated Report at Your Library, limited by CCode and Shelving Location
Created by: Heather Braum

----------

Group: Popular Reports
     -

Created on: 2014-09-26 14:56:27
Modified on: 2015-08-16 20:42:26
Date last run: 2019-12-27 10:09:41

----------

Public: 0
Expiry: 0

----------

Shows items with more than XX total circs for various Collections.  Enhanced. Run and choose ccode; home branch; location; and enter minimum number of circs. #circ

----------
*/



SELECT items.barcode, items.itemcallnumber, CONCAT( '<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblio.biblionumber,'\" target="_blank">',biblio.biblionumber,'</a>' ) as 'Link to Record', biblio.title, t.publicationyear as 'Copyright', items.dateaccessioned as 'Accessioned', items.itype, items.ccode, items.issues, items.renewals,(IFNULL(items.issues,0)+IFNULL(items.renewals,0)) as
Total_Circ,items.datelastborrowed,items.itemlost,items.onloan,items.damaged,items.itemnotes FROM items LEFT JOIN biblio USING(biblionumber)  LEFT JOIN biblioitems t USING(biblionumber) WHERE items.homebranch=<<Pick Library|branches>> AND items.ccode=<<Pick your collection code|CCODE>> AND items.location = <<location|LOC>> AND items.issues > <<Minimum Number of Circs>> 
ORDER BY Total_Circ DESC

























