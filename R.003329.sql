/*
R.003329

----------

Name: GHW - ADMINREPORT items in transit to HIAWATHA
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-05-28 10:35:43
Modified on: 2020-05-28 10:36:47
Date last run: 2020-05-28 11:21:17

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  Concat('<a href="/cgi-bin/koha/reserve/request.pl?biblionumber=', reserves.biblionumber,'" target="_blank">LINK</a>') AS LINK,
  borrowers.cardnumber,
  borrowers.surname,
  reserves.reservedate,
  reserves.branchcode AS PICKUP_AT,
  items.barcode,
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  reserves.suspend,
  reserves.suspend_until,
  reserves.found,
  reserves.borrowernumber
FROM
  reserves JOIN
  items ON reserves.itemnumber = items.itemnumber INNER JOIN
  biblio ON items.biblionumber = biblio.biblionumber INNER JOIN
  borrowers ON reserves.borrowernumber = borrowers.borrowernumber
WHERE
  reserves.branchcode = 'HIAWATHA' AND
  reserves.found = 'T'



