/*
R.002519

----------

Name: Overdue items on Transfers to receive report
Created by: Heather Braum

----------

Group: -
     -

Created on: 2015-06-03 16:10:57
Modified on: 2016-05-11 15:27:34
Date last run: 2020-02-20 17:03:21

----------

Public: 0
Expiry: 0

----------

Choose your library twice

----------
*/

SELECT CONCAT ('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',b.biblionumber,'\" target="_blank">'"link to record"'</a>') as "link to record", date_format(bt.datesent, '%Y-%m-%d') as "date of transfer", DATEDIFF(CURDATE(), bt.datesent) as "days overdue", bt.frombranch as sending_library, bt.tobranch as receiving_library,b.title, i.itype, i.ccode, i.itemcallnumber,i.barcode, i.homebranch FROM branchtransfers bt LEFT JOIN items i using(itemnumber) LEFT JOIN biblio b USING(biblionumber) WHERE bt.datearrived IS NULL and  DATEDIFF(NOW(), bt.datesent) > 6 AND (bt.frombranch = <<choose your library|branches>> OR bt.tobranch = <<choose your library|branches>>) AND i.itemlost = '0' ORDER BY sending_library, receiving_library



