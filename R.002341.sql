/*
R.002341

----------

Name: Holds-Items Added Analysis, 2013-2014
Created by: Heather Braum

----------

Group: Administrative Reports
     Collection Development-admin

Created on: 2014-08-26 07:28:09
Modified on: 2014-08-26 07:30:17
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT p.branchcode, (SELECT count(i.itemnumber) FROM items i WHERE i.homebranch=p.branchcode AND year(i.dateaccessioned) IN ('2013','2014')) as total_added, (SELECT count(*) FROM old_reserves o WHERE o.branchcode=p.branchcode AND year(o.reservedate) IN ('2013','2014')) as old_holds, (SELECT count(*) FROM reserves r WHERE r.branchcode=p.branchcode AND year(r.reservedate) IN ('2013','2014')) as current_holds
FROM borrowers p GROUP by p.branchcode ORDER BY current_holds DESC



