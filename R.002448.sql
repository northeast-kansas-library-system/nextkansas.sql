/*
R.002448

----------

Name: Titles with 3+ holds by your patrons (Doniphan-specific version)
Created by: Heather Braum

----------

Group:  Doniphan County
     -

Created on: 2015-01-22 14:29:18
Modified on: 2021-08-16 20:40:28
Date last run: 2018-12-18 13:20:44

----------

Public: 0
Expiry: 0

----------

Combined for all four Doniphan branches. 

----------
*/

SELECT CONCAT ('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',b.biblionumber,'\" target="_blank">'"link to record"'</a>') AS "link to record", b.title, (SELECT count(r.reserve_id) FROM reserves r WHERE r.biblionumber=b.biblionumber AND r.branchcode LIKE 'DONI%') as your_patron_holds, (SELECT i.ccode FROM items i WHERE i.biblionumber=r.biblionumber LIMIT 1) as collection, (SELECT count(i.itemnumber) FROM items i WHERE i.biblionumber=r.biblionumber AND i.damaged='0' AND i.withdrawn='0' AND itemlost='0' AND i.homebranch LIKE 'DONI%') as your_lib_holdings FROM biblio b LEFT JOIN reserves r USING (biblionumber) LEFT JOIN items i USING(biblionumber) WHERE r.biblionumber=b.biblionumber AND r.branchcode LIKE 'DONI%' AND r.biblionumber IN (SELECT r.biblionumber FROM reserves r WHERE r.biblionumber=b.biblionumber AND r.branchcode LIKE 'DONI%' GROUP BY r.biblionumber HAVING count(r.reserve_id) > '2') GROUP BY b.biblionumber HAVING count(r.reserve_id) > '2' ORDER BY your_lib_holdings asc



