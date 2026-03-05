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
Date last run: 2026-01-28 16:33:06

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Lists item barcode numbers that need their item type updated to "MOVIE" after the appropriate amount of time has passed from their date of accession&lt;/p&gt;
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
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2497&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

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

























