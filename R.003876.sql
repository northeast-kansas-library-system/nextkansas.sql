/*
R.003876

----------

Name: GHW - Bibliographic records with indicator problems
Created by: George Williams

----------

Group: -
     -

Created on: 2025-01-28 11:00:28
Modified on: 2025-01-28 11:02:15
Date last run: 2025-07-22 14:02:33

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat( 
    'Edit record' 
  ) AS EDIT_RECORD, 
  biblio.title,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/@ind2') AS
  marcxml
FROM
  biblio JOIN
  biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
WHERE
  biblio.title REGEXP '^[^A-z0-9]'
ORDER BY
  biblio.title

























