/*
R.002498

----------

Name: Books with Restricted Item Type more than 60 days past added
Created by: Heather Braum

----------

Group: Administrative Reports
     Local Holds - Walkin-admin

Created on: 2015-05-14 16:53:56
Modified on: 2023-10-16 22:06:00
Date last run: 2026-01-28 16:33:07

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Lists item barcode numbers that need their item type updated to "BOOK" after the appropriate amount of time has passed from their date of accession&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows barcodes of items that are in need of updating&lt;/li&gt;
&lt;li&gt;at all NExpress libraries&lt;/li&gt;
&lt;li&gt;grouped by item barcode number&lt;/li&gt;
&lt;li&gt;sorted by homebranch, collection code, and date accessioned&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Need for report depreciated by addition of automatic item modification by age tool added in Koha 16.11.  Run monthly to make sure automatic tool is working correctly.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Original report created by Heather Braum.  Explanatory notes added and query updated by GHW on 2017.12.28.&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2498&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

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
  items.dateaccessioned &lt; curdate() - Interval 60 Day AND
  (items.ccode &lt;&gt; 'ILL' AND items.ccode &lt;&gt; 'GADGET' AND items.ccode &lt;&gt; 'MAGAZINE' AND items.ccode &lt;&gt; 'COMPUTER') AND
  biblio.title NOT LIKE 'BASEHOR ILL%'
ORDER BY
  items.homebranch,
  items.ccode,
  items.dateaccessioned DESC
LIMIT 1000

























