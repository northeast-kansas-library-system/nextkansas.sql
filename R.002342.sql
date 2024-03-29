/*
R.002342

----------

Name: Shows Titles with 3+ holds by your patrons + library copies owned + ccode
Created by: Heather Braum

----------

Group: Popular Reports
     -

Created on: 2014-08-26 13:41:23
Modified on: 2015-01-22 14:24:15
Date last run: 2023-05-22 16:14:03

----------

Public: 0
Expiry: 0

----------

Related to Report #2331

----------
*/



SELECT r.branchcode, CONCAT ('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',b.biblionumber,'\" target="_blank">'"link to record"'</a>') AS "link to record", b.title, (SELECT count(r.reserve_id) FROM reserves r WHERE r.biblionumber=b.biblionumber AND r.branchcode=<<choose branch|branches>>) as your_patron_holds, (SELECT i.ccode FROM items i WHERE i.biblionumber=r.biblionumber LIMIT 1) as collection, (SELECT count(i.itemnumber) FROM items i WHERE i.biblionumber=r.biblionumber AND i.homebranch=r.branchcode AND i.damaged='0' AND i.withdrawn='0' AND itemlost='0') as your_lib_holdings FROM biblio b LEFT JOIN reserves r USING (biblionumber) LEFT JOIN items i USING(biblionumber) WHERE r.biblionumber=b.biblionumber AND r.branchcode=<<choose your library|branches>> AND r.biblionumber IN (SELECT r.biblionumber FROM reserves r WHERE r.biblionumber=b.biblionumber AND r.branchcode=<<choose branch|branches>> GROUP BY r.biblionumber HAVING count(r.reserve_id) > '2') GROUP BY b.biblionumber, r.branchcode HAVING count(r.reserve_id) > '2' ORDER BY your_lib_holdings asc

























