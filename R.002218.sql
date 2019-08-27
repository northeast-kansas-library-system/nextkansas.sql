/*
R.002218

----------

Name: Records with Existing Placed Item Level Holds (To Check on)
Created by: Heather Braum

----------

Group: Administrative Reports
     Holds-admin

Created on: 2014-03-18 21:38:26
Modified on: 2014-03-20 12:17:39
Date last run: -

----------

Public: 0
Expiry: 0

----------

This report watches to see if hold revert to item level; as of 3/18/14, reserve_id 1021643 is the newest one... will have to periodically update this number. it ignores several ILL borrowers, focuses on known item level holds (as of 3/18/14), and skips holds with notes. 

----------
*/

SELECT r.reserve_id, r.reservedate, r.borrowernumber, p.firstname, p.surname, r.reservenotes, r.branchcode as pickup, p.branchcode as home, p.categorycode, CONCAT('<a href=\"/cgi-bin/koha/reserve/request.pl?biblionumber=',r.biblionumber,'\" target="_blank">',r.biblionumber,'</a>') AS "Link to Reserves", b.title FROM biblio b LEFT JOIN reserves r USING(biblionumber) LEFT JOIN borrowers p USING(borrowernumber) WHERE r.priority <> '0' AND r.itemnumber IS NOT NULL AND r.borrowernumber NOT IN ('192180','136926','29170','7857','34095','42724') AND reserve_id < '1022940' AND r.reservenotes = '' ORDER BY p.branchcode, p.categorycode



