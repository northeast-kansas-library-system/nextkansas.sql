/*
R.002497

----------

Name: Movies with Restricted Item Type more than 30 days past added
Created by: Heather Braum

----------

Group: Administrative Reports
     Local Holds - Walkin-admin

Created on: 2015-05-14 16:48:51
Modified on: 2023-10-16 22:06:04
Date last run: 2025-08-14 08:22:05

----------

Public: 0
Expiry: 0

----------

 
Lists item barcode numbers that need their item type updated to "MOVIE" after the appropriate amount of time has passed from their date of accession
Shows barcodes of items that are in need of updating
at all NExpress libraries
grouped by item barcode number
sorted by homebranch, collection code, and date accessioned

Notes:

Need for report depreciated by addition of automatic item modification by age tool added in Koha 16.11.  Run monthly to make sure automatic tool is working correctly.

Original report created by Heather Braum.  Explanatory notes added and query updated by GHW on 2017.12.28.
Click here to run in a new window


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
  items.dateaccessioned &lt; Date_Sub(CurDate(), INTERVAL 30 DAY) AND
  items.ccode &lt;&gt; 'ILL' AND
  items.ccode &lt;&gt; 'GADGET' AND
  items.ccode &lt;&gt; 'MAGAZINE' AND
  items.ccode &lt;&gt; 'COMPUTER' AND
  biblio.title NOT LIKE 'BASEHOR ILL%') OR
  (items.itype = "NVIDNEW" AND
  items.dateaccessioned &lt; Date_Sub(CurDate(), INTERVAL 60 DAY) AND
  items.homebranch = "MCLOUTH")
GROUP BY
  items.barcode
ORDER BY
  items.homebranch,
  items.ccode,
  items.dateaccessioned
LIMIT 1000

























