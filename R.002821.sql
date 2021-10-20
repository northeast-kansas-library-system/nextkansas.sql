/*
R.002821

----------

Name: GHW - DONI testing
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2016-11-11 10:28:07
Modified on: 2017-02-28 22:38:43
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT
  Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', reserves.biblionumber, '\" target="_blank">', reserves.biblionumber, '</a>') AS LINK_TO_TITLE,
  Min(reserves.priority) AS Min_priority,
  reserves.branchcode AS PICKUP_BRANCH,
  Concat('<a href=\"/cgi-bin/koha/reserve/request.pl?biblionumber=', reserves.biblionumber, '\" target="_blank">', reserves.biblionumber, '</a>') AS LINK_TO_HOLD,
  items.barcode,
  Concat('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=', reserves.biblionumber, '&itemnumber=',items.itemnumber,'\" target="_blank">', items.itemnumber, '</a>') AS LINK_TO_EDIT,
  items.itemnumber,
  items.homebranch,
  items.itemnotes_nonpublic
FROM
  reserves INNER JOIN
  items
    ON reserves.biblionumber = items.biblionumber
WHERE
  items.homebranch <> reserves.branchcode AND
  items.homebranch LIKE 'DONI%' AND
  reserves.branchcode LIKE 'DONI%' AND
  reserves.biblionumber IN (SELECT
    reserves.biblionumber
  FROM
    reserves
  WHERE
    reserves.waitingdate IS NULL
  GROUP BY
    reserves.biblionumber
  HAVING
    Count(reserves.reserve_id) > 1) AND
  reserves.biblionumber IN (SELECT
    reserves.biblionumber
  FROM
    reserves JOIN
    items
      ON reserves.biblionumber = items.biblionumber
  WHERE
    reserves.branchcode <> items.homebranch
  GROUP BY
    reserves.biblionumber) AND
  reserves.biblionumber IN (SELECT
    items.biblionumber
  FROM
    items
  WHERE
    items.homebranch LIKE 'DONI%')
GROUP BY
  reserves.biblionumber, items.barcode, items.homebranch
HAVING
  Min(reserves.priority) <> 0
ORDER BY
  reserves.biblionumber

























