/*
R.001897

----------

Name: List of Patron Category Names
Created by: Heather Braum

----------

Group: Administrative Reports
     System-admin

Created on: 2013-06-07 11:43:46
Modified on: 2019-07-20 19:38:45
Date last run: 2021-08-23 12:41:18

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  categorycode,
  description
FROM categories
GROUP BY
  categorycode
LIMIT 300



