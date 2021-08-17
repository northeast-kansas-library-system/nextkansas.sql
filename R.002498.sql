/*
R.002498

----------

Name: Books with Restricted Item Type more than 60 days past added
Created by: Heather Braum

----------

Group: Administrative Reports
     Local Holds - Walkin-admin

Created on: 2015-05-14 16:53:56
Modified on: 2021-05-05 15:29:34
Date last run: 2021-08-17 09:47:27

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Lists item barcode numbers that need their item type updated to "BOOK" after the appropriate amount of time has passed from their date of accession</p>
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
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2498&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  items.itemnumber,
  items.barcode
FROM
  items
  JOIN biblio ON items.biblionumber = biblio.biblionumber
WHERE
  (items.itype = 'LOCALHOLD2' or items.itype = 'WALKIN2') AND
  items.dateaccessioned < curdate() - Interval 60 Day AND
  (items.ccode <> 'ILL' AND items.ccode <> 'GADGET' AND items.ccode <> 'MAGAZINE' AND items.ccode <> 'COMPUTER') AND
  biblio.title NOT LIKE 'BASEHOR ILL%'
ORDER BY
  items.homebranch,
  items.ccode,
  items.dateaccessioned DESC
LIMIT 1000



