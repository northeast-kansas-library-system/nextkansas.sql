/*
R.000214

----------

Name: Null Report - Missing Item Type report for all libraries
Created by: -

----------

Group: Administrative Reports
     Fix Items-admin

Created on: 2009-01-26 12:07:07
Modified on: 2018-04-16 10:40:18
Date last run: 2020-08-15 15:52:22

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Shows items with Unknown (itype code XXX) item type or no item type</p>
<ul><li>Shows items that currently have problematic item types</li>
<li>shows items from all NExpress libraries</li>
<li>grouped by item barcode</li>
<li>sorted by item homebranches</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p>Should be run monthly</p>
<p>Report created by Heather Braum.  Explanatory notes added by GHW on 2016.08.19.</p>
</div>

----------
*/

SELECT
  items.homebranch,
  items.barcode,
  items.dateaccessioned,
  items.ccode,
  items.itemcallnumber,
  items.itype,
  biblio.author,
  biblio.title
FROM
  items JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber
WHERE
  (items.itype IS NULL) OR
  (items.itype = 'XXX')
GROUP BY
  items.barcode
ORDER BY
  items.homebranch



