/*
R.003600

----------

Name: GHW - 260 > 264 needed
Created by: George Williams

----------

Group: -
     -

Created on: 2021-10-25 12:41:40
Modified on: 2026-07-09 15:43:18
Date last run: 2026-07-09 15:43:18

----------

Public: 0
Expiry: 300

----------

<div> 
<p>Click here to download as a csv file</p>
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
LIMIT 100

























