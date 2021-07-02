/*
R.002381

----------

Name: Circ stats for titles in a specific shelving location, for a specific year
Created by: Heather Braum

----------

Group: Circulation
     Circ Stats

Created on: 2014-09-26 15:08:37
Modified on: 2021-06-17 16:00:42
Date last run: 2021-06-17 15:04:22

----------

Public: 0
Expiry: 300

----------

This report is old and probably isn't giving you the results you really want.  It will be evaluated in the second half of 2021.

----------
*/

SELECT biblio.title,count(statistics.datetime), items.itype,items.ccode,items.homebranch FROM biblio LEFT JOIN items USING (biblionumber) LEFT JOIN statistics USING(itemnumber) WHERE items.homebranch=<<Pick your branch|branches>> AND items.location=<<Pick your Shelving Location|LOC>> AND statistics.type IN ('issue','renew') AND YEAR(statistics.datetime)=<<enter yyyy year>> GROUP BY biblio.biblionumber ORDER BY biblio.title asc





