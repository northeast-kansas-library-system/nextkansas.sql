/*
R.003949

----------

Name: GHW - Awards field
Created by: George Williams

----------

Group: -
     -

Created on: 2026-03-19 13:41:39
Modified on: 2026-03-19 13:56:07
Date last run: 2026-03-19 14:41:24

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblio.biblionumber,
  biblio.author,
  biblio.title,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="586"]/subfield[@code="a"]') AS '586$a'
FROM
  biblio JOIN
  biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
WHERE
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="586"]/subfield[@code="a"]') NOT LIKE ''
GROUP BY
  biblio.biblionumber 
ORDER BY 
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="586"]/subfield[@code="a"]') ASC

























