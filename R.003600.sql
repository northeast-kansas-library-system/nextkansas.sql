/*
R.003600

----------

Name: GHW - 260 > 264 needed
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-10-25 12:41:40
Modified on: 2021-10-25 12:49:22
Date last run: 2022-03-22 22:46:27

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3600">Click here to download as a csv file</a></p>
</div>



----------
*/



SELECT
  biblioitems.biblionumber
FROM
  biblioitems JOIN
  items ON items.biblioitemnumber = biblioitems.biblioitemnumber JOIN
  biblio_metadata ON biblio_metadata.biblionumber = biblioitems.biblionumber
WHERE
  biblioitems.publicationyear IS NULL AND
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="260"]/subfield[@code="c"]') <> ''
GROUP BY
  biblioitems.biblionumber
LIMIT 1000

























