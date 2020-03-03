/*
R.003295

----------

Name: GHW - Request filled last month - by collection code
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-01-03 15:26:45
Modified on: 2020-01-03 15:27:25
Date last run: 2020-01-26 17:26:33

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  branchandcodes.branchcode,
  branchandcodes.lib AS CCODE,
  Count(requestdata_all.reserve_id) AS REQUESTS_FILLED_LM
FROM
  (
    SELECT
      branches.branchcode,
      ccodes.lib,
      ccodes.authorised_value
    FROM
      branches,
      (
        SELECT
          authorised_values.category,
          authorised_values.authorised_value,
          authorised_values.lib
        FROM
          authorised_values
        WHERE
          authorised_values.category = 'ccode'
      ) ccodes
    ORDER BY
      branches.branchcode,
      ccodes.lib
  ) branchandcodes
  LEFT JOIN (
    SELECT
      requests_filled.branchcode,
      requests_filled.reserve_id,
      requests_filled.itemnumber,
      Coalesce(items.ccode, deleteditems.ccode, "XXX") AS ccode
    FROM
      (
        SELECT
          old_reserves.branchcode,
          old_reserves.reserve_id,
          Coalesce(old_reserves.itemnumber, deleted_itemnumbers.itemnumber) AS itemnumber
        FROM
          old_reserves
          LEFT JOIN (
            SELECT
              action_logs.object AS reserve_id,
              SubString_Index(SubString_Index(action_logs.info, "itemnumber' => '", -1), "'", 1) AS itemnumber
            FROM
              action_logs
            WHERE
              action_logs.module = 'HOLDS' AND
              action_logs.info LIKE "%itemnumber' => '%" AND
              action_logs.action LIKE 'DEL%' AND
              Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND
              Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH)
            GROUP BY
              action_logs.action_id
          ) deleted_itemnumbers
            ON deleted_itemnumbers.reserve_id = old_reserves.reserve_id
          JOIN action_logs
            ON action_logs.object = old_reserves.reserve_id
        WHERE
          Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND
          Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND
          old_reserves.found = 'F' AND
          action_logs.module = 'HOLDS' AND
          action_logs.action LIKE "DEL%"
        GROUP BY
          old_reserves.branchcode,
          old_reserves.reserve_id,
          Coalesce(old_reserves.itemnumber, deleted_itemnumbers.itemnumber)
      ) requests_filled
      LEFT JOIN items
        ON items.itemnumber = requests_filled.itemnumber
      LEFT JOIN deleteditems
        ON deleteditems.itemnumber = requests_filled.itemnumber
    GROUP BY
      requests_filled.branchcode,
      requests_filled.reserve_id,
      requests_filled.itemnumber
  ) requestdata_all
    ON requestdata_all.ccode = branchandcodes.authorised_value AND
      requestdata_all.branchcode = branchandcodes.branchcode
WHERE
  branchandcodes.branchcode LIKE <<Choose your library|branches>>
GROUP BY
  branchandcodes.branchcode,
  branchandcodes.lib



