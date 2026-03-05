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
Date last run: 2026-02-05 10:22:08

----------

Public: 0
Expiry: 0

----------

<div class="reportinfo noprint"> 
<p>Items marked lost. Enhanced -- choose branch, run.</p>
<ul><li>Shows items that are currently marked as "(Lost)"</li>
<li>at the library you select</li>
<li>sorted by item call number</li>
<li>contains links to the edit item page of each item</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Monthly cleanup</p>
<p></p>
<p>There are 6 "Lost" statuses in NExpress - (Lost) [status = 1]; Lost (more than 45 days overdue) [status = 2]; Missing (unable to location on shelf) [status = 3]; Lost (Damaged/Replace) [status = 4]; Lost (Patron Claims Returned) [status = 5]; Lost (more than 45 days overdue) [status = 7].  This report only shows items that have a status of "(Lost)" so nothing that was automatically marked as "Lost (more than 45 days overdue)" appears on this report.<br /></p>
<p>The only items that will appear are items that have manually been marked with the "(Lost)" status [status = 1].</p>
<p></p>
<p>Report created by HB.  Explanatory notes added by GHW on 2018.06.01.</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2026&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

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
  Concat('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=', biblio.biblionumber, '&itemnumber=', items.itemnumber, '#edititem\" target="_blank">edit item</a>') AS "edit item"
FROM
  items
  LEFT JOIN biblio ON items.biblionumber = biblio.biblionumber
  LEFT JOIN biblioitems ON biblio.biblionumber = biblioitems.biblionumber
WHERE
  items.homebranch LIKE <<Pick your branch|ZBRAN>> AND
  items.itemlost LIKE <<Status|LOST:all>>
ORDER BY
  items.itemcallnumber

























