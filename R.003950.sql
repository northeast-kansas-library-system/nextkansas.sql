/*
R.003950

----------

Name: 586 $a field
Created by: Nikki Hansen

----------

Group: -
     -

Created on: 2026-03-19 14:01:00
Modified on: 2026-04-10 17:07:03
Date last run: 2026-04-18 12:37:49

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
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="586"][1]/subfield[@code="a"]') AS '586$a_1',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="586"][2]/subfield[@code="a"]') AS '586$a_2',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="586"][3]/subfield[@code="a"]') AS '586$a_3',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="586"][4]/subfield[@code="a"]') AS '586$a_4',
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="586"][5]/subfield[@code="a"]') AS '586$a_5'
FROM
  biblio JOIN
  biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
WHERE
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="586"]/subfield[@code="a"]') NOT LIKE ''
GROUP BY
  biblio.biblionumber 
ORDER BY 
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="586"]/subfield[@code="a"]') ASC

























