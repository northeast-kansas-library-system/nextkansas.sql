/*
R.001868

----------

Name: Checking on holds Older than July 1, 2013
Created by: Heather Braum

----------

Group: Administrative Reports
     Holds-admin

Created on: 2013-05-23 14:21:34
Modified on: 2019-05-03 19:30:47
Date last run: 2025-02-27 10:57:51

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT CONCAT ('',reserves.reserve_id,'') AS "Link to Reserve", CONCAT ('',reserves.borrowernumber,'') AS "Link to Borrower", reserves.reservedate, CONCAT ('',reserves.biblionumber,'') AS "Link to Bib Record", borrowers.branchcode as "Patron Home", reserves.branchcode as "PICKUP location", reserves.priority, reserves.found AS "holds status", reserves.timestamp AS "hold last updated", CONCAT ('',reserves.biblionumber,'') AS "Link to Bib Record to look at item status", reserves.waitingdate AS "hold waiting at library since", count(items.itemnumber) AS "total number of items on bib" 
FROM borrowers JOIN reserves USING(borrowernumber) LEFT JOIN biblio USING(biblionumber) LEFT JOIN items USING(biblionumber) 
WHERE reserves.reservedate < '2015-01-01' AND reserves.timestamp < '2015-01-01'
GROUP BY reserves.reserve_id ORDER by reservedate ASC LIMIT 9000

























