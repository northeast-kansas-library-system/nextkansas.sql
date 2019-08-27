/*
R.002370

----------

Name: Checking for double quotes in Lansing itemnotes records
Created by: Heather Braum

----------

Group: Administrative Reports
     Post-Lansing

Created on: 2014-09-10 00:10:23
Modified on: 2014-09-10 00:11:47
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT  CONCAT ('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblionumber,'\" target="_blank">'"link to record"'</a>') as "link to record" FROM items where homebranch='lansing' AND itemnotes LIKE '%"%' GROUP BY biblionumber



