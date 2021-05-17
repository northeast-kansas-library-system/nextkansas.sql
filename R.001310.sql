/*
R.001310

----------

Name: Top Circing Items in the Last Six Months in Entire Catalog
Created by: Heather Braum

----------

Group: Circulation
     Circ Stats

Created on: 2012-01-31 18:43:08
Modified on: 2014-11-17 15:35:37
Date last run: 2021-05-13 09:29:43

----------

Public: 0
Expiry: 0

----------

#circ

----------
*/

SELECT count(statistics.datetime) AS circs, biblio.title, biblio.author, items.ccode FROM statistics JOIN items USING (itemnumber) 
LEFT JOIN biblio USING(biblionumber) WHERE DATE(statistics.datetime) > DATE_SUB(CURRENT_DATE(),INTERVAL 6 MONTH) AND DATE(statistics.datetime)<=CURRENT_DATE() AND statistics.itemnumber IS NOT NULL AND items.ccode=<<ccode|CCODE>> AND items.location =<<location|LOC>> GROUP BY biblio.biblionumber ORDER BY circs DESC LIMIT 20



