/*
R.003955

----------

Name: holds-test
Created by: Nikki Hansen

----------

Group: -
     -

Created on: 2026-04-09 12:41:21
Modified on: 2026-04-09 13:10:26
Date last run: 2026-04-10 11:02:45

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  requests.reserve_id,
  requests.statuss AS STATUS,
  If(requests.cancellationdate IS NOT NULL, "Cancelled", If(requests.found = "T", "In transit", If(requests.found = "F", "Filled / finished", If(requests.found = "W", "Waiting for pickup", "Still active")))) AS PROGRESS,
  borrowers.cardnumber AS CARDNUMBER,
  requests.branchcode AS PICKUP_BRANCH,
  requests.reservedate,
  requests.expirationdate,
  requests.cancellationdate,
  requests.timestamp,
  requests.suspend,
  requests.suspend_until,
  requests.biblionumber,
  Coalesce(items.barcode, deleteditems.barcode) AS ITEM_BC,
  Coalesce(items.homebranch, deleteditems.homebranch) AS ITEM_HOME,
  Coalesce(items.location, deleteditems.location) AS LOCATION,
  Coalesce(items.itype, deleteditems.itype) AS ITYPE,
  Coalesce(items.ccode, deleteditems.ccode) AS CCODE,
  Coalesce(items.itemcallnumber, deleteditems.itemcallnumber) AS CALL_NO,
  Coalesce(biblio.author, deletedbiblio.author) AS AUTHOR,
  Coalesce(biblio.title, deletedbiblio.title) AS TITLE
FROM
  borrowers
  JOIN (SELECT
        reserves.reserve_id,
        reserves.borrowernumber,
        reserves.reservedate,
        reserves.biblionumber,
        reserves.branchcode,
        reserves.notificationdate,
        reserves.reminderdate,
        reserves.cancellationdate,
        reserves.reservenotes,
        reserves.priority,
        reserves.found,
        reserves.timestamp,
        reserves.itemnumber,
        reserves.waitingdate,
        reserves.expirationdate,
        reserves.lowestPriority,
        reserves.suspend,
        reserves.suspend_until,
        reserves.itemtype,
        If(reserves.reserve_id IS NOT NULL, "Active", "-") AS statuss
      FROM
        reserves
      UNION
      SELECT
        old_reserves.reserve_id,
        old_reserves.borrowernumber,
        old_reserves.reservedate,
        old_reserves.biblionumber,
        old_reserves.branchcode,
        old_reserves.notificationdate,
        old_reserves.reminderdate,
        old_reserves.cancellationdate,
        old_reserves.reservenotes,
        old_reserves.priority,
        old_reserves.found,
        old_reserves.timestamp,
        old_reserves.itemnumber,
        old_reserves.waitingdate,
        old_reserves.expirationdate,
        old_reserves.lowestPriority,
        old_reserves.suspend,
        old_reserves.suspend_until,
        old_reserves.itemtype,
        If(old_reserves.cancellationdate IS NOT NULL, "Cancelled", "Filled") AS statuss
      FROM
        old_reserves) requests ON borrowers.borrowernumber = requests.borrowernumber
  LEFT JOIN items ON requests.itemnumber = items.itemnumber
  LEFT JOIN deleteditems ON requests.itemnumber = deleteditems.itemnumber
  LEFT JOIN biblio ON requests.biblionumber = biblio.biblionumber
  LEFT JOIN deletedbiblio ON requests.biblionumber = deletedbiblio.biblionumber
WHERE
  DATE (requests.timestamp) BETWEEN <<Start Date>> AND <<End Date>> AND
  requests.branchcode LIKE <<Choose pickup library|LBRANCH>> AND
  requests.statuss LIKE <<Choose request status|LHOLDACT>> AND
  If(requests.cancellationdate IS NOT NULL, "Cancelled", If(requests.found = "T", "In transit", If(requests.found = "F", "Filled", If(requests.found = "W", "Waiting for pickup", "Still active")))) LIKE <<Choose request progress|LHOLDPROG>> AND
  If(requests.suspend <> 0, "Suspended", "-") LIKE <<Choose suspended status|LHOLDSUS>> AND
  borrowers.cardnumber LIKE Concat("%", <<Enter borrower barcode number or a % symbol>>, "%") AND
  requests.biblionumber LIKE Concat("%", <<Enter title biblio number or a % symbol>>, "%") AND
  Coalesce(Coalesce(items.barcode, "-"), Coalesce(deleteditems.barcode, "-")) LIKE Concat("%", <<Enter item barcode number or a % symbol>>, "%")
GROUP BY
  requests.reserve_id
ORDER BY
  requests.timestamp DESC

























