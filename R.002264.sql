/*
R.002264

----------

Name: Bonner Accountlines to Purge
Created by: Heather Braum

----------

Group: Library-Specific
     Bonner Springs

Created on: 2014-05-14 20:59:55
Modified on: 2018-12-09 22:03:46
Date last run: 2018-12-09 22:03:49

----------

Public: 0
Expiry: 0

----------

VHS related accountlines to purge at Kim Beets' request.

----------
*/

SELECT b.branchcode, b.cardnumber, b.surname, b.firstname, a.accountlines_id, b.borrowernumber, a.accountno, a.itemnumber, a.date, a.description, a.accounttype, a.amountoutstanding, a.timestamp, a.lastincrement, a.note, a.manager_id FROM borrowers b LEFT JOIN accountlines a USING(borrowernumber) LEFT JOIN items i USING(itemnumber) WHERE b.branchcode='BONNERSPGS' AND i.homebranch='BONNERSPGS' AND i.ccode='VHS' AND a.accounttype IN ('FU','L','F') AND a.amountoutstanding > 0  ORDER BY b.borrowernumber



