/*
R.003833

----------

Name: sandbox 54
Created by: George Williams

----------

Group: -
     -

Created on: 2024-05-29 16:18:48
Modified on: 2024-05-29 17:09:13
Date last run: 2024-06-05 15:17:36

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat(Year(borrowers.updated_on), '-', LPad(Month(borrowers.updated_on), 2, 0)) AS DATE,
  Count(borrowers.cardnumber) AS CURRENT_FAILED_ATTEMPTS
FROM
  borrowers
WHERE
  borrowers.login_attempts &gt; 0 AND
  borrowers.updated_on &gt; Last_Day(CURRENT_DATE()) - INTERVAL 14 MONTH AND
  borrowers.branchcode = &lt;&gt;
GROUP BY
  Concat(Year(borrowers.updated_on), '-', LPad(Month(borrowers.updated_on), 2, 0))
ORDER BY
  DATE

























