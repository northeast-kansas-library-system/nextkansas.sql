/*
R.003039

----------

Name: GHW - Flexible requests history report
Created by: George Williams

----------

Group: Holds-Reserves
     -

Created on: 2018-01-16 15:28:12
Modified on: 2025-03-04 13:52:23
Date last run: 2025-08-12 15:00:35

----------

Public: 0
Expiry: 300

----------

 
Generates a screen readable report of current and past request information based on very flexible parameters
Shows the history of any active, filled, and cancelled requests in NExpress
at all pickup libraries or at the pickup library you specify
with the request status and progress that you specify
with the hold suspension status you specify
and with the library card, biblionumber, or item barcode number you specify
grouped by reserve ID number
sorted by the last time the request was updated
contains links to the action logs, the patron record, the bibliographic record, and the item's in transit history

Notes:

Contains active links to reports 2784 and 3040

Click here to run in a new window


----------
*/



SELECT
  requests.reserve_id,
  Concat("Status: ", requests.statuss, " Progress: ", If(requests.cancellationdate IS NOT NULL, "Cancelled", If(requests.found = "T", "In transit", If(requests.found = "F", "Filled / finished", If(requests.found = "W", "Waiting for pickup", "Still active"))))) AS STATUS,
  Concat("Patron BC: ", borrowers.cardnumber, "", "Pickup at: ", requests.branchcode) AS PATRON_INFO,
  Concat_Ws("",
    Concat("Requested on: ", requests.reservedate), Concat("Waiting since: ", requests.waitingdate),
    Concat("Expires on: ", requests.expirationdate), Concat("Cancelled on: ", requests.cancellationdate),
    Concat("Updated on: ", requests.timestamp)) AS DATES,
  Concat_Ws("", If(requests.suspend &lt;&gt; 0, "Suspended", "-"), If(requests.suspend = 0, "-", If(requests.suspend_until IS NOT NULL, Concat("until ", Date_Format(requests.suspend_until, "%Y.%m.%d")), "indefinitely"))) AS SUSPENDED,
  requests.biblionumber AS BIBLIO_NUMBER,
  Concat_Ws("",
    Concat("BC: ", Coalesce(Coalesce(items.barcode, "-"), Coalesce(deleteditems.barcode, "-"))),
    Concat("Home: ", Coalesce(Coalesce(items.homebranch, "-"), Coalesce(deleteditems.homebranch, "-"))),
    Concat("Location: ", Coalesce(Coalesce(items.location, "-"), Coalesce(deleteditems.location, "-"))),
    Concat("Type: ", Coalesce(Coalesce(items.itype, "-"), Coalesce(deleteditems.itype, "-"))),
    Concat("Collection: ", Coalesce(Coalesce(items.ccode, "-"), Coalesce(deleteditems.ccode, "-"))),
    Concat("Call#: ", Coalesce(Coalesce(items.itemcallnumber, "-"), Coalesce(deleteditems.itemcallnumber, "-"))),
    Concat("Author: ", Coalesce(Coalesce(biblio.author, "-"), Coalesce(deletedbiblio.author, "-"))),
    Concat("Title: ", Coalesce(Coalesce(biblio.title, "-"), Coalesce(deletedbiblio.title, "-")))) AS ITEM_INFO,
  CONCAT_WS("",
    Concat(
      "Action logs: ", 
      Concat("see last 60 days of activity"
      )
    ),
    Concat(
      "Link to patron: ", 
      Concat("go to the borrower's record"
      )
    ),
    Concat(
      "Link to title: ", 
      Concat("go to the bibliographic record"
      )
    ),
    Concat(
      "Link to item: ", 
      Concat("go to the item record"
      )
    ),
    Concat(
      "Item in transit history: ", 
      Concat("see item transit history"
      )
    )
) AS LINKS
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
  requests.branchcode LIKE &lt;&gt; AND
  requests.statuss LIKE &lt;&gt; AND
  If(requests.cancellationdate IS NOT NULL, "Cancelled", If(requests.found = "T", "In transit", If(requests.found = "F", "Filled", If(requests.found = "W", "Waiting for pickup", "Still active")))) LIKE &lt;&gt; AND
  If(requests.suspend &lt;&gt; 0, "Suspended", "-") LIKE &lt;&gt; AND
  borrowers.cardnumber LIKE Concat("%", &lt;&gt;, "%") AND
  requests.biblionumber LIKE Concat("%", &lt;&gt;, "%") AND
  Coalesce(Coalesce(items.barcode, "-"), Coalesce(deleteditems.barcode, "-")) LIKE Concat("%", &lt;&gt;, "%")
GROUP BY
  requests.reserve_id
ORDER BY
  requests.timestamp DESC

























