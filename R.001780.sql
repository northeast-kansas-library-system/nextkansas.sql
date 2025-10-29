/*
R.001780

----------

Name: GHW - 300 sub Fields
Created by: Heather Braum

----------

Group: Administrative Reports
     Fix Bib Records-admin

Created on: 2013-03-30 13:12:17
Modified on: 2019-05-06 11:35:46
Date last run: 2019-05-06 11:35:51

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT
  Concat('Link') AS LINK_TO_TITLE,
  biblio.title,
  biblio.author,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="300"]/subfield[@code="a"]') AS EXTENT,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="300"]/subfield[@code="b"]') AS OTHER_DETAILS,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="300"]/subfield[@code="c"]') AS DIMENSIONS,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="300"]/subfield[@code="e"]') AS ACCOMPANYING,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="300"]/subfield[@code="f"]') AS TYPE,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="300"]/subfield[@code="g"]') AS SIZE,
  Concat('', biblio.title, '') AS SEARCH_THIS_TITLE,
  biblio.datecreated
FROM
  biblio
  JOIN biblio_metadata
    ON biblio_metadata.biblionumber = biblio.biblionumber
WHERE
  biblio.datecreated BETWEEN <> AND <>
GROUP BY
  biblio.biblionumber,
  biblio.datecreated
ORDER BY
  biblio.biblionumber DESC

























