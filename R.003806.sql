/*
R.003806

----------

Name: Basic control fields
Created by: George Williams

----------

Group: -
     -

Created on: 2024-03-07 16:00:07
Modified on: 2024-03-07 16:00:19
Date last run: 2024-03-07 16:00:20

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblio_metadata.biblionumber AS BIBS,
  ExtractValue(biblio_metadata.metadata, '//leader') AS 'LDR',
  ExtractValue(biblio_metadata.metadata, '//controlfield[@tag=001]') AS '001',
  ExtractValue(biblio_metadata.metadata, '//controlfield[@tag=003]') AS '003',
  ExtractValue(biblio_metadata.metadata, '//controlfield[@tag=005]') AS '005',
  ExtractValue(biblio_metadata.metadata, '//controlfield[@tag=006]') AS '006',
  ExtractValue(biblio_metadata.metadata, '//controlfield[@tag=007]') AS '007',
  ExtractValue(biblio_metadata.metadata, '//controlfield[@tag=008]') AS '008',
  biblio_metadata.metadata
FROM
  biblio_metadata
GROUP BY
  biblio_metadata.biblionumber
ORDER BY
  BIBS

























