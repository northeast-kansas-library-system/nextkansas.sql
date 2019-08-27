/*
R.002362

----------

Name: Checking holds on Migrated Library's materials on poss. dup records
Created by: Heather Braum

----------

Group: Administrative Reports
     Post-Lansing

Created on: 2014-09-07 09:29:20
Modified on: 2016-09-01 11:48:19
Date last run: -

----------

Public: 0
Expiry: 0

----------

Set for Paola, 9/1/16, hb.

----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblionumber,'\" target="_blank">',biblio.biblionumber,'</a>'), biblio.title, count(*) as "Number of Holds", items.ccode, GROUP_CONCAT(reservedate) as hold_date
FROM reserves left join biblio USING(biblionumber) LEFT JOIN items USING(biblionumber)
WHERE biblio.biblionumber BETWEEN '745658' AND '756704' AND biblio.timestamp < '2016-08-29' AND biblio.biblionumber IN (SELECT biblionumber FROM items WHERE homebranch='PAOLA') GROUP BY reserves.biblionumber ORDER BY hold_date DESC LIMIT 7000 



