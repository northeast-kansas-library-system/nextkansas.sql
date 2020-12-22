/*
R.003384

----------

Name: koha-US Demo 53
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-11-23 10:16:23
Modified on: 2020-11-23 10:27:37
Date last run: 2020-11-23 12:16:23

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
  deleteditems.ccode,
  deletedbiblio.author,
  deletedbiblio.title
FROM
  deleteditems JOIN
  deletedbiblio ON deletedbiblio.biblionumber = deleteditems.biblionumber
WHERE
  deleteditems.barcode Like <<Item barcode number>>
GROUP BY
  deleteditems.itemnumber,
  deletedbiblio.biblionumber



