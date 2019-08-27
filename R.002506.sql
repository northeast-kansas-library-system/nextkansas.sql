/*
R.002506

----------

Name: mcnaughton barcodes to recall
Created by: Heather Braum

----------

Group: Administrative Reports
     -

Created on: 2015-05-22 16:46:44
Modified on: 2015-05-22 17:25:57
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/reserve/request.pl?biblionumber=',biblionumber,'\" target="_blank">',barcode,'</a>') as "item", CONCAT("NEKLS EVENTS") as patron, CONCAT ("Please send this book back to NEKLS; if you have already sent it back to NEKLS, let this hold stay on your holds queue until it arrives here and is checked in. Thanks! -HB") as comment, barcode FROM items WHERE barcode IN ('1114008000066','1114008000070','1114008000105','1114008000137','1114008000154','1114008000167','1114008000194','1114008000256','1114008000299','1114008000302','1114008000305','1114008000320','1114008000357','1114008000367','1114008000369','1114008000378','1114008000396','1114008000401','1114008000439','1114008000479','1114008000495','1114008000506','1114008000514','1114008000517','1114008000554','1114008000582','1114008000657','1114008000723','1114008000748','1114008000789','1114008000792','1114008000826','1114008000647') AND itemnumber NOT IN (SELECT itemnumber FROM reserves WHERE reservenotes='Please send this book back to NEKLS; if you have already sent it back to NEKLS, let this hold stay on your holds queue until it arrives here and is checked in. Thanks! -HB')



