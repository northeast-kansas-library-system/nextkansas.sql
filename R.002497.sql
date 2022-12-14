/*
R.002497

----------

Name: Movies with Restricted Item Type more than 30 days past added
Created by: Heather Braum

----------

Group: Administrative Reports
     Local Holds - Walkin-admin

Created on: 2015-05-14 16:48:51
Modified on: 2021-05-05 15:32:06
Date last run: 2022-12-13 10:04:25

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Lists item barcode numbers that need their item type updated to "MOVIE" after the appropriate amount of time has passed from their date of accession</p>
<ul><li>Shows barcodes of items that are in need of updating</li>
<li>at all NExpress libraries</li>
<li>grouped by item barcode number</li>
<li>sorted by homebranch, collection code, and date accessioned</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Need for report depreciated by addition of automatic item modification by age tool added in Koha 16.11.  Run monthly to make sure automatic tool is working correctly.</p>
<p></p>
<p>Original report created by Heather Braum.  Explanatory notes added and query updated by GHW on 2017.12.28.</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2497&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  items.itemnumber,
  items.barcode
FROM
  items
  JOIN biblio ON items.biblioitemnumber = biblio.biblionumber
WHERE
  ((items.itype = 'NVIDLH' OR
    items.itype = 'NVIDWALK') AND
  items.dateaccessioned < Date_Sub(CurDate(), INTERVAL 30 DAY) AND
  items.ccode <> 'ILL' AND
  items.ccode <> 'GADGET' AND
  items.ccode <> 'MAGAZINE' AND
  items.ccode <> 'COMPUTER' AND
  biblio.title NOT LIKE 'BASEHOR ILL%') OR
  (items.itype = "NVIDNEW" AND
  items.dateaccessioned < Date_Sub(CurDate(), INTERVAL 60 DAY) AND
  items.homebranch = "MCLOUTH")
GROUP BY
  items.barcode
ORDER BY
  items.homebranch,
  items.ccode,
  items.dateaccessioned
LIMIT 1000

























