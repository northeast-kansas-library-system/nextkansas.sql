/*
R.002928

----------

Name: GHW - ATCHISON INV
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2017-04-11 12:37:40
Modified on: 2017-04-11 16:06:56
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  items.itemnumber,
  items.barcode,
  items.homebranch,
  items.holdingbranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  items.onloan,
  Coalesce(not_loan.lib, "-") AS NFL_STATUS,
  Coalesce(damaged.lib, "-") AS DAMAGED_STATUS,
  Coalesce(lost.lib, "-") AS LOST_STATUS,
  items.itemlost_on,
  Coalesce(withdrawn.lib, "-") AS WITHDRAWN_STATUS,
  items.withdrawn_on,
  reserves.found,
  transfers.datesent
FROM
  biblio
  INNER JOIN biblioitems ON biblioitems.biblionumber = biblio.biblionumber
  INNER JOIN items ON items.biblionumber = biblio.biblionumber AND items.biblioitemnumber = biblioitems.biblioitemnumber
  LEFT JOIN authorised_values not_loan ON items.notforloan = not_loan.authorised_value
  LEFT JOIN authorised_values damaged ON items.damaged = damaged.authorised_value
  LEFT JOIN (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOST') lost ON items.itemlost = lost.authorised_value
  LEFT JOIN authorised_values withdrawn ON items.withdrawn = withdrawn.authorised_value
  LEFT JOIN reserves ON reserves.itemnumber = items.itemnumber
  LEFT JOIN (SELECT
      branchtransfers.itemnumber,
      branchtransfers.datesent
    FROM
      branchtransfers
    WHERE
      branchtransfers.datearrived IS NULL) transfers ON items.itemnumber = transfers.itemnumber
WHERE
  not_loan.category = 'NOT_LOAN' AND
  damaged.category = "DAMAGED" AND
  withdrawn.category = "WITHDRAWN" AND
  items.homebranch = 'ATCHISON'
GROUP BY
  items.itemnumber
ORDER BY
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title



