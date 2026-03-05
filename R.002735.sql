/*
R.002735

----------

Name: GHW - Biblios with more than 20 requests
Created by: George Williams

----------

Group: Holds-Reserves
     -

Created on: 2016-08-17 10:42:23
Modified on: 2024-01-17 11:36:53
Date last run: 2025-10-09 10:13:33

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Generates a list of all bibliographic records with more than 20 requests&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows current data&lt;/li&gt;
&lt;li&gt;Shows records from all NExpress libraries&lt;/li&gt;
&lt;li&gt;grouped by biblionumber&lt;/li&gt;
&lt;li&gt;sorted by item count (biggest first) and biblionumber (smallest first)&lt;/li&gt;
&lt;li&gt;contains links to the bibliographic record&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;This report was created to help NExpress libraries identify all titles with more than 20 requests because the previous report (&lt;a href="https://staff.nexpresslibrary.org/cgi-bin/koha/reports/guided_reports.pl?reports=1152&phase=Run%20this%20report" target="_blank"&gt;Report 1152&lt;/a&gt;) established to fill this role was limited to show only the 20 items with the greatest number of requests.&lt;/p&gt;
&lt;p&gt;Report created by GHW&lt;/p&gt;
&lt;/div&gt;


----------
*/



SELECT
  COUNT(reserves.reserve_id) as REQUESTS_COUNT,
  CONCAT_WS('  ',biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code&gt;="b"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')) AS FULL_TITLE,
  CONCAT( '', biblio.biblionumber, '' ) AS LINK_TO_TITLE
FROM
  reserves JOIN
    biblio
      ON reserves.biblionumber = biblio.biblionumber
        JOIN biblio_metadata
          ON biblio_metadata.biblionumber = biblio.biblionumber
GROUP BY
  biblio.biblionumber
HAVING
  Count(reserves.reserve_id) &gt; 19
ORDER BY
  REQUESTS_COUNT DESC,
  biblio.biblionumber ASC

























