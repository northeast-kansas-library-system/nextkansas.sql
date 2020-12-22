/*
R.003385

----------

Name: koha-US Demo 54
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-11-23 10:19:46
Modified on: 2020-11-23 10:27:32
Date last run: 2020-11-23 12:17:45

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
  deletedbiblio.title,
  biblio.author AS author1,
  biblio.title AS title1
FROM
  deleteditems LEFT JOIN
  biblio ON biblio.biblionumber = deleteditems.biblionumber LEFT JOIN
  deletedbiblio ON deletedbiblio.biblionumber = deleteditems.biblionumber
WHERE
  deleteditems.barcode LIKE <<Enter item barcode number>>
GROUP BY
  deleteditems.itemnumber,
  deletedbiblio.author,
  deletedbiblio.title,
  biblio.author,
  biblio.title



