/*
R.002655

----------

Name: Libraries and Koha Email address
Created by: Heather Braum

----------

Group: Circulation
     -

Created on: 2016-01-15 16:52:26
Modified on: 2016-01-15 16:53:53
Date last run: 2018-04-19 21:19:21

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT branchname, branchemail FROM branches where branchcode NOT IN ('NEKLS','LOUISBURG','PAOLA','DIGITAL') LIMIT 60



