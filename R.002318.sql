/*
R.002318

----------

Name: Holds with Duplicate Priorities
Created by: Heather Braum

----------

Group: Administrative Reports
     Holds-admin

Created on: 2014-08-09 18:41:18
Modified on: 2014-08-09 18:41:18
Date last run: 2017-07-11 11:41:44

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT title, CONCAT(  '<a href="/cgi-bin/koha/reserve/request.pl?biblionumber=', biblionumber,  '">Link to Reserves</a>' ) AS reserves_link
FROM reserves
LEFT JOIN biblio
USING ( biblionumber )
WHERE found IS NULL
GROUP BY biblionumber, priority
HAVING COUNT( biblionumber ) >1



