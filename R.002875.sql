/*
R.002875

----------

Name: GHW - message queue test
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2017-01-04 17:18:08
Modified on: 2017-01-17 22:17:12
Date last run: 2020-10-14 13:50:45

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  *
FROM
  message_queue
ORDER BY
  message_id
  DESC
LIMIT 100



