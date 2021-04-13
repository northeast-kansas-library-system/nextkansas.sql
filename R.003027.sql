/*
R.003027

----------

Name: GHW - Old reports tester
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-01-02 22:49:27
Modified on: 2018-01-02 22:55:31
Date last run: 2018-01-02 22:58:59

----------

Public: 0
Expiry: 300

----------

1285

----------
*/

SELECT items.itemnumber, items.homebranch,items.barcode,items.dateaccessioned,items.ccode,items.itemcallnumber,items.itype,biblio.author,biblio.title FROM items JOIN biblio USING(biblionumber) WHERE items.ccode IS NULL OR items.ccode='XXX' order by items.homebranch



