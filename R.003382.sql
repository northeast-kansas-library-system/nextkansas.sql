/*
R.003382

----------

Name: koha-US Demo 51
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-11-23 10:12:56
Modified on: 2020-11-23 12:13:31
Date last run: 2020-11-23 12:13:55

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  deleteditems.biblionumber,
  deleteditems.itemnumber,
  deleteditems.barcode,
  deleteditems.homebranch,
  deleteditems.holdingbranch,
  deleteditems.permanent_location,
  deleteditems.location,
  deleteditems.itype,
  deleteditems.ccode
FROM
  deleteditems
WHERE
  deleteditems.barcode Like <<Enter barcode number>>
GROUP BY
  deleteditems.itemnumber



