/*
R.003812

----------

Name: GHW - Control fields
Created by: George Williams

----------

Group: -
     -

Created on: 2024-03-18 22:34:52
Modified on: 2024-04-09 14:29:03
Date last run: 2024-04-28 22:09:11

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblio_metadata.biblionumber AS BIBS,
  ExtractValue(biblio_metadata.metadata, '//leader') AS 'LDR',
  ExtractValue(biblio_metadata.metadata, '//controlfield[@tag=001]') AS '001 - Control Number',
  ExtractValue(biblio_metadata.metadata, '//controlfield[@tag=003]') AS '003 - Control Number Identifier',
  ExtractValue(biblio_metadata.metadata, '//controlfield[@tag=005]') AS '005 - Date and Time of Latest Transaction',
  ExtractValue(biblio_metadata.metadata, '//controlfield[@tag=006]') AS '006 - Fixed-Length Data Elements - Additional Material Characteristics',
  ExtractValue(biblio_metadata.metadata, '//controlfield[@tag=007]') AS '007 - Physical Description Fixed Field',
  ExtractValue(biblio_metadata.metadata, '//controlfield[@tag=008]') AS '008 - Fixed-Length Data Elements'
FROM
  biblio_metadata
WHERE
  biblio_metadata.biblionumber LIKE <<Enter biblionumber or a % symbol>>
GROUP BY
  biblio_metadata.biblionumber
ORDER BY
  BIBS

























