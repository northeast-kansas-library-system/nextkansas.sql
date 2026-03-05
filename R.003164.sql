/*
R.003164

----------

Name: GHW - Hootsuite scheduled post generator - single title by barcode number
Created by: George Williams

----------

Group: Administrative Reports
     -

Created on: 2019-01-31 09:29:30
Modified on: 2024-01-17 11:55:18
Date last run: 2019-03-28 09:49:15

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Generates an easily scheduled media post for a new title&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows a title or titles based on the barcode number you specify&lt;/li&gt;
&lt;li&gt;At all Next libraries&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p id="rquickopen"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3164&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  Concat(
    "Recently added:",
    Upper(Replace(Replace(Replace(Replace(biblio.title, " /", ""),  " :", ""), " ;", ""), ".", "")),
    "https://nextkansas.org/cgi-bin/koha/opac-detail.pl?biblionumber=",
    biblio.biblionumber
  ) AS NEWSTUFF
FROM
  biblio
  JOIN items ON items.biblionumber = biblio.biblionumber
WHERE
  items.barcode LIKE Concat("%", &lt;&gt;, "%") AND
  (items.notforloan = 0 OR
    items.notforloan IS NULL) AND
  (items.damaged = 0 OR
    items.damaged IS NULL) AND
  (items.itemlost = 0 OR
    items.itemlost IS NULL) AND
  (items.withdrawn = 0 OR
    items.withdrawn IS NULL)

























