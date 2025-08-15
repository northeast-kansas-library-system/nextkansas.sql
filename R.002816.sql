/*
R.002816

----------

Name: GHW - Quick list of titles by an author
Created by: George Williams

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2016-11-04 16:40:55
Modified on: 2024-01-17 11:47:05
Date last run: 2024-04-29 19:59:29

----------

Public: 0
Expiry: 0

----------

 
What it does generates a list of all titles by an author by brief title
Shows items currently in the catalog
shows items at a specified library by a specified author
grouped by classification, call number, author, and title information
sorted by title

Notes:

Report created at the request of Baldwin Public Library.
The author's name must be entered as SURNAME, FIRSTNAME or the report will not work
Click here to run in a new window


----------
*/



SELECT
  items.location,
  items.itype,
  authorised_values.lib AS COLLECTION_CODE,
  items.itemcallnumber AS CALL_NUMBER,
  biblio.author,
  biblio.title
FROM
  items LEFT JOIN
  biblioitems
    ON items.biblioitemnumber = biblioitems.biblioitemnumber LEFT JOIN
  biblio
    ON biblioitems.biblionumber = biblio.biblionumber LEFT JOIN
  authorised_values
    ON items.ccode = authorised_values.authorised_value
WHERE
  items.homebranch LIKE &lt;&gt; AND
  items.itype LIKE &lt;&gt; AND
  biblio.author LIKE concat('%',&lt;&gt;, '%') AND
  authorised_values.category = "CCODE"
ORDER BY
  biblio.title

























