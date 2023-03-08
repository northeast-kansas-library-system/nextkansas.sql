/*
R.002702

----------

Name: Ottawa Patron count
Created by: Heather Braum

----------

Group:  OTTAWA
     -

Created on: 2016-06-29 09:13:45
Modified on: 2021-08-16 13:43:57
Date last run: 2023-01-26 12:27:37

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT b.categorycode, (SELECT ba.attribute FROM borrower_attributes ba WHERE ba.borrowernumber=b.borrowernumber AND ba.code='Location') as location, count(DISTINCT borrowernumber) FROM borrowers b WHERE b.branchcode='OTTAWA' GROUP BY b.categorycode, location

























