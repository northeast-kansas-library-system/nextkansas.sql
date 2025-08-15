/*
R.003811

----------

Name: GHW - Adjacent barcode numbers search
Created by: George Williams

----------

Group: -
     -

Created on: 2024-03-16 00:19:05
Modified on: 2024-03-16 00:46:56
Date last run: 2024-11-07 11:31:19

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  ' You searched for' AS SEARCH_BARCODE,
  &lt;&gt; AS ADJACENT_BARCODES,
  '' AS OWNED_BY
UNION
SELECT
  '--' AS SEARCH_BARCODE,
  items.barcode AS ADJACENT_BARCODES,
  branches.branchname AS OWNED_BY
FROM
  items JOIN
  branches ON items.homebranch = branches.branchcode
WHERE
  items.barcode LIKE Concat((Left(Trim(&lt;&gt;), Length(Trim(&lt;&gt;)) - 1)), '%')
ORDER BY
  SEARCH_BARCODE
LIMIT 250

























