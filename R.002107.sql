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
Date last run: 2020-01-14 11:43:55

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT biblio.title,count(statistics.datetime), items.itype,items.ccode,items.homebranch FROM biblio LEFT JOIN items USING (biblionumber) LEFT JOIN statistics USING(itemnumber) WHERE items.homebranch=<<Pick your branch|branches>> AND items.ccode=<<Pick your Collection Code|CCODE>> AND statistics.type IN ('issue','renew') AND YEAR(statistics.datetime)=<<enter yyyy year>> GROUP BY biblio.biblionumber ORDER BY biblio.title asc





