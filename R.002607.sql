/*
R.002607

----------

Name: checking lansing transfers
Created by: Heather Braum

----------

Group: -
     -

Created on: 2015-09-18 18:02:21
Modified on: 2015-09-18 18:06:01
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblionumber,'\" target="_blank">',biblionumber,'</a>') as record FROM items WHERE homebranch = 'LANSING' AND holdingbranch='NEKLS'



