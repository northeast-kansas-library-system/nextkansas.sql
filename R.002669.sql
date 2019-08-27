/*
R.002669

----------

Name: Patrons who need to be alerted to waiting holds
Created by: Heather Braum

----------

Group: Holds-Reserves
     -

Created on: 2016-02-23 12:06:05
Modified on: 2016-02-23 14:16:43
Date last run: 2017-09-07 14:53:57

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT ('<a href=\"/cgi-bin/koha/circ/circulation.pl?borrowernumber=',borrowers.borrowernumber,'\" target="_blank">',borrowers.cardnumber,'</a>') AS "Link to Patron", firstname, surname, email, reserves.branchcode, count(*) as "hold count" FROM reserves LEFT JOIN borrowers USING (borrowernumber) WHERE found='W' and timestamp BETWEEN '2016-02-22 12:15:04' AND '2016-02-23 11:04' AND email <> '' AND reserves.branchcode=<<branch|branches>> GROUP BY borrowernumber LIMIT 90



