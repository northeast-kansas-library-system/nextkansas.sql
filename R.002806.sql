/*
R.002806

----------

Name: GHW - Test - Circs - excludes INHOUSE
Created by: George H Williams

----------

Group: -
     -

Created on: 2016-10-13 16:32:19
Modified on: 2018-12-09 21:30:04
Date last run: 2019-10-22 15:11:27

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  If(items.itype IS NULL AND deleteditems.itype IS NULL, NULL, Concat(Coalesce(items.itype, ''), Coalesce(deleteditems.itype, ''))) AS ITEM_TYPE,
  authorised_values.lib,
  If(items.location IS NULL AND deleteditems.location IS NULL, NULL, Concat(Coalesce(items.location, ''), Coalesce(deleteditems.location, ''))) AS SHELVING_LOCATION,
  Count(*) AS count
FROM
  statistics LEFT JOIN
  items
    ON statistics.itemnumber = items.itemnumber LEFT JOIN
  deleteditems
    ON statistics.itemnumber = deleteditems.itemnumber LEFT JOIN
  borrowers
    ON statistics.borrowernumber = borrowers.borrowernumber LEFT JOIN
  deletedborrowers
    ON statistics.associatedborrower = deletedborrowers.borrowernumber LEFT JOIN
  authorised_values
    ON statistics.ccode = authorised_values.authorised_value
WHERE
  (statistics.branch LIKE @brn:=<<Enter your branch|LBRANCH>> COLLATE utf8mb4_unicode_ci) AND
  statistics.type IN ('issue', 'renew', 'localuse') AND
  (statistics.datetime BETWEEN (<<Between start date|date>>)  AND (<<and end date|date>>+ INTERVAL 1 DAY))
AND
  (items.homebranch LIKE @brn OR deleteditems.homebranch LIKE @brn) AND
  authorised_values.category = "CCODE" AND
  (If(statistics.borrowernumber IS NULL AND deletedborrowers.categorycode IS NULL, NULL, Concat(Coalesce(deletedborrowers.categorycode, ''), Coalesce(borrowers.categorycode, ''))) <> "INHOUSE")
GROUP BY
  ITEM_TYPE, authorised_values.lib, SHELVING_LOCATION



