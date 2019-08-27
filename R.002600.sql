/*
R.002600

----------

Name: Lansing Patrons that have old LANS cards, who owe more than 25.00
Created by: Heather Braum

----------

Group: Library-Specific
     Lansing

Created on: 2015-09-08 15:06:04
Modified on: 2015-09-08 15:07:57
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT b.cardnumber, CAST(SUM(a.amountoutstanding) AS DECIMAL(4,2)) as amount_owed, CONCAT('<a href=\"/cgi-bin/koha/members/boraccount.pl?borrowernumber=',b.borrowernumber,'\" target="_blank">'"access patron fines"'</a>') as "patron fines" FROM borrowers b LEFT JOIN accountlines a USING(borrowernumber) WHERE b.branchcode='LANSING' AND b.cardnumber LIKE 'LANS%' AND b.borrowernumber NOT IN (SELECT borrowernumber FROM issues) AND b.borrowernumber IN (SELECT borrowernumber FROM accountlines) GROUP BY a.borrowernumber HAVING SUM(a.amountoutstanding) > 25.00 ORDER BY amount_owed



