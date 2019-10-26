/*
R.002209

----------

Name: Records with Newly Placed Item Level Holds
Created by: Heather Braum

----------

Group: Administrative Reports
     Holds-admin

Created on: 2014-03-13 22:19:18
Modified on: 2014-03-19 10:08:08
Date last run: -

----------

Public: 0
Expiry: 0

----------

this one looks for newly placed item level holds (user error); as of 3/18/14, reserve_id 1021643 is the newest one... will have to periodically update this number; it ignores several ILL borrowers. 

----------
*/

SELECT r.reserve_id, r.reservedate, r.borrowernumber, p.firstname, p.surname, r.reservenotes, r.branchcode as pickup, p.branchcode as home, p.categorycode, CONCAT('<a href=\"/cgi-bin/koha/reserve/request.pl?biblionumber=',r.biblionumber,'\" target="_blank">',r.biblionumber,'</a>') AS "Link to Reserves", b.title FROM biblio b LEFT JOIN reserves r USING(biblionumber) LEFT JOIN borrowers p USING(borrowernumber) WHERE r.priority <> '0' AND r.itemnumber IS NOT NULL AND r.borrowernumber NOT IN ('192180','136926','29170','7857','34095','42724') AND reserve_id > '1021855' AND r.reservenotes = '' ORDER BY p.branchcode, p.categorycode


