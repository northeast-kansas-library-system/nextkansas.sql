/*
R.002735

----------

Name: GHW - Biblios with more than 20 requests
Created by: George H Williams

----------

Group: Holds-Reserves
     -

Created on: 2016-08-17 10:42:23
Modified on: 2021-03-04 19:13:32
Date last run: 2021-10-20 11:19:05

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Generates a list of all bibliographic records with more than 20 requests</p>
<ul><li>Shows current data</li>
<li>Shows records from all NExpress libraries</li>
<li>grouped by biblionumber</li>
<li>sorted by item count (biggest first) and biblionumber (smallest first)</li>
<li>contains links to the bibliographic record</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p>This report was created to help NExpress libraries identify all titles with more than 20 requests because the previous report (<a href="https://staff.nexpresslibrary.org/cgi-bin/koha/reports/guided_reports.pl?reports=1152&phase=Run%20this%20report" target="_blank">Report 1152</a>) established to fill this role was limited to show only the 20 items with the greatest number of requests.</p>
<p>Report created by GHW</p>
</div>


----------
*/



SELECT
  COUNT(reserves.reserve_id) as REQUESTS_COUNT,
  CONCAT_WS(' <br /> ',biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code>="b"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')) AS FULL_TITLE,
  CONCAT( '<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber,'\" target="_blank">', biblio.biblionumber, '</a>' ) AS LINK_TO_TITLE
FROM
  reserves JOIN
    biblio
      ON reserves.biblionumber = biblio.biblionumber
        JOIN biblio_metadata
          ON biblio_metadata.biblionumber = biblio.biblionumber
GROUP BY
  biblio.biblionumber
HAVING
  Count(reserves.reserve_id) > 19
ORDER BY
  REQUESTS_COUNT DESC,
  biblio.biblionumber ASC

























