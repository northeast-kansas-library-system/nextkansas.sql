/*
R.002189

----------

Name: Top Circing Items
Created by: Heather Braum

----------

Group: Administrative Reports
     Circ Stats-admin

Created on: 2014-02-07 11:44:44
Modified on: 2014-02-07 11:44:44
Date last run: -

----------

Public: 0
Expiry: 300

----------

No limits. Run OFF HOURS only!

----------
*/

SELECT biblio.title, biblio.author, items.ccode, count(statistics.datetime) AS circs FROM statistics JOIN items USING (itemnumber) 
LEFT JOIN biblio USING(biblionumber) WHERE statistics.itemnumber IS NOT NULL AND items.ccode NOT IN ('GADGET','COMPUTER','MAGAZINE','ILL','MISC') AND items.itype NOT IN ('EQUIPMENT','KITS','ILL') GROUP BY biblio.biblionumber ORDER BY circs DESC LIMIT 20


