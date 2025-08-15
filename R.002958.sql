/*
R.002958

----------

Name: GHW - Deleted items list by date range
Created by: George Williams

----------

Group: Catalog Records and Items
     Weeded Already

Created on: 2017-06-15 10:26:44
Modified on: 2024-01-17 11:49:44
Date last run: 2025-07-01 08:38:49

----------

Public: 0
Expiry: 300

----------

 
Generates a list of items that have already been deleted from the catalog - includes all price information as well as the timestamp from when the item was deleted
Lists items that were deleted between the dates you specify
at the library you specify
grouped by itemnumber
sorted by homebranch, location, item type, collection code, author, title, and call number

Notes:

This gets the item information from the deleteditems table and the biblio information from the biblios table or the deletedbiblios table depending on whether or not the bibliographic record has been deleted.

Click here to run in a new window


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
  deleteditems.homebranch LIKE &lt;&gt; AND
  Coalesce(deleteditems.location, "-") LIKE &lt;&gt; AND
  Coalesce(deleteditems.itype, "-") LIKE &lt;&gt; AND
  Coalesce(deleteditems.ccode, "-") LIKE &lt;&gt; AND
  deleteditems.timestamp BETWEEN &lt;&gt; AND (&lt;&gt; + INTERVAL 1 DAY) 
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

























