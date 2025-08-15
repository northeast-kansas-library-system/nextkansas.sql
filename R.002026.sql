/*
R.002026

----------

Name: Items Marked Lost
Created by: Heather Braum

----------

Group: Monthly cleanup
     -

Created on: 2013-09-03 10:38:20
Modified on: 2025-07-03 11:31:41
Date last run: 2025-07-03 11:31:47

----------

Public: 0
Expiry: 0

----------

 
Items marked lost. Enhanced -- choose branch, run.
Shows items that are currently marked as "(Lost)"
at the library you select
sorted by item call number
contains links to the edit item page of each item

Notes:

Monthly cleanup

There are 6 "Lost" statuses in NExpress - (Lost) [status = 1]; Lost (more than 45 days overdue) [status = 2]; Missing (unable to location on shelf) [status = 3]; Lost (Damaged/Replace) [status = 4]; Lost (Patron Claims Returned) [status = 5]; Lost (more than 45 days overdue) [status = 7].  This report only shows items that have a status of "(Lost)" so nothing that was automatically marked as "Lost (more than 45 days overdue)" appears on this report.
The only items that will appear are items that have manually been marked with the "(Lost)" status [status = 1].

Report created by HB.  Explanatory notes added by GHW on 2018.06.01.
Click here to run in a new window


----------
*/



SELECT
  items.datelastseen,
  biblio.title,
  biblio.author,
  biblioitems.publicationyear,
  items.location,
  items.ccode,
  items.itype,
  items.itemcallnumber,
  items.barcode,
  items.holdingbranch,
  Concat('edit item') AS "edit item"
FROM
  items
  LEFT JOIN biblio ON items.biblionumber = biblio.biblionumber
  LEFT JOIN biblioitems ON biblio.biblionumber = biblioitems.biblionumber
WHERE
  items.homebranch LIKE &lt;&gt; AND
  items.itemlost LIKE &lt;&gt;
ORDER BY
  items.itemcallnumber

























