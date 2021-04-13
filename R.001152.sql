/*
R.001152

----------

Name: Top 50 Bibs with Holds
Created by: -

----------

Group: Popular Reports
     -

Created on: 2011-07-29 16:18:30
Modified on: 2021-04-01 15:05:07
Date last run: 2021-04-01 15:05:10

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
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
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code>="b"]')
  ) AS TITLE,
  Concat(
    '<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
    biblio.biblionumber, 
    '\" target="_blank">LINK</a>'
  ) AS LINK_TO_BIBLIO,
  Concat(
    '<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=kw&q=', 
    biblio.title, 
    '&op=and&idx=kw&op=and&idx=kw&limit=mc-itype%2Cphr%3ALOCALHOLD1&limit=mc-itype%2Cphr%3AMEDIA&limit=mc-itype%2Cphr%3ANEWMEDIA&limit=mc-itype%2Cphr%3AWALKIN1&sort_by=relevance" target="_blank">video</a>'
  ) AS VIDEO_SEARCH,
  Concat(
    "<a href='https://www.youtube.com/results?search_query=official+trailer+", 
    REPLACE(SUBSTRING_INDEX(biblio.title, 
    "(", 1), 
    " ", "+"), 
    "' target='_blank'>Youtube</a>"
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



