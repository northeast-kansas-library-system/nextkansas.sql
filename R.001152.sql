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
Date last run: 2025-05-15 16:59:43

----------

Public: 0
Expiry: 0

----------

 
Generates a list of the 50 bibliographic records with the greatest numbers of requests
Shows current data
Shows bibliographic records from all Next Search Cataloglibraries
grouped by biblionumber
sorted by request count (biggest first)
contains links to the bibliographic record

Notes:
This report is being replaced by report 2735 which shows all items with more than 20 requests.
Report created by HB.


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

























