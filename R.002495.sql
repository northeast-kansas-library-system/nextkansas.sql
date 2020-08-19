/*
R.002495

----------

Name: Patrons expired 2+ years ago, who don't owe anything & don't have anything checked out
Created by: Heather Braum

----------

Group: Patrons
     -

Created on: 2015-05-11 15:01:57
Modified on: 2015-10-06 14:11:32
Date last run: 2020-07-22 15:51:39

----------

Public: 0
Expiry: 0

----------

Choose your library. Patrons who expired more than two years ago and don't owe any money. Until we can figure out how to exclude qualified-to-be-deleted guarantors with not-qualified-to-be-deleted guarantees, all guarantors will be included in this report.

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
 b.branchcode=<<choose library|branches>>
  AND b.dateexpiry < '2013-11-01'
  AND b.categorycode NOT IN ('STAFF','ASSOCIATE','INHOUSE')
  AND al.borrowernumber IS NULL
  AND b2.borrowernumber IS NULL
  AND i.borrowernumber IS NULL



