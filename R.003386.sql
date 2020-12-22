/*
R.003386

----------

Name: koha-US Demo 55
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-11-23 10:21:44
Modified on: 2020-11-23 10:27:30
Date last run: 2020-11-23 12:19:01

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
  Coalesce(biblio.author, deletedbiblio.author) AS AUTHOR,
  Coalesce(biblio.title, deletedbiblio.title) AS TITLE
FROM
  deleteditems LEFT JOIN
  biblio ON biblio.biblionumber = deleteditems.biblionumber LEFT JOIN
  deletedbiblio ON deletedbiblio.biblionumber = deleteditems.biblionumber
WHERE
  deleteditems.barcode LIKE <<Enter barcode number>>
GROUP BY
  deleteditems.itemnumber



