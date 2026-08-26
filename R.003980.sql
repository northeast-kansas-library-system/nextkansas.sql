/*
R.003980

----------

Name: GHW - Biblio action logs for catalog modifications
Created by: George Williams

----------

Group: -
     -

Created on: 2026-08-13 16:05:35
Modified on: 2026-08-13 23:21:07
Date last run: 2026-08-13 23:10:32

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  action_logs.timestamp,
  action_logs.object,
  REGEXP_REPLACE(
    REGEXP_REPLACE(
        REPLACE(action_logs.info, '\n', '<br>'),
        '([0-9]{3} )',
        '<br>\\1'
    ),
    '(_[a-z])',
    '\\1 '
) AS INFO
FROM
  action_logs
WHERE
  action_logs.action = 'MODIFY' AND
  action_logs.object = <<Bib>> AND
  action_logs.module = 'CATALOGUING'
GROUP BY
  action_logs.action_id
ORDER BY
  action_logs.timestamp DESC

























