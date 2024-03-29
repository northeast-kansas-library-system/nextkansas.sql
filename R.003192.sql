/*
R.003192

----------

Name: GHW - Patrons with more than 20 unfilled requests
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-03-31 16:43:47
Modified on: 2022-11-07 15:50:45
Date last run: 2022-11-08 14:28:14

----------

Public: 0
Expiry: 300

----------

Borrowernumber is marked as "confidential."

Total unfilled requests and total borrowers with requests are included to expedite the creation of the percent value.

----------
*/



SELECT
  Concat("confidential") AS PATRON,
  Count(reserves.reserve_id) AS ACTIVE_UNFILLED_THIS_PATRON,
  Concat(Format(((Count(reserves.reserve_id) / unfilledholds.Count_reserve_id) * 100), 5), "%") AS SYSTEM_WIDE_PERCENTAGE,
  unfilledholds.Count_reserve_id AS ACTIVE_UNFILLED_TOTAL,
  borrowerswrequests.Count_borrowernumber AS TOTAL_BORROWERS_WITH_REQUESTS
FROM
  reserves
  JOIN borrowers
    ON reserves.borrowernumber = borrowers.borrowernumber,
  (
    SELECT
      Count(DISTINCT reserves.reserve_id) AS Count_reserve_id
    FROM
      reserves
      JOIN borrowers
        ON reserves.borrowernumber = borrowers.borrowernumber
    WHERE
      borrowers.categorycode <> "ILL" AND
      borrowers.categorycode <> "ASSOCIATE" AND
      borrowers.categorycode <> "STAFF" AND
      reserves.found IS NULL AND
      reserves.suspend = 0
    ORDER BY
      Count_reserve_id DESC
  ) unfilledholds,
  (
    SELECT
      Count(DISTINCT reserves.borrowernumber) AS Count_borrowernumber
    FROM
      reserves
      JOIN borrowers
        ON reserves.borrowernumber = borrowers.borrowernumber
    WHERE
      borrowers.categorycode <> "ILL" AND
      borrowers.categorycode <> "ASSOCIATE" AND
      borrowers.categorycode <> "STAFF" AND
      reserves.found IS NULL AND
      reserves.suspend = 0
  ) borrowerswrequests
WHERE
  borrowers.categorycode <> "ILL" AND
  borrowers.categorycode <> "ASSOCIATE" AND
  borrowers.categorycode <> "STAFF" AND
  reserves.found IS NULL AND
  reserves.suspend = 0
GROUP BY
  reserves.borrowernumber,
  borrowerswrequests.Count_borrowernumber
HAVING
  Count(reserves.reserve_id) > 20
ORDER BY
  ACTIVE_UNFILLED_THIS_PATRON DESC

























