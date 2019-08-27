/*
R.001324

----------

Name: Circ stats for titles in a specific collection code, for all time
Created by: -

----------

Group: -
     -

Created on: 2012-02-17 13:14:33
Modified on: 2019-01-10 15:48:52
Date last run: 2019-08-14 15:20:31

----------

Public: 0
Expiry: 0

----------

Enhanced - just hit Run #circ

----------
*/

SELECT biblio.title,t.publicationyear,items.replacementprice,items.dateaccessioned,items.issues,items.itype,items.ccode,items.homebranch FROM items LEFT JOIN biblio USING (biblionumber) LEFT JOIN biblioitems t USING(biblionumber) WHERE items.homebranch=<<Pick your branch|branches>> AND items.ccode=<<Pick your Collection Code|CCODE>> GROUP BY biblio.biblionumber, items.itemnumber ORDER BY biblio.title asc





