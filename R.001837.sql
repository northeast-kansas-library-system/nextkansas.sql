/*
R.001837

----------

Name: Current Holds for a Specific Patron
Created by: Heather Braum

----------

Group: Holds-Reserves
     -

Created on: 2013-05-14 10:42:28
Modified on: 2013-06-16 16:33:16
Date last run: -

----------

Public: 0
Expiry: 0

----------

Enter borrowernumber (database number for a patron)

----------
*/

SELECT * from reserves WHERE borrowernumber=<<enter borrowernumber>> GROUP by reserve_id LIMIT 500



