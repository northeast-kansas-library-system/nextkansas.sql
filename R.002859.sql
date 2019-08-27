/*
R.002859

----------

Name: GHW - All requests on an item by barcode number
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2016-12-15 17:58:33
Modified on: 2018-04-16 11:05:05
Date last run: -

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Shows all hold information for an item - current and past</p>
<ul><li>shows current requests and request history</li>
<li>from any item in NExpress</li>
<li>grouped by request ID</li>
<li>sorted by time of last activity on request</li>
<li>links to the corresponding current requests on a biblio report</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2859&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

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
  CONCAT('<a href=\"/cgi-bin/koha/reports/guided_reports.pl?reports=2860&phase=Run+this+report&sql_params=',biblio.biblionumber, '\" target="_blank">', biblio.biblionumber, '</a>') AS REQUESTS_ON_BIB
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
  items.barcode LIKE <<Enter item barcode number>>
GROUP BY
  allreserves.reserve_id, items.barcode
ORDER BY
  LAST_ACTIVITY DESC



