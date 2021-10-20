/*
R.000907

----------

Name: Problem local and walk-in holds
Created by: -

----------

Group: Administrative Reports
     Holds-admin

Created on: 2010-08-20 14:16:46
Modified on: 2013-06-18 18:25:53
Date last run: 2019-03-07 12:48:35

----------

Public: 0
Expiry: 0

----------



----------
*/



select biblio.title, items.barcode, items.homebranch, items.itype, borrowers.surname, borrowers.firstname, borrowers.cardnumber, borrowers.branchcode as 'patron branch', reserves.branchcode as 'pickup branch', reserves.found as 'status', reserves.waitingdate from reserves, items, borrowers, biblio where reserves.itemnumber = items.itemnumber and reserves.borrowernumber = borrowers.borrowernumber and items.biblionumber = biblio.biblionumber and reserves.priority = '0' and reserves.found in ('T', 'W') and items.itype in ('LOCALHOLD', 'LOCALHOLD1', 'LOCALHOLD2', 'WALKIN', 'WALKIN1', 'WALKIN2') and items.homebranch != borrowers.branchcode order by reserves.found, reserves.branchcode, biblio.title

























