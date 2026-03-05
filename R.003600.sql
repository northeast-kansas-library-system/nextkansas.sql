/*
R.003600

----------

Name: GHW - 260 &gt; 264 needed
Created by: George Williams

----------

Group: -
     -

Created on: 2021-10-25 12:41:40
Modified on: 2025-05-12 13:50:04
Date last run: 2025-12-26 13:21:13

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p id="rquickdown"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=3600"&gt;Click here to download as a csv file&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;



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
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="260"]/subfield[@code="c"]') &lt;&gt; '' 
  ) OR 
  ( 
    biblioitems.publishercode IS NULL AND 
    ExtractValue(biblio_metadata.metadata,'//datafield[@tag="260"]/subfield[@code="b"]') &lt;&gt; '' 
  ) OR 
  ( 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="260"]/subfield[@code="a"]') &lt;&gt; '' 
  ) 
GROUP BY 
  biblioitems.biblionumber 
LIMIT 500 

























