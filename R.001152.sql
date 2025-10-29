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
Date last run: 2025-10-27 09:01:45

----------

Public: 0
Expiry: 0

----------

<div class="reportinfo noprint"> 
<p>Generates a list of the 50 bibliographic records with the greatest numbers of requests</p>
<ul><li>Shows current data</li>
<li>Shows bibliographic records from all Next Search Cataloglibraries</li>
<li>grouped by biblionumber</li>
<li>sorted by request count (biggest first)</li>
<li>contains links to the bibliographic record</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p>This report is being replaced by <a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2735&phase=Run%20this%20report" target="_blank">report 2735</a> which shows all items with more than 20 requests.</p>
<p>Report created by HB.</p>
</div>

----------
*/



SELECT
  count(*) AS NUMBER_OF_REQUESTS,
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
  count(*) DESC
LIMIT 50

























