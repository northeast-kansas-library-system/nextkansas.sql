/*
R.002257

----------

Name: Patrons Total Current Holds (limited by library)
Created by: Heather Braum

----------

Group: Holds-Reserves
     -

Created on: 2014-05-12 13:27:07
Modified on: 2014-12-01 13:58:11
Date last run: 2020-11-05 09:55:01

----------

Public: 0
Expiry: 0

----------

Shows patrons at your library with their total CURRENT holds. Only displays card number and holds count. Patrons with the most holds are at the top of the list.

----------
*/

SELECT b.cardnumber, count(r.reserve_id) as count FROM reserves r JOIN borrowers b USING(borrowernumber) WHERE b.branchcode = <<choose your branch|branches>> GROUP BY b.borrowernumber ORDER BY count DESC



