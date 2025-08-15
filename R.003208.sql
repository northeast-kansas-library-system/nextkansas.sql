/*
R.003208

----------

Name: GHW - Policy map report
Created by: George Williams

----------

Group: -
     -

Created on: 2019-05-29 16:21:54
Modified on: 2024-01-17 11:54:13
Date last run: 2024-08-19 10:59:26

----------

Public: 0
Expiry: 300

----------

 
Creates borrower address report for use in Policy Map
Shows current patron addresses
at the library you select
grouped by borrowernumber
sorted by address

Notes:


  Patrons with an un-mappable address (PO Box, no address, no city, no state) will not appear in the results
  Patron data may not map correctly if parts of the address are spelled incorrectly
  YEAR_LASTSEEN is the year from the last_updated field in the borrowers table - this data has only been available since June of 2019, so it will not start being reliable or valuable until June of 2020
  YEAR_LASTSEEN is updated whenever the patron account is used for checking out materials, renewing materials,  or logging into a SIP enabled system (such as Hoopla, PC Reservation, Libki, or Cybrarian - to name a few)
  STATUS = Active means that the patron has checked out or renewed materials within the previous 12 months
  STATUS = Inactive means that the patron has not checked out or renewed any materials in the previous 12 months


Click here to run in a new window


----------
*/



SELECT
  borrowers.borrowernumber,
  Trim(If(Coalesce(borrowers.address, borrowers.address2) LIKE "PO%", borrowers.address2, borrowers.address)) AS address,
  Trim(If(Coalesce(borrowers.address) LIKE "PO%", borrowers.address, borrowers.address2)) AS address2,
  borrowers.city,
  borrowers.state,
  If(Trim(borrowers.zipcode) LIKE "_____-____", Trim(borrowers.zipcode), (If(Trim(borrowers.zipcode) LIKE "_____", Trim(borrowers.zipcode), ""))) AS zipcode,
  Year(borrowers.dateenrolled) AS YEAR_ENROLLED,
  Year(borrowers.dateexpiry) AS YEAR_EXPIRED,
  If(Year(borrowers.lastseen) = 0, "", Year(borrowers.lastseen)) AS YEAR_LASTSEEN,
  borrowers.categorycode,
  Floor((DateDiff(CurDate(), borrowers.dateofbirth) / 365.25)) AS AGE,
  borrowers.branchcode AS HOMEBRANCH,
  If(Floor((DateDiff(CurDate(), borrowers.dateofbirth) / 365.25)) &gt; 17, "Adult", "Minor") AS AGE_GROUP,
  If(usecount.Count_datetime &gt; 0, "Active", "Inactive") AS STATUS
FROM
  borrowers
  LEFT JOIN (
    SELECT
      statistics.borrowernumber,
      Count(statistics.datetime) AS Count_datetime
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      statistics.datetime BETWEEN CurDate() - INTERVAL 1 YEAR AND CurDate() + INTERVAL 1 DAY
    GROUP BY
      statistics.borrowernumber
  ) usecount
    ON usecount.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.categorycode &lt;&gt; 'ILL' AND
  borrowers.categorycode &lt;&gt; 'STAFF' AND
  borrowers.categorycode &lt;&gt; 'INHOUSE' AND
  borrowers.branchcode LIKE &lt;&gt; AND
  If(Trim(If(Coalesce(borrowers.address, borrowers.address2) LIKE "PO%", borrowers.address2, borrowers.address)) = "", "X", (If(borrowers.city = "", "Y", (If(borrowers.state = "", "Z", "A"))))) = 'A'
GROUP BY
  If(Floor((DateDiff(CurDate(), borrowers.dateofbirth) / 365.25)) &gt; 17, "Adult", "Minor"),
  If(usecount.Count_datetime &gt; 0, "Active", "Inactive"),
  borrowers.borrowernumber
ORDER BY
  If(Trim(If(Coalesce(borrowers.address, borrowers.address2) LIKE "PO%", borrowers.address2, borrowers.address)) = "", "X", (If(borrowers.city = "", "Y", (If(borrowers.state = "", "Z", "A"))))),
  borrowers.state,
  borrowers.city,
  address,
  address2,
  zipcode,
  HOMEBRANCH,
  borrowers.categorycode

























