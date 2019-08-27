/*
R.001869

----------

Name: Checking on holds (priority is 0)
Created by: Heather Braum

----------

Group: Administrative Reports
     Holds-admin

Created on: 2013-05-23 14:22:40
Modified on: 2013-06-17 01:50:54
Date last run: -

----------

Public: 0
Expiry: 0

----------

Holds are in transit or waiting

----------
*/

SELECT CONCAT ('<a href=\"/cgi-bin/koha/reserve/request.pl?biblionumber=',reserves.biblionumber,'\" target="_blank">',reserves.reserve_id,'</a>') AS "Link to Reserve", CONCAT ('<a href=\"/cgi-bin/koha/members/moremember.pl?borrowernumber=',reserves.borrowernumber,'\" target="_blank">',reserves.borrowernumber,'</a>') AS "Link to Borrower", reserves.reservedate, CONCAT ('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',reserves.biblionumber,'\" target="_blank">',reserves.biblionumber,'</a>') AS "Link to Bib Record", borrowers.branchcode as "Patron Home", reserves.branchcode as "PICKUP location", reserves.priority, reserves.found AS "holds status", reserves.timestamp AS "hold last updated", CONCAT ('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',reserves.biblionumber,'\" target="_blank">',reserves.itemnumber,'</a>') AS "Link to Bib Record to look at item status", reserves.waitingdate AS "hold waiting at library since", count(items.itemnumber) AS "total number of items on bib" 
FROM borrowers JOIN reserves USING(borrowernumber) LEFT JOIN biblio USING(biblionumber) LEFT JOIN items USING(biblionumber) 
WHERE reserves.priority = '0'
GROUP BY reserves.reserve_id ORDER by reservedate DESC LIMIT 9000



