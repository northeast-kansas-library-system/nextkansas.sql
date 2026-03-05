/*
R.003928

----------

Name: List test
Created by: George Williams

----------

Group: -
     -

Created on: 2025-11-13 14:47:22
Modified on: 2025-11-13 14:49:57
Date last run: 2025-11-13 14:52:29

----------

Public: 0
Expiry: 300

----------

SELECT
  items.biblionumber,
  items.barcode
FROM
  items
WHERE
  items.barcode = ''

----------
*/



SELECT
  items.biblionumber,
  items.barcode
FROM
  items
WHERE
  items.barcode IN &lt;&gt; 

























