/*
R.002911

----------

Name: GHW - Items Waiting Pickup
Created by: George Williams

----------

Group: Holds-Reserves
     -

Created on: 2017-02-23 11:17:34
Modified on: 2024-01-17 11:49:09
Date last run: 2024-05-30 15:48:49

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Generates a list of items awaiting pickup&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows items currently on the hold shelf&lt;/li&gt;
&lt;li&gt;at the pick-up location you specify&lt;/li&gt;
&lt;li&gt;sorted by date the item was placed on your hold shelf&lt;/li&gt;
&lt;li&gt;contains links to the requesting patron's account&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2911&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  reserves.branchcode AS PICKUP_LOCATION,
  reserves.waitingdate AS WAITING_SINCE,
  Concat_Ws("", Concat("Title: ", biblio.title), Concat("Author: ", If(biblio.author = "", "-", biblio.author)), Concat_Ws(" | ", "Call#: ", items.location, items.itype, items.ccode, items.itemcallnumber, items.enumchron, items.copynumber), Concat("Barcode: ", UPPER(items.barcode))) AS
  ITEM_DETAILS,
  Concat_Ws("", Concat(borrowers.surname, ", ", borrowers.firstname), borrowers.cardnumber, borrowers.phone, If(borrowers.email = "", "-", borrowers.email), Concat("", If(contact.attribute IS NULL, "NO CONTACT METHOD SPECIFIED", If(contact.attribute = "Phone", Concat("Please Phone"), If(contact.attribute = "Email", Concat("Patron prefers e-mail"), If(contact.attribute = "Text", Concat("Please Text"), Concat("Prefered contact method: ", ""))))))) AS PATRON_DETAILS,
  Concat('Open patron account in new window') AS LINK_TO_PATRON
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
  reserves.branchcode LIKE &lt;&gt; AND
  reserves.found = 'W'
ORDER BY
  WAITING_SINCE DESC

























