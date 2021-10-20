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
Date last run: 2021-10-15 12:18:10

----------

Public: 0
Expiry: 0

----------

Limited by Branch. Lists all items WAITING for more than 7 days

----------
*/



SELECT reserves.waitingdate, reserves.reservedate, reserves.branchcode, CONCAT ('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblio.biblionumber,'\" target="_blank">',biblio.title,'</a>') AS "Items Display", CONCAT ('<a href=\"/cgi-bin/koha/reserve/request.pl?biblionumber=',biblio.biblionumber,'\" target="_blank">'"Holds Table"'</a>') AS "Holds Table",  items.barcode, items.itemcallnumber, borrowers.firstname, borrowers.surname FROM borrowers LEFT JOIN reserves USING(borrowernumber) JOIN biblio USING(biblionumber) JOIN items USING(itemnumber) WHERE (TO_DAYS(curdate())-TO_DAYS(reserves.waitingdate)) > '7' AND reserves.branchcode=<<branch|branches>> ORDER BY reserves.waitingdate ASC

























