/*
R.002443

----------

Name: Patron Age Breakout by Category Code
Created by: Heather Braum

----------

Group: Borrowers
     Patron Statistics

Created on: 2015-01-13 13:00:27
Modified on: 2015-01-13 13:00:27
Date last run: 2021-01-11 15:27:18

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT TIMESTAMPDIFF(YEAR,dateofbirth,CURDATE()) AS age, categorycode, count(*) FROM borrowers WHERE branchcode=<<choose library|branches>> AND dateexpiry > (DATE(NOW())) GROUP BY age, categorycode



