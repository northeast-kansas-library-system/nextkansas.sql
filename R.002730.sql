/*
R.002730

----------

Name: GHW - Expired Holds
Created by: George H Williams

----------

Group: Holds-Reserves
     Holds troubleshooting

Created on: 2016-08-10 15:29:50
Modified on: 2018-04-16 10:48:28
Date last run: 2021-03-29 12:34:20

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Generates a list of items that have been on your holds shelf for more than 7 days</p>
<ul><li>Shows items that have been on a library's hold shelf for more than 7 days and have not been picked up</li>
<li>Shows items waiting at the library you specify</li>
<li>grouped by item request id and borrowernumber</li>
<li>sorted by patron's last name and card number</li>
<li>contains links to the patron's record</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Requests have many dates associated with them.  One of these dates is labeled as 'reserves.expirationdate' in the database.</p>
<p>This 'expirationdate' date is an internal date that the Koha software uses to determine if a request has been waiting for longer than 7 days.  During the upgrade on December 9, 2017, 'expirationdate' dates on all waiting requests were reset by this bug to 2017-12-09 from their original dates.  This causes the "Holds awaiting pickup report" at https://staff.nexpresslibrary.org/cgi-bin/koha/circ/waitingreserves.pl to fail to show any requests that have been waiting more than 7 days on the "Holds waiting over 7 days" tab.</p>
<p></p>
<p>This report shows the actual expiration dates of any requests that were waiting prior to December 9, 2017.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2730&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  Concat('<a href=\"/cgi-bin/koha/circ/circulation.pl?borrowernumber=', reserves.borrowernumber, '\" target="_blank">Patron record</a>') AS LINK,
  CONCAT_WS("<br />", Concat("Last name:  ",borrowers.surname),
    Concat("Card number:  ",borrowers.cardnumber)) AS PATRON,
  reserves.branchcode AS PICKUP_BRANCH,
  Concat_Ws("<br />", Concat("The following item has been on the hold shelf for more than 7 days:<br />"),
    Concat("Home Lib: ", items.homebranch),
    Concat("Currently at: ", items.holdingbranch),
    Concat("Location: ", items.location),
    Concat("Itemtype: ", items.itype),
    Concat("CCode: ", authorised_values.lib),
    Concat("Call#: ", items.itemcallnumber),
    Concat("Author: ", biblio.author), Concat("Title: ", biblio.title),
    Concat("Bcode: ", items.barcode),
    Concat("Home Lib: ", items.homebranch),
    Concat("Last seen: ", items.datelastseen, "<br />"),
    Concat("Please follow your libraries procedures for expired holds and ship these items back to their owning libraries.<br />")) AS ITEM_INFO,
  Concat_Ws("<br /><br />",Concat("Date<br />arrived: ",reserves.waitingdate),
    Concat("Expiration<br />in system: ", reserves.expirationdate),
    Concat("Actual<br />expiration: ",(reserves.waitingdate + INTERVAL 7 DAY))) AS DATES
FROM
  reserves
  JOIN borrowers ON reserves.borrowernumber = borrowers.borrowernumber
  JOIN items ON reserves.itemnumber = items.itemnumber
  JOIN biblio ON items.biblionumber = biblio.biblionumber
  LEFT JOIN authorised_values ON items.ccode = authorised_values.authorised_value
WHERE
  reserves.found = 'W' AND
  (reserves.waitingdate + INTERVAL 7 DAY) < CurDate() - INTERVAL 7 DAY AND
  authorised_values.category = "CCODE" AND
  reserves.branchcode LIKE <<Select your library|LBRANCH>>
GROUP BY
  reserves.itemnumber,
  reserves.borrowernumber
ORDER BY
  borrowers.surname,
  borrowers.firstname



