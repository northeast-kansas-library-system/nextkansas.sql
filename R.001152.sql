/*
R.001152

----------

Name: Top 50 Bibs with Holds
Created by: -

----------

Group: Popular Reports
     -

Created on: 2011-07-29 16:18:30
Modified on: 2023-10-16 21:57:18
Date last run: 2026-01-28 10:36:29

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Generates a list of the 50 bibliographic records with the greatest numbers of requests&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows current data&lt;/li&gt;
&lt;li&gt;Shows bibliographic records from all Next Search Cataloglibraries&lt;/li&gt;
&lt;li&gt;grouped by biblionumber&lt;/li&gt;
&lt;li&gt;sorted by request count (biggest first)&lt;/li&gt;
&lt;li&gt;contains links to the bibliographic record&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;This report is being replaced by &lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2735&phase=Run%20this%20report" target="_blank"&gt;report 2735&lt;/a&gt; which shows all items with more than 20 requests.&lt;/p&gt;
&lt;p&gt;Report created by HB.&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  count(&ast;) AS NUMBER_OF_REQUESTS,
  Concat(
    biblio.title, 
    " ", 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code&gt;="b"]')
  ) AS TITLE,
  Concat(
    'LINK'
  ) AS LINK_TO_BIBLIO,
  Concat(
    'video'
  ) AS VIDEO_SEARCH,
  Concat(
    "Youtube"
  ) AS YOUTUBE
FROM
  reserves
  JOIN biblio ON reserves.biblionumber = biblio.biblionumber
  JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
GROUP BY
  biblio.biblionumber
ORDER BY
  count(&ast;) DESC
LIMIT 50

























