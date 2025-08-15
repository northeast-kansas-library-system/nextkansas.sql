/*
R.003776

----------

Name: GHW - Expired Holds
Created by: George Williams

----------

Group: Holds-Reserves
     Holds troubleshooting

Created on: 2023-10-16 22:04:55
Modified on: 2023-10-16 22:04:55
Date last run: 2024-04-17 14:32:34

----------

Public: 0
Expiry: 300

----------

 
Generates a list of items that have been on your holds shelf for more than 7 days
Shows items that have been on a library's hold shelf for more than 7 days and have not been picked up
Shows items waiting at the library you specify
grouped by item request id and borrowernumber
sorted by patron's last name and card number
contains links to the patron's record

Notes:

Requests have many dates associated with them.  One of these dates is labeled as 'reserves.expirationdate' in the database.
This 'expirationdate' date is an internal date that the Koha software uses to determine if a request has been waiting for longer than 7 days.  During the upgrade on December 9, 2017, 'expirationdate' dates on all waiting requests were reset by this bug to 2017-12-09 from their original dates.  This causes the "Holds awaiting pickup report" at https://staff.nexpresslibrary.org/cgi-bin/koha/circ/waitingreserves.pl to fail to show any requests that have been waiting more than 7 days on the "Holds waiting over 7 days" tab.

This report shows the actual expiration dates of any requests that were waiting prior to December 9, 2017.

Click here to run in a new window


----------
*/



SELECT
  Concat('Patron record') AS LINK,
  CONCAT_WS("", Concat("Last name:  ",borrowers.surname),
    Concat("Card number:  ",borrowers.cardnumber)) AS PATRON,
  reserves.branchcode AS PICKUP_BRANCH,
  Concat_Ws("", Concat("The following item has been on the hold shelf for more than 7 days:"),
    Concat("Home Lib: ", items.homebranch),
    Concat("Currently at: ", items.holdingbranch),
    Concat("Location: ", items.location),
    Concat("Itemtype: ", items.itype),
    Concat("CCode: ", authorised_values.lib),
    Concat("Call#: ", items.itemcallnumber),
    Concat("Author: ", biblio.author), Concat("Title: ", biblio.title),
    Concat("Bcode: ", items.barcode),
    Concat("Home Lib: ", items.homebranch),
    Concat("Last seen: ", items.datelastseen, ""),
    Concat("Please follow your libraries procedures for expired holds and ship these items back to their owning libraries.")) AS ITEM_INFO,
  Concat_Ws("",Concat("Datearrived: ",reserves.waitingdate),
    Concat("Expirationin system: ", reserves.expirationdate),
    Concat("Actualexpiration: ",(reserves.waitingdate + INTERVAL 7 DAY))) AS DATES
FROM
  reserves
  JOIN borrowers ON reserves.borrowernumber = borrowers.borrowernumber
  JOIN items ON reserves.itemnumber = items.itemnumber
  JOIN biblio ON items.biblionumber = biblio.biblionumber
  LEFT JOIN authorised_values ON items.ccode = authorised_values.authorised_value
WHERE
  reserves.found = 'W' AND
  (reserves.waitingdate + INTERVAL 7 DAY) &lt; CurDate() - INTERVAL 7 DAY AND
  authorised_values.category = "CCODE" AND
  reserves.branchcode LIKE &lt;&gt;
GROUP BY
  reserves.itemnumber,
  reserves.borrowernumber
ORDER BY
  borrowers.surname,
  borrowers.firstname

























