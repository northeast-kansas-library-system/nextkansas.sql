/*
R.003270

----------

Name: trial
Created by: LEAVENWRTH TECH

----------

Group: -
     -

Created on: 2019-09-27 13:41:14
Modified on: 2019-09-30 16:01:46
Date last run: 2019-09-30 11:05:33

----------

Public: 0
Expiry: 300

----------

This report will almost certainly not do what you're expecting it to do and it may either fail or cause the system to overload.  Please send an e-mail to nexthelp@nekls.org for help with creating reports.  GHW

----------
*/

SELECT  items.barcode,items.datelastborrowed,items.dateaccessioned,items.itemcallnumber,items.issues FROM borrowers LEFT JOIN statistics on (statistics.borrowernumber=borrowers.borrowernumber) LEFT JOIN items on (items.itemnumber = statistics.itemnumber) LEFT JOIN biblioitems on (biblioitems.biblioitemnumber = items.biblioitemnumber) 



