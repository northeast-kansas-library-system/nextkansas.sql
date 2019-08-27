/*
R.002929

----------

Name: Requests report testing
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2017-04-14 10:06:57
Modified on: 2017-04-14 11:25:19
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  requests.ACTIVE_REQUESTS,
  requests.cardnumber,
  requests.author,
  requests.title,
  requests.itemnumber,
  requests.REQ_PLACED_ON,
  requests.PICK_UP_BRANCH,
  requests.reservenotes,
  requests.found,
  requests.waitingdate,
  requests.expirationdate,
  requests.cancellationdate,
  requests.timestamp,
  requests.reserve_id,
  borrowers.cardnumber AS cardnumber1
FROM
  borrowers
  INNER JOIN (SELECT
      Concat(If(old_reserves.reserve_id > 0, "Inactive", ""), If(old_reserves.cancellationdate > 0, " - cancelled",
      " - filled")) AS ACTIVE_REQUESTS,
      borrowers.cardnumber,
      biblio.author,
      biblio.title,
      old_reserves.itemnumber,
      old_reserves.reservedate AS REQ_PLACED_ON,
      old_reserves.branchcode AS PICK_UP_BRANCH,
      old_reserves.reservenotes,
      old_reserves.found,
      old_reserves.waitingdate,
      old_reserves.expirationdate,
      old_reserves.cancellationdate,
      old_reserves.timestamp,
      old_reserves.reserve_id,
      old_reserves.borrowernumber
    FROM
      old_reserves
      JOIN borrowers ON old_reserves.borrowernumber = borrowers.borrowernumber
      JOIN biblio ON old_reserves.biblionumber = biblio.biblionumber
    UNION
    SELECT
      Concat(If(reserves.reserve_id > 0, "Active", ""), If(reserves.found = "T", " - item in transit", If(reserves.found
      = "W", " - waiting for pickup", ""))) AS ACTIVE_REQUESTS,
      borrowers.cardnumber,
      biblio.author,
      biblio.title,
      reserves.itemnumber,
      reserves.reservedate AS REQ_PLACED_ON,
      reserves.branchcode AS PICK_UP_BRANCH,
      reserves.reservenotes,
      reserves.found,
      reserves.waitingdate,
      reserves.expirationdate,
      reserves.cancellationdate,
      reserves.timestamp,
      reserves.reserve_id,
      reserves.borrowernumber
    FROM
      reserves
      JOIN borrowers ON reserves.borrowernumber = borrowers.borrowernumber
      JOIN biblio ON reserves.biblionumber = biblio.biblionumber
    ORDER BY
      REQ_PLACED_ON DESC) requests ON borrowers.borrowernumber = requests.borrowernumber
WHERE
  requests.ACTIVE_REQUESTS LIKE <<Request status|ZREQTYPE>> AND
  requests.cardnumber LIKE Concat("%",<<Enter patron barcode number>>,"%") AND
  requests.PICK_UP_BRANCH LIKE <<Choose request pick-up branch|LBRANCH>>



