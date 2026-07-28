/*
R.003962

----------

Name: Sample report for #koha-us_video
Created by: George Williams

----------

Group: -
     -

Created on: 2026-06-04 15:16:47
Modified on: 2026-06-04 15:27:27
Date last run: 2026-06-04 15:27:27

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
  biblio.datecreated /* This is a "date" field */,
  biblio.timestamp /* This is a "timestamp" field */
FROM
  biblio
WHERE
  biblio.datecreated BETWEEN '2026-05-31' AND '2026-06-04'
LIMIT 10000

























