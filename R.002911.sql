/*
R.002911

----------

Name: GHW - Items Waiting Pickup
Created by: George H Williams

----------

Group: Holds-Reserves
     -

Created on: 2017-02-23 11:17:34
Modified on: 2018-04-16 11:08:13
Date last run: 2021-10-19 14:45:25

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Generates a list of items awaiting pickup</p>
<ul><li>Shows items currently on the hold shelf</li>
<li>at the pick-up location you specify</li>
<li>sorted by date the item was placed on your hold shelf</li>
<li>contains links to the requesting patron's account</li>
</ul><br />
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2911&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  reserves.branchcode AS PICKUP_LOCATION,
  reserves.waitingdate AS WAITING_SINCE,
  Concat_Ws("<br />", Concat("Title: ", biblio.title), Concat("Author: ", If(biblio.author = "", "-", biblio.author)), Concat_Ws(" | ", "Call#: ", items.location, items.itype, items.ccode, items.itemcallnumber, items.enumchron, items.copynumber), Concat("Barcode: ", UPPER(items.barcode))) AS
  ITEM_DETAILS,
  Concat_Ws("<br />", Concat(borrowers.surname, ", ", borrowers.firstname), borrowers.cardnumber, borrowers.phone, If(borrowers.email = "", "-", borrowers.email), Concat("<br />", If(contact.attribute IS NULL, "<span style='color:red; font-weight: bold;'>NO CONTACT METHOD SPECIFIED</span>", If(contact.attribute = "Phone", Concat("<span style='color:red; font-weight: bold;'>Please Phone</span>"), If(contact.attribute = "Email", Concat("<span style='color:green; font-weight: bold;'>Patron prefers e-mail</span>"), If(contact.attribute = "Text", Concat("<span style='color:red; font-weight: bold;'>Please Text</span>"), Concat("<span style='color:red; font-weight: bold;'>Prefered contact method: ", "</span>"))))))) AS PATRON_DETAILS,
  Concat('<a href=\"/cgi-bin/koha/circ/circulation.pl?borrowernumber=', borrowers.borrowernumber, '\" target="_blank">Open patron account in new window</a>') AS LINK_TO_PATRON
FROM
  reserves JOIN
  items
    ON reserves.itemnumber = items.itemnumber JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber JOIN
  borrowers
    ON reserves.borrowernumber = borrowers.borrowernumber LEFT JOIN
  (SELECT
    borrower_attributes.borrowernumber,
    borrower_attributes.code,
    borrower_attributes.attribute
  FROM
    borrower_attributes
  WHERE
    borrower_attributes.code = 'HOLD') contact
    ON borrowers.borrowernumber = contact.borrowernumber
WHERE
  reserves.branchcode LIKE <<Choose branch|LBRANCH>> AND
  reserves.found = 'W'
ORDER BY
  WAITING_SINCE DESC

























