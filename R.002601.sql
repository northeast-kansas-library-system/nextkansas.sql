/*
R.002601

----------

Name: Lansing patrons with LANS cards who still have items checked out
Created by: Heather Braum

----------

Group: Library-Specific
     Lansing

Created on: 2015-09-08 15:07:27
Modified on: 2015-09-08 15:07:40
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT b.cardnumber, CAST(SUM(a.amountoutstanding) AS DECIMAL(4,2)) as amount_owed, CONCAT('<a href=\"/cgi-bin/koha/members/boraccount.pl?borrowernumber=',b.borrowernumber,'\" target="_blank">'"access patron fines"'</a>') as "patron fines" FROM borrowers b LEFT JOIN accountlines a USING(borrowernumber) WHERE b.branchcode='LANSING' AND b.cardnumber LIKE 'LANS%' AND b.borrowernumber IN (SELECT borrowernumber FROM issues) GROUP BY b.cardnumber


