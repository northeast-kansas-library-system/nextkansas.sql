/*
R.002417

----------

Name: Top Circing Items in Last Six Months at Your Library in a Collection Code & Shelving Location
Created by: Heather Braum

----------

Group: Circulation
     Circ Stats

Created on: 2014-11-17 15:36:58
Modified on: 2014-11-17 15:36:58
Date last run: 2019-09-05 17:07:19

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT count(statistics.datetime) AS circs, biblio.title, biblio.author, items.ccode FROM statistics JOIN items USING (itemnumber) 
LEFT JOIN biblio USING(biblionumber) WHERE DATE(statistics.datetime) > DATE_SUB(CURRENT_DATE(),INTERVAL 6 MONTH) AND DATE(statistics.datetime)<=CURRENT_DATE() AND statistics.itemnumber IS NOT NULL AND statistics.branch=<<choose library|branches>> AND items.ccode=<<ccode|CCODE>> AND items.location =<<location|LOC>> GROUP BY biblio.biblionumber ORDER BY circs DESC



