/*
R.003383

----------

Name: koha-US Demo 52
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-11-23 10:14:46
Modified on: 2020-11-23 10:27:41
Date last run: 2020-11-23 12:14:51

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
  biblio.author,
  biblio.title
FROM
  deleteditems JOIN
  biblio ON biblio.biblionumber = deleteditems.biblionumber
WHERE
  deleteditems.barcode Like <<Enter item barcode number>>
GROUP BY
  deleteditems.itemnumber,
  biblio.biblionumber



