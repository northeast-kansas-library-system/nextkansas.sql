/*
R.002933

----------

Name: GHW - SMS notices
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2017-04-29 18:17:44
Modified on: 2017-04-29 18:17:44
Date last run: 2022-08-18 11:36:33

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  letter.module,
  letter.code,
  letter.branchcode,
  letter.name,
  letter.is_html,
  letter.title,
  letter.content,
  letter.message_transport_type
FROM
  letter
WHERE
  letter.message_transport_type = 'SMS'
ORDER BY
  letter.branchcode,
  letter.code

























