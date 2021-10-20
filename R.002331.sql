/*
R.002331

----------

Name: Titles With 3+ Holds By Patrons at a Library
Created by: Heather Braum

----------

Group: Popular Reports
     -

Created on: 2014-08-16 13:15:23
Modified on: 2017-02-01 08:15:32
Date last run: 2021-02-10 16:02:29

----------

Public: 0
Expiry: 0

----------

This report shows records with 3+ holds by a single library's patrons, and shows how many copies that library has in the system. It does not count items marked lost, damaged or withdrawn. 

----------
*/



SELECT r.branchcode, CONCAT ('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',r.biblionumber,'\" target="_blank">'"link to record"'</a>') AS "link to record", b.title, count(r.reserve_id) as your_patron_holds, (SELECT count(i.itemnumber) FROM items i WHERE i.biblionumber=r.biblionumber AND i.homebranch=r.branchcode AND i.damaged='0' AND i.withdrawn='0' AND itemlost='0') as your_lib_holdings FROM biblio b LEFT JOIN reserves r USING (biblionumber) JOIN borrowers p USING(borrowernumber)  WHERE r.branchcode=<<choose your library|branches>> GROUP BY r.biblionumber, r.branchcode HAVING count(r.reserve_id) > 2 ORDER BY your_lib_holdings asc

























