/*
R.003039

----------

Name: GHW - Flexible requests history report
Created by: George H Williams

----------

Group: Holds-Reserves
     -

Created on: 2018-01-16 15:28:12
Modified on: 2018-04-16 11:13:46
Date last run: 2021-02-01 12:48:09

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Generates a screen readable report of current and past request information based on very flexible parameters</p>
<ul><li>Shows the history of any active, filled, and cancelled requests in NExpress</li>
<li>at all pickup libraries or at the pickup library you specify</li>
<li>with the request status and progress that you specify</li>
<li>with the hold suspension status you specify</li>
<li>and with the library card, biblionumber, or item barcode number you specify</li>
<li>grouped by reserve ID number</li>
<li>sorted by the last time the request was updated</li>
<li>contains links to the action logs, the patron record, the bibliographic record, and the item's in transit history</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Contains active links to reports 2784 and 3040</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3039&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  requests.reserve_id,
  Concat("Status: ", requests.statuss, "<br /> Progress: ", If(requests.cancellationdate IS NOT NULL, "Cancelled", If(requests.found = "T", "In transit", If(requests.found = "F", "Filled / finished", If(requests.found = "W", "Waiting for pickup", "Still active"))))) AS STATUS,
  Concat("Patron BC: ", borrowers.cardnumber, "<br />", "Pickup at: ", requests.branchcode) AS PATRON_INFO,
  Concat_Ws("<br />",
    Concat("Requested on: ", requests.reservedate), Concat("Waiting since: ", requests.waitingdate),
    Concat("Expires on: ", requests.expirationdate), Concat("Cancelled on: ", requests.cancellationdate),
    Concat("Updated on: ", requests.timestamp)) AS DATES,
  Concat_Ws("<br />", If(requests.suspend <> 0, "Suspended", "-"), If(requests.suspend = 0, "-", If(requests.suspend_until IS NOT NULL, Concat("until ", Date_Format(requests.suspend_until, "%Y.%m.%d")), "indefinitely"))) AS SUSPENDED,
  requests.biblionumber AS BIBLIO_NUMBER,
  Concat_Ws("<br />",
    Concat("BC: ", Coalesce(Coalesce(items.barcode, "-"), Coalesce(deleteditems.barcode, "-"))),
    Concat("Home: ", Coalesce(Coalesce(items.homebranch, "-"), Coalesce(deleteditems.homebranch, "-"))),
    Concat("Location: ", Coalesce(Coalesce(items.location, "-"), Coalesce(deleteditems.location, "-"))),
    Concat("Type: ", Coalesce(Coalesce(items.itype, "-"), Coalesce(deleteditems.itype, "-"))),
    Concat("Collection: ", Coalesce(Coalesce(items.ccode, "-"), Coalesce(deleteditems.ccode, "-"))),
    Concat("Call#: ", Coalesce(Coalesce(items.itemcallnumber, "-"), Coalesce(deleteditems.itemcallnumber, "-"))),
    Concat("Author: ", Coalesce(Coalesce(biblio.author, "-"), Coalesce(deletedbiblio.author, "-"))),
    Concat("Title: ", Coalesce(Coalesce(biblio.title, "-"), Coalesce(deletedbiblio.title, "-")))) AS ITEM_INFO,
  CONCAT_WS("<br />",
    Concat("Action logs: ", Concat("<a href='/cgi-bin/koha/reports/guided_reports.pl?reports=3040&phase=Run+this+report&sql_params=", requests.reserve_id,"' target='_blank'>see last 60 days of activity</a>")),
    Concat("Link to patron: ", Concat("<a href='/cgi-bin/koha/circ/circulation.pl?borrowernumber=", requests.borrowernumber,"' target='_blank'>go to the borrower's record</a>")),
    Concat("Link to title: ", Concat("<a href='/cgi-bin/koha/catalogue/detail.pl?biblionumber=", requests.biblionumber,"' target='_blank'>go to the bibliographic record</a>")),
    Concat("Link to item: ", Concat("<a href='/cgi-bin/koha/catalogue/moredetail.pl?itemnumber=", items.itemnumber, "&biblionumber=", biblio.biblionumber, "' target='_blank'>go to the item record</a>")),
    Concat("Item in transit history: ", Concat("<a href='/cgi-bin/koha/reports/guided_reports.pl?reports=2784&phase=Run+this+report&sql_params=", items.barcode,"' target='_blank'>see item transit history</a>"))
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
  requests.branchcode LIKE <<Choose pickup library|LBRANCH>> AND
  requests.statuss LIKE <<Choose request status|LHOLDACT>> AND
  If(requests.cancellationdate IS NOT NULL, "Cancelled", If(requests.found = "T", "In transit", If(requests.found = "F", "Filled", If(requests.found = "W", "Waiting for pickup", "Still active")))) LIKE <<Choose request progress|LHOLDPROG>> AND
  If(requests.suspend <> 0, "Suspended", "-") LIKE <<Choose suspended status|LHOLDSUS>> AND
  borrowers.cardnumber LIKE Concat("%", <<Enter library card number or a % symbol>>, "%") AND
  requests.biblionumber LIKE Concat("%", <<Enter title biblio number or a % symbol>>, "%") AND
  Coalesce(Coalesce(items.barcode, "-"), Coalesce(deleteditems.barcode, "-")) LIKE Concat("%", <<Enter item barcode number or a % symbol>>, "%")
GROUP BY
  requests.reserve_id
ORDER BY
  requests.timestamp DESC



