/*
R.002859

----------

Name: GHW - All requests on an item by barcode number
Created by: George Williams

----------

Group: Administrative Reports
     Testing

Created on: 2016-12-15 17:58:33
Modified on: 2024-01-17 11:46:39
Date last run: 2024-04-15 10:30:17

----------

Public: 0
Expiry: 0

----------

 
Shows all hold information for an item - current and past
shows current requests and request history
from any item in NExpress
grouped by request ID
sorted by time of last activity on request
links to the corresponding current requests on a biblio report

Notes:

Click here to run in a new window


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
  CONCAT('', biblio.biblionumber, '') AS REQUESTS_ON_BIB
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
  items.barcode LIKE &lt;&gt;
GROUP BY
  allreserves.reserve_id, items.barcode
ORDER BY
  LAST_ACTIVITY DESC

























