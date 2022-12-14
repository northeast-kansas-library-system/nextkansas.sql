/*
R.003313

----------

Name: GHW - COVID helper
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-03-14 01:12:14
Modified on: 2020-03-15 22:14:48
Date last run: 2022-12-14 11:32:31

----------

Public: 0
Expiry: 300

----------

https://www.openmultipleurl.com/

----------
*/



SELECT
  Concat('https://staff.nextkansas.org/cgi-bin/koha/reserve/request.pl?biblionumber=', items.biblionumber) AS LINK,
  items.itemnumber,
  items.barcode,
  items.homebranch,
  items.holdingbranch,
  reservess.branchcode,
  reservess.surname,
  reservess.cardnumber,
  reservess.reservedate,
  reservess.expirationdate,
  reservess.reserve_id
FROM
  items LEFT JOIN
  (SELECT
      borrowers.cardnumber,
      borrowers.surname,
      reserves.itemnumber,
      reserves.branchcode,
      reserves.reservedate,
      reserves.expirationdate,
      reserves.reserve_id
    FROM
      reserves JOIN
      borrowers ON reserves.borrowernumber = borrowers.borrowernumber
    WHERE
      reserves.branchcode = 'NEKLS') reservess ON reservess.itemnumber = items.itemnumber
WHERE
  items.homebranch = <<Affected library|branches>> AND
  items.holdingbranch <> <<Affected library|branches>> AND
  (items.itemlost IS NULL OR
      items.itemlost = '' OR
      items.itemlost = 0)

























