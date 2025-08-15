/*
R.001596

----------

Name: Holds Waiting Pickup (by branch)
Created by: Heather Braum

----------

Group: Holds-Reserves
     -

Created on: 2012-10-15 11:33:12
Modified on: 2013-06-17 02:03:08
Date last run: 2025-04-03 12:12:18

----------

Public: 0
Expiry: 0

----------

Limited by Branch. Lists all items WAITING for more than 7 days

----------
*/



SELECT reserves.waitingdate, reserves.reservedate, reserves.branchcode, CONCAT ('',biblio.title,'') AS "Items Display", CONCAT (''"Holds Table"'') AS "Holds Table",  items.barcode, items.itemcallnumber, borrowers.firstname, borrowers.surname FROM borrowers LEFT JOIN reserves USING(borrowernumber) JOIN biblio USING(biblionumber) JOIN items USING(itemnumber) WHERE (TO_DAYS(curdate())-TO_DAYS(reserves.waitingdate)) &gt; '7' AND reserves.branchcode=&lt;&gt; ORDER BY reserves.waitingdate ASC

























