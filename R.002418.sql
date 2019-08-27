/*
R.002418

----------

Name: Top 100 Circing Titles in a specific year & shelving location at your library
Created by: Heather Braum

----------

Group: Circulation
     Circ Stats

Created on: 2014-11-17 15:39:16
Modified on: 2014-11-17 15:40:06
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT count(statistics.datetime) AS circs, biblio.title, biblio.author, items.ccode FROM statistics JOIN items USING (itemnumber) 
LEFT JOIN biblio USING(biblionumber) WHERE YEAR(statistics.datetime) = <<enter four-digit year (yyyy)>> AND statistics.itemnumber IS NOT NULL AND statistics.branch=<<choose library|branches>> AND items.location =<<location|LOC>> GROUP BY biblio.biblionumber ORDER BY circs DESC LIMIT 100



