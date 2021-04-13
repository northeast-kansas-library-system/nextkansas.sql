/*
R.002958

----------

Name: GHW - Deleted items list by date range
Created by: George H Williams

----------

Group: Catalog Records and Items
     Weeded Already

Created on: 2017-06-15 10:26:44
Modified on: 2018-04-16 11:11:10
Date last run: 2021-04-12 10:24:39

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Generates a list of items that have already been deleted from the catalog - includes all price information as well as the timestamp from when the item was deleted</p>
<ul><li>Lists items that were deleted between the dates you specify</li>
<li>at the library you specify</li>
<li>grouped by itemnumber</li>
<li>sorted by homebranch, location, item type, collection code, author, title, and call number</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>This gets the item information from the deleteditems table and the biblio information from the biblios table or the deletedbiblios table depending on whether or not the bibliographic record has been deleted.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2958&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

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
  deleteditems.homebranch LIKE <<Choose item home library|LBRANCH>> AND
  Coalesce(deleteditems.location, "-") LIKE <<Choose location|LLOC>> AND
  Coalesce(deleteditems.itype, "-") LIKE <<Choose item type|LITYPES>> AND
  Coalesce(deleteditems.ccode, "-") LIKE <<Choose collection code|LCCODE>> AND
  deleteditems.timestamp BETWEEN <<Between the beginning of the day on|date>> AND (<<and the end of the day on|date>> + INTERVAL 1 DAY) 
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



