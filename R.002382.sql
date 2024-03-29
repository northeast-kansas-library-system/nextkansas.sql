/*
R.002382

----------

Name: Top 100 Circing Titles in a Collection Code in a Specific Year
Created by: Heather Braum

----------

Group: Popular Reports
     -

Created on: 2014-09-26 15:09:31
Modified on: 2014-09-26 15:13:16
Date last run: 2022-12-28 14:39:43

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT biblio.title,count(statistics.datetime), items.itype,items.ccode FROM biblio LEFT JOIN items USING (biblionumber) LEFT JOIN statistics USING(itemnumber) WHERE statistics.branch=<<Pick your branch|branches>> AND items.ccode=<<Pick your Collection Code|CCODE>> AND statistics.type IN ('issue','renew') AND YEAR(statistics.datetime)=<<enter yyyy year>> GROUP BY biblio.biblionumber ORDER BY count(statistics.datetime) DESC LIMIT 100



























