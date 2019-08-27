/*
R.002380

----------

Name: Circ stats for titles in a specific item type, for a specific year
Created by: Heather Braum

----------

Group: Circulation
     Circ Stats

Created on: 2014-09-26 15:07:15
Modified on: 2015-01-20 09:41:36
Date last run: 2018-10-17 17:40:38

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT biblio.title,count(statistics.datetime), items.itype,items.ccode,items.homebranch FROM biblio LEFT JOIN items USING (biblionumber) LEFT JOIN statistics USING(itemnumber) WHERE items.homebranch=<<Pick your branch|branches>> AND items.itype=<<Pick your Item Type|itemtypes>> AND statistics.type IN ('issue','renew') AND YEAR(statistics.datetime)=<<enter yyyy year>> GROUP BY biblio.biblionumber ORDER BY biblio.title asc





