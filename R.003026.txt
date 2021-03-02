/*
R.003026

----------

Name: GHW - YE Special BONNERSPGS
Created by: George H Williams

----------

Group: Daily, Monthly, Yearly Stats
     Yearly

Created on: 2017-12-31 14:41:04
Modified on: 2017-12-31 14:41:04
Date last run: 2018-02-01 13:59:53

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  deleteditems.barcode,
  deleteditems.homebranch,
  deleteditems.holdingbranch,
  location.lib AS LOCATION,
  itemtypes.description AS ITYPE,
  ccode.lib AS CCODE,
  deleteditems.itemcallnumber,
  Coalesce(biblio.author, deletedbiblio.author) AS AUTHOR,
  Coalesce(biblio.title, deletedbiblio.title) AS TITLE,
  deleteditems.price,
  deleteditems.replacementprice,
  deleteditems.timestamp AS DELETED_ON,
  deleteditems.itemlost,
  deleteditems.itemlost_on,
  deleteditems.withdrawn,
  deleteditems.withdrawn_on
FROM
  deleteditems
  LEFT JOIN biblio ON deleteditems.biblionumber = biblio.biblionumber
  LEFT JOIN deletedbiblio ON deleteditems.biblionumber = deletedbiblio.biblionumber
  LEFT JOIN itemtypes ON deleteditems.itype = itemtypes.itemtype
  LEFT JOIN (SELECT
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE'
    GROUP BY
      authorised_values.authorised_value,
      authorised_values.lib) ccode ON deleteditems.ccode = ccode.authorised_value
  LEFT JOIN (SELECT
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC'
    GROUP BY
      authorised_values.authorised_value,
      authorised_values.lib) location ON deleteditems.location = location.authorised_value
WHERE
  deleteditems.homebranch LIKE 'BONNERSPGS' AND
  Coalesce(deleteditems.location, "-") LIKE '%' AND
  Coalesce(deleteditems.itype, "-") LIKE '%' AND
  Coalesce(deleteditems.ccode, "-") LIKE '%' AND
  deleteditems.timestamp BETWEEN '2017-01-01' AND ('2017-12-31' + INTERVAL 1 DAY) 
GROUP BY
  deleteditems.itemnumber
ORDER BY
  deleteditems.homebranch,
  LOCATION,
  ITYPE,
  CCODE,
  AUTHOR,
  TITLE,
  deleteditems.itemcallnumber



