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
Date last run: 2023-05-03 12:34:36

----------

Public: 0
Expiry: 0

----------

#circ

----------
*/



SELECT borrowers.categorycode, COUNT(*) FROM statistics JOIN borrowers USING (borrowernumber) WHERE statistics.type IN ('issue', 'renew') AND datetime >= <<Start Date (example: 2009-01-01) >> AND datetime < <<End Date (example: 2010-01-01 >> AND statistics.branch = <<Pick your branch|branches>>  GROUP BY borrowers.categorycode

























