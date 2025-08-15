/*
R.003606

----------

Name: GHW - Unique notices
Created by: George Williams

----------

Group: -
     -

Created on: 2021-11-04 01:02:08
Modified on: 2023-12-27 10:03:50
Date last run: 2023-12-27 10:03:59

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  letter.code,
  letter.message_transport_type,
  letter.is_html,
  REPLACE(letter.content, "&lt;", "&lt;")  AS CONTENT, 
  GROUP_CONCAT(
    DISTINCT 
    If(letter.branchcode = "", "All libraries", letter.branchcode) 
    ORDER BY If(letter.branchcode = "", "All libraries", letter.branchcode) 
    SEPARATOR " | "
  ) AS BRANCHES
FROM
  letter
WHERE
  letter.message_transport_type = "email" AND 
  letter.code LIKE "%"
GROUP BY
  letter.code,
  letter.message_transport_type,
  letter.content,
  letter.is_html,
  Hex(letter.content)

























