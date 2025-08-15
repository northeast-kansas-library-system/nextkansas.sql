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
Date last run: 2025-08-06 10:14:45

----------

Public: 0
Expiry: 0

----------

 
Generates a list of all bibliographic records with more than 20 requests
Shows current data
Shows records from all NExpress libraries
grouped by biblionumber
sorted by item count (biggest first) and biblionumber (smallest first)
contains links to the bibliographic record

Notes:
This report was created to help NExpress libraries identify all titles with more than 20 requests because the previous report (Report 1152) established to fill this role was limited to show only the 20 items with the greatest number of requests.
Report created by GHW



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

























