/*
R.001781

----------

Name: Top 10 publishers in NExpress
Created by: Heather Braum

----------

Group: Administrative Reports
     Catalog-admin

Created on: 2013-03-30 16:21:34
Modified on: 2018-09-20 13:56:18
Date last run: 2018-09-20 13:56:20

----------

Public: 0
Expiry: 0

----------

HB_Monthly

----------
*/

SELECT publishercode, count(biblionumber) As Records FROM biblioitems WHERe publishercode IS NOT NULL GROUP BY publishercode ORDER BY Records DESC LIMIT 10 



