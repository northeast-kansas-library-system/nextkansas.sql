/*
R.003859

----------

Name: GHW - test for MATTERMOST
Created by: George Williams

----------

Group: -
     -

Created on: 2024-09-11 12:46:36
Modified on: 2024-09-11 12:47:14
Date last run: 2024-09-11 12:48:00

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  branches.branchname,
  returns_lm.DATE,
  returns_lm.DAY,
  returns_lm.RETURN_COUNT,
  localuse_lm.LOCAL_USE_COUNT,
  Count(held_lm.reserve_id) AS HOLD_COUNT,
  transfered_lm.Count_branchtransfer_id AS TRANSFER_COUNT,
  (
    Coalesce(returns_lm.RETURN_COUNT, 0) + 
    Coalesce(localuse_lm.LOCAL_USE_COUNT, 0) - 
    Coalesce(Count(held_lm.reserve_id), 0) - 
    Coalesce(transfered_lm.Count_branchtransfer_id, 0)
  ) AS THINGS_NEEDED_TO_BE_SHELVED
FROM
  branches LEFT JOIN
    (
      SELECT
        statistics.branch,
        Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE,
        Date_Format(statistics.datetime, '%W') AS DAY,
        count(*) AS RETURN_COUNT
      FROM
        statistics
      WHERE
        statistics.type = 'return' AND
        Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
        Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
      GROUP BY
        statistics.branch,
        Date_Format(statistics.datetime, '%Y-%M-%D')
    ) returns_lm 
    ON returns_lm.branch = branches.branchcode 
  LEFT JOIN
    (
      SELECT
        statistics.branch,
        Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE,
        Date_Format(statistics.datetime, '%W') AS DAY,
        count(*) AS LOCAL_USE_COUNT
      FROM
        statistics
      WHERE
        statistics.type = 'localuse' AND
        Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
        Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
      GROUP BY
        statistics.branch,
        Date_Format(statistics.datetime, '%Y-%M-%D')
    ) localuse_lm 
    ON localuse_lm.branch = branches.branchcode 
    AND localuse_lm.DATE = returns_lm.DATE 
  LEFT JOIN
    (
      SELECT
        reserves.branchcode,
        Date_Format(reserves.waitingdate, '%Y-%m-%d') AS DATE,
        reserves.reserve_id,
        Year(reserves.waitingdate) AS waitingdate,
        Month(reserves.waitingdate) AS waitingdate1
      FROM
        reserves
      WHERE
        Year(reserves.waitingdate) = Year(Now() - INTERVAL 1 MONTH) AND
        Month(reserves.waitingdate) = Month(Now() - INTERVAL 1 MONTH)
      UNION
      SELECT
        old_reserves.branchcode,
        Date_Format(old_reserves.waitingdate, '%Y-%m-%d') AS DATE,
        old_reserves.reserve_id,
        Year(old_reserves.waitingdate) AS waitingdate,
        Month(old_reserves.waitingdate) AS waitingdate1
      FROM
        old_reserves
      WHERE
        Year(old_reserves.waitingdate) = Year(Now() - INTERVAL 1 MONTH) AND
        Month(old_reserves.waitingdate) = Month(Now() - INTERVAL 1 MONTH)
    ) held_lm
    ON held_lm.branchcode = branches.branchcode 
    AND held_lm.DATE = returns_lm.DATE 
  LEFT JOIN
    (
      SELECT
        branchtransfers.frombranch,
        Date_Format(branchtransfers.datesent, '%Y-%m-%d') AS DATE,
        Count(DISTINCT branchtransfers.branchtransfer_id) AS
        Count_branchtransfer_id
      FROM
        branchtransfers
      WHERE
        Year(branchtransfers.datesent) = Year(Now() - INTERVAL 1 MONTH) AND
        Month(branchtransfers.datesent) = Month(Now() - INTERVAL 1 MONTH)
      GROUP BY
        branchtransfers.frombranch,
        Date_Format(branchtransfers.datesent, '%Y-%m-%d')
    ) transfered_lm 
    ON transfered_lm.frombranch = branches.branchcode 
    AND transfered_lm.DATE = returns_lm.DATE
WHERE
  branches.branchcode LIKE <>
GROUP BY
  branches.branchname,
  returns_lm.DATE,
  returns_lm.DAY,
  returns_lm.RETURN_COUNT,
  localuse_lm.LOCAL_USE_COUNT,
  transfered_lm.Count_branchtransfer_id

























