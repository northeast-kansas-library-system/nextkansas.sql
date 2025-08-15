/*
R.002805

----------

Name: GHW - Requests cancelled after they were on the holds shelf
Created by: George Williams

----------

Group: Holds-Reserves
     Holds troubleshooting

Created on: 2016-10-12 11:57:05
Modified on: 2024-01-17 11:36:07
Date last run: 2024-10-08 10:22:32

----------

Public: 0
Expiry: 0

----------

 
Looks for requests that were cancelled after they were already waiting on the holds shelf
Allows you to specify a "Start date" - will show you requests cancelled after that date
Shows holds cancelled at a specified branch
grouped and sorted by patron name, library card number, item home branch, item type, call number informaiton, author, and title
includes links to the bibliographic records of the items cancelled

Notes:
Click here to run in a new window


----------
*/



SELECT
  borrowers.cardnumber AS PATRON_BC,
  CONCAT(borrowers.surname,', ',borrowers.firstname) AS PATRON_NAME,
  items.barcode AS ITEM_BC,
  items.homebranch AS ITEM_HOMEBRANCH,
  items.itype,
  CONCAT_WS('',items.location, authorised_values.lib, items.itemcallnumber) AS CALL_NUMBER,
  CONCAT_WS('',biblio.author,(CONCAT_WS('',biblio.title,ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')))) AS AUTHOR_TITLE,
  old_reserves.cancellationdate AS DATE_CANCELLED,
  CONCAT('Go to biblio') AS LINK
FROM
  old_reserves JOIN
  borrowers
    ON old_reserves.borrowernumber = borrowers.borrowernumber JOIN
  items
    ON old_reserves.itemnumber = items.itemnumber JOIN
  biblio_metadata
    ON items.biblionumber = biblio_metadata.biblionumber JOIN
  biblio
    ON biblio_metadata.biblionumber = biblio.biblionumber JOIN
  authorised_values
    ON items.ccode = authorised_values.authorised_value
WHERE
  old_reserves.branchcode = &lt;&gt; AND
  old_reserves.cancellationdate IS NOT NULL AND
  old_reserves.waitingdate IS NOT NULL AND
  old_reserves.timestamp &gt; &lt;&gt; AND
  authorised_values.category = "CCODE"
GROUP BY
  old_reserves.branchcode,
  PATRON_NAME,
  PATRON_BC,
  items.homebranch,
  items.itype,
  CALL_NUMBER,
  AUTHOR_TITLE
ORDER BY
  old_reserves.branchcode,
  PATRON_NAME,
  PATRON_BC,
  items.homebranch,
  items.itype,
  CALL_NUMBER,
  AUTHOR_TITLE

























