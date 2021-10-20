/*
R.002934

----------

Name: GHW -  SMS Counts
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2017-04-29 19:22:08
Modified on: 2017-04-29 19:22:08
Date last run: 2018-10-07 15:47:23

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  letter.message_transport_type,
  letter.code,
  letter.title,
  letter.content,
  Count(letter.branchcode) AS Count_branchcode
FROM
  letter
WHERE
  letter.message_transport_type = 'SMS'
GROUP BY
  letter.message_transport_type,
  letter.code,
  letter.title,
  letter.content

























