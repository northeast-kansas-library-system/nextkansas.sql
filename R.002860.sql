/*
R.002860

----------

Name: GHW - All requests on a bibliographic record
Created by: George Williams

----------

Group: -
     -

Created on: 2016-12-15 18:29:15
Modified on: 2016-12-15 18:37:11
Date last run: 2019-06-30 21:12:17

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT
  allreserves.timestamp AS LAST_ACTIVITY,
  items.homebranch AS HOME,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  borrowers.cardnumber AS PATRON_BC,
  allreserves.branchcode AS PICK_UP,
  allreserves.reservedate AS PLACED,
  allreserves.waitingdate,
  allreserves.cancellationdate,
  allreserves.expirationdate,
  allreserves.found,
  allreserves.reservenotes,
  items.barcode,
  CONCAT('', items.barcode, '') AS REQUESTS_ON_BIB
FROM
  (SELECT
    *
  FROM
    old_reserves
  UNION
  SELECT
    *
  FROM
    reserves) allreserves RIGHT JOIN
  biblio
    ON biblio.biblionumber = allreserves.biblionumber LEFT JOIN
  items
    ON allreserves.itemnumber = items.itemnumber JOIN
  borrowers
    ON borrowers.borrowernumber = allreserves.borrowernumber
WHERE
  biblio.biblionumber LIKE <>
GROUP BY
  allreserves.reserve_id, items.barcode
ORDER BY
  LAST_ACTIVITY DESC

























