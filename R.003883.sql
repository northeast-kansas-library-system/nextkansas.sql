/*
R.003883

----------

Name: GHW - Suppressed records badge on edit items page
Created by: George Williams

----------

Group: -
     -

Created on: 2025-04-25 12:02:27
Modified on: 2025-04-25 12:04:30
Date last run: 2025-04-25 12:04:35

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblio_metadata.biblionumber,
  If(
    ExtractValue(
      biblio_metadata.metadata,'//datafield[@tag="942"]/subfield[@code="n"]'
    ) = '1',
    'This title is not visible to patrons in Aspen Discovery', 
    ''
  ) AS SUPPRESSED
FROM
  biblio_metadata
WHERE
  biblio_metadata.biblionumber = &lt;&gt;
ORDER BY
  biblio_metadata.biblionumber DESC

























