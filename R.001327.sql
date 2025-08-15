/*
R.001327

----------

Name: Titles of Circs at a given branch
Created by: -

----------

Group: Circulation
     -

Created on: 2012-02-17 13:44:33
Modified on: 2013-09-25 17:26:21
Date last run: 2025-08-14 17:02:16

----------

Public: 0
Expiry: 0

----------

Enhanced - enter MM, YYYY and branch #circ

----------
*/



SELECT statistics.branch as Library, biblio.title, biblio.author, items.itemcallnumber, items.itype, items.ccode, items.location, items.homebranch as ItemBranch, statistics.itemtype FROM statistics LEFT JOIN items USING (itemnumber) LEFT JOIN biblio USING (biblionumber) WHERE statistics.type IN ('issue', 'renew') AND MONTH(statistics.datetime)= &lt;&gt; and YEAR(statistics.datetime)=&lt;&gt; and statistics.branch = &lt;&gt; ORDER BY statistics.branch, biblio.title

























