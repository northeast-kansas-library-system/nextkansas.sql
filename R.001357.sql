/*
R.001357

----------

Name: Materials added between dates
Created by: Heather Braum

----------

Group: Catalog Records and Items
     New Materials

Created on: 2012-04-23 14:44:49
Modified on: 2016-08-22 16:31:23
Date last run: 2025-03-11 07:13:30

----------

Public: 0
Expiry: 0

----------

Limited by branch. Only by dates. #added

----------
*/



select i.dateaccessioned, CONCAT('',b.biblionumber,'') as "Linked Record", CONCAT('',b.title,'') AS "Title Search", i.ccode, i.homebranch, t.pages, t.size, t.isbn from biblio b join items i using (biblionumber) join biblioitems t using (biblionumber) where i.homebranch=&lt;&gt;  AND i.dateaccessioned &gt;= &lt;&gt; AND i.dateaccessioned &lt;= &lt;&gt; GROUP BY b.biblionumber order by b.title ASC

























