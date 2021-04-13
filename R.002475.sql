/*
R.002475

----------

Name: Reserves Lost in Transit
Created by: Heather Braum

----------

Group: -
     -

Created on: 2015-03-25 15:37:42
Modified on: 2015-04-07 15:12:10
Date last run: 2020-10-19 13:21:16

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT r.reserve_id, p.firstname, p.surname, p.cardnumber, b.title, i.ccode, t.isbn, r.branchcode, r.reservedate, CONCAT('<a href="/cgi-bin/koha/reserve/request.pl?biblionumber=',r.biblionumber,'" target="_blank">',r.biblionumber,'</a>') as hold, (SELECT count(r2.reserve_id) FROM reserves r2 WHERE r2.biblionumber=r.biblionumber GROUP BY r2.biblionumber) AS totalholds, (SELECT count(i.itemnumber) FROM items i WHERE r.biblionumber=i.biblionumber AND i.itype NOT IN ('WALKIN','WALKIN1','WALKIN2','LOCALHOLD','LOCALHOLD1','LOCALHOLD2')
AND i.notforloan = '0' AND i.damaged = '0' AND i.itemlost = '0' AND i.withdrawn = '0') as totalitems FROM biblioitems t LEFT JOIN biblio b USING(biblionumber) LEFT JOIN items i USING(biblionumber) LEFT JOIN reserves r USING(itemnumber) LEFT JOIN borrowers p USING(borrowernumber) WHERE itemnumber IN (select itemnumber from branchtransfers bt join items i USING(itemnumber) where bt.datearrived is NULL AND bt.datesent between '2015-03-11 00:00:00' AND '2015-03-20 23:59:59') AND priority='0' ORDER BY r.branchcode, totalholds asc, totalitems desc



