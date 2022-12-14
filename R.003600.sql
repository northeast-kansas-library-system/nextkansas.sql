/*
R.003600

----------

Name: GHW - 260 > 264 needed
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-10-25 12:41:40
Modified on: 2022-09-06 10:19:24
Date last run: 2022-12-13 10:20:05

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
  items ON 
    items.biblioitemnumber = biblioitems.biblioitemnumber JOIN 
    biblio_metadata ON 
      biblio_metadata.biblionumber = biblioitems.biblionumber 
WHERE 
  ( 
    biblioitems.publicationyear IS NULL AND 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="260"]/subfield[@code="c"]') <> '' 
  ) OR 
  ( 
    biblioitems.publishercode IS NULL AND 
    ExtractValue(biblio_metadata.metadata,'//datafield[@tag="260"]/subfield[@code="b"]') <> '' 
  ) OR 
  ( 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="260"]/subfield[@code="a"]') <> '' 
  ) 
GROUP BY 
  biblioitems.biblionumber 
LIMIT 1000 

























