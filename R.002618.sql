/*
R.002618

----------

Name: Nonstandard state errors
Created by: Heather Braum

----------

Group: Administrative Reports
     Patrons-admin

Created on: 2015-10-13 10:13:08
Modified on: 2015-10-13 10:46:57
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/members/memberentry.pl?op=modify&borrowernumber=',borrowers.borrowernumber,'\" target="_blank">'"edit patron"'</a>') as "edit patron" FROM borrowers where state is not null and state <> '' and state NOT IN ('AK','AL','AR','AZ','CA','CO','CT','DE','FL','GA','HI','IL','WI','IA','ID','IN','KS','KY','UK','LA','MA','MT','MD','ME','MI','MN','MO','MS','NC','ND','NE','NJ','NM','NV','NY','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VA','WA','WV','WY')



