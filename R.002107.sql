/*
R.002107

----------

Name: Circ stats for titles in a specific collection code, for a specific year
Created by: Heather Braum

----------

Group: Circulation
     Circ Stats

Created on: 2013-11-19 21:56:16
Modified on: 2013-11-19 22:00:00
Date last run: 2025-02-25 13:56:14

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT biblio.title,count(statistics.datetime), items.itype,items.ccode,items.homebranch FROM biblio LEFT JOIN items USING (biblionumber) LEFT JOIN statistics USING(itemnumber) WHERE items.homebranch=&lt;&gt; AND items.ccode=&lt;&gt; AND statistics.type IN ('issue','renew') AND YEAR(statistics.datetime)=&lt;&gt; GROUP BY biblio.biblionumber ORDER BY biblio.title asc



























