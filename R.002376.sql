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
Date last run: 2024-03-18 14:45:21

----------

Public: 0
Expiry: 0

----------

Shows items with more than XX total circs for various Collections.  Enhanced. Run and choose ccode; home branch; location; and enter minimum number of circs. #circ

----------
*/



SELECT items.barcode, items.itemcallnumber, CONCAT( '',biblio.biblionumber,'' ) as 'Link to Record', biblio.title, t.publicationyear as 'Copyright', items.dateaccessioned as 'Accessioned', items.itype, items.ccode, items.issues, items.renewals,(IFNULL(items.issues,0)+IFNULL(items.renewals,0)) as
Total_Circ,items.datelastborrowed,items.itemlost,items.onloan,items.damaged,items.itemnotes FROM items LEFT JOIN biblio USING(biblionumber)  LEFT JOIN biblioitems t USING(biblionumber) WHERE items.homebranch=<> AND items.ccode=<> AND items.location = <> AND items.issues > <> 
ORDER BY Total_Circ DESC

























