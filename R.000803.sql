/*
R.000803

----------

Name: Most Reserved Titles
Created by:  Tongie Book Club

----------

Group: Popular Reports
     -

Created on: 2010-02-03 11:08:36
Modified on: 2013-11-17 12:13:23
Date last run: 2020-12-16 12:52:31

----------

Public: 0
Expiry: 0

----------

For Leased ordering/collection development

----------
*/

SELECT biblio.title, biblio.author, items.replacementprice, items.itype, items.ccode, count(DISTINCT reserves.borrowernumber) as reservecount, count(DISTINCT items.itemnumber) as itemcount FROM reserves LEFT JOIN items USING (biblionumber) LEFT JOIN biblio USING (biblionumber) GROUP BY reserves.biblionumber ORDER BY reservecount DESC



