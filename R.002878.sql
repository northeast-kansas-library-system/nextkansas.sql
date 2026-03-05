/*
R.002878

----------

Name: GHW - lost more than 45 with 0 lost statusses
Created by: George Williams

----------

Group: Administrative Reports
     -

Created on: 2017-01-05 15:16:14
Modified on: 2017-01-05 15:16:14
Date last run: 2021-08-15 21:21:18

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  items.itemnumber,
  items.barcode,
  items.homebranch,
  authorised_values.lib,
  items.itemlost_on,
  items.onloan,
  issues.date_due,
  borrowers.categorycode
FROM
  items LEFT JOIN
  authorised_values
    ON items.itemlost = authorised_values.authorised_value LEFT JOIN
  issues
    ON issues.itemnumber = items.itemnumber INNER JOIN
  borrowers
    ON issues.borrowernumber = borrowers.borrowernumber
WHERE
  (items.itemlost &lt; 1 OR
    items.itemlost IS NULL) AND
  items.onloan &lt; CurDate() - INTERVAL 46 DAY AND
  authorised_values.category = 'LOST' AND
  borrowers.categorycode &lt;&gt; 'ASSOCIATE' AND
  borrowers.categorycode &lt;&gt; 'STUDENT' AND
  borrowers.categorycode &lt;&gt; 'INHOUSE' AND
  borrowers.categorycode &lt;&gt; 'TEACHER' AND
  borrowers.categorycode &lt;&gt; 'ILL' AND
  borrowers.categorycode &lt;&gt; 'STAFF'
GROUP BY
  items.itemnumber, items.barcode, items.homebranch, authorised_values.lib,
  items.itemlost_on, items.onloan, issues.date_due, borrowers.categorycode
ORDER BY
  authorised_values.lib,
  items.homebranch,
  items.itemlost_on


























