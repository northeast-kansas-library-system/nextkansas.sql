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
Date last run: 2023-12-19 17:58:07

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT count(statistics.datetime) AS circs, biblio.title, biblio.author, items.ccode FROM statistics JOIN items USING (itemnumber) 
LEFT JOIN biblio USING(biblionumber) WHERE DATE(statistics.datetime) > DATE_SUB(CURRENT_DATE(),INTERVAL 6 MONTH) AND DATE(statistics.datetime)<=CURRENT_DATE() AND statistics.itemnumber IS NOT NULL AND statistics.branch=<> AND items.ccode=<> AND items.location =<> GROUP BY biblio.biblionumber ORDER BY circs DESC

























