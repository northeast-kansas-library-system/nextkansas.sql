/*
R.001308

----------

Name: Count of Patrons by Category
Created by: Heather Braum

----------

Group: Patrons
     Patron Statistics

Created on: 2012-01-31 16:45:04
Modified on: 2017-10-03 14:50:26
Date last run: 2019-10-15 16:37:54

----------

Public: 0
Expiry: 0

----------

Choose your library

----------
*/

SELECT categories.description, COUNT(DISTINCT borrowers.borrowernumber) FROM borrowers LEFT JOIN categories USING (categorycode) where borrowers.branchcode=<<Enter patrons library|branches>> GROUP BY categories.description



