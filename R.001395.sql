/*
R.001395

----------

Name: Circ by Patron Category
Created by: -

----------

Group: Circulation
     Circ Stats

Created on: 2012-05-14 14:25:25
Modified on: 2013-09-21 16:27:44
Date last run: 2025-04-21 08:43:47

----------

Public: 0
Expiry: 0

----------

#circ

----------
*/



SELECT borrowers.categorycode, COUNT(*) FROM statistics JOIN borrowers USING (borrowernumber) WHERE statistics.type IN ('issue', 'renew') AND datetime >= <> AND datetime < <> AND statistics.branch = <>  GROUP BY borrowers.categorycode

























