/*
R.002626

----------

Name: ticket30361
Created by: Bywater bwssupport

----------

Group: -
     -

Created on: 2015-11-02 17:18:33
Modified on: 2015-11-02 17:18:33
Date last run: -

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
b.borrowernumber as "borrower", b.surname, b.firstname, b.dateexpiry, b.cardnumber, b.borrowernotes, CONCAT ('<a href=\"/cgi-bin/koha/circ/circulation.pl?borrowernumber=',b.borrowernumber,'\" target="_blank">',b.cardnumber,'</a>') AS "Link to Circ Page" 
FROM
borrowers b
LEFT JOIN accountlines al USING (borrowernumber)
LEFT JOIN issues i USING (borrowernumber)
LEFT JOIN borrowers b2 ON (b2.guarantorid = b.borrowernumber)
WHERE
b.dateexpiry < '2013-11-01'
AND b.categorycode NOT IN ('STAFF','ASSOCIATE','INHOUSE')
AND al.borrowernumber IS NULL
AND b2.borrowernumber IS NULL
AND i.borrowernumber IS NULL



