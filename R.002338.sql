/*
R.002338

----------

Name: Large print in title erroneously
Created by: Heather Braum

----------

Group: Administrative Reports
     Fix Bib Records-admin

Created on: 2014-08-24 23:18:48
Modified on: 2014-08-25 22:35:06
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT title, CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblionumber,'" target="_blank">',biblionumber,'</a>') AS biblionumber FROM biblio WHERE title LIKE '%large%print]%' OR title LIKE '%large%print)%' AND biblionumber nOT IN ('624284','626740','629923','636577','637491','637813')



