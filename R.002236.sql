/*
R.002236

----------

Name: Not sure?
Created by: Heather Braum

----------

Group: -
     -

Created on: 2014-04-02 12:53:07
Modified on: 2014-08-09 00:29:04
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT * FROM accountlines WHERE amountoutstanding = '10.00' AND description NOT LIKE '%LOST%' AND description NOT LIKE '%OVERDUE%'



