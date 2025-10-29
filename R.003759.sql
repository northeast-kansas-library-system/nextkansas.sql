/*
R.003759

----------

Name: To-do dashboard
Created by: George Williams

----------

Group: -
     -

Created on: 2023-09-12 09:41:43
Modified on: 2025-03-09 19:17:38
Date last run: 2025-10-28 20:05:18

----------

Public: 0
Expiry: 5

----------



----------
*/



SELECT
  CONCAT_WS('', 
    IF(
      COALESCE(request_queue_count.REQUEST_COUNT, 0) = 0,
      Concat_WS('',
        '',
        '', 
        'Holds queue is empty',
        '',
        ''
      ),
      Concat_WS('',
        '',
        '',
        'Holds queue',
        ' ',
        ' Holds queue ',
        '(',
        COALESCE(request_queue_count.REQUEST_COUNT, 0),
        ' items)',
        ''
      )
    ),
    IF(
      COALESCE(missing_in_transit.MIT_COUNT, 0) = 0, 
      Concat_WS('',
        '',
        '',
        'No missing in transit items',
        '',
        ''
      ),
      Concat_WS('',
        '',
        '',
        'Missing in transit',
        ' ',
        ' Missing in transit ',
        '(',
        COALESCE(missing_in_transit.MIT_COUNT, 0),
        ' items)',
        ''
      )
    ),
    IF(
      COALESCE(request_cancellations.HOLD_CNX_COUNT, 0) = 0,
      '',
      Concat_WS('', 
        '',
        '',
        'Cancelled requests needing action',
        ' ',
        ' Cancelled requests ',
        '(',
        COALESCE(request_cancellations.HOLD_CNX_COUNT, 0),
        ' requests)',
        ''
      )
    )
  ) AS HOLDS_MITS_REQCNX
FROM
  branches LEFT JOIN
  (
    SELECT
      hold_fill_targets.source_branchcode,
      Count(DISTINCT hold_fill_targets.itemnumber) AS REQUEST_COUNT
    FROM
      hold_fill_targets
    GROUP BY
      hold_fill_targets.source_branchcode
  ) request_queue_count 
    ON request_queue_count.source_branchcode = branches.branchcode LEFT JOIN
  (
    SELECT
      reserves.branchcode,
      Count(DISTINCT hold_cancellation_requests.hold_cancellation_request_id) AS
      HOLD_CNX_COUNT
    FROM
      hold_cancellation_requests JOIN
      reserves ON hold_cancellation_requests.hold_id = reserves.reserve_id
    GROUP BY
      reserves.branchcode
  ) request_cancellations 
    ON request_cancellations.branchcode = branches.branchcode,
  (
    SELECT
      Count(DISTINCT branchtransfers.itemnumber) AS MIT_COUNT
    FROM
      branchtransfers JOIN
      items ON branchtransfers.itemnumber = items.itemnumber
    WHERE
      (
        (
          branchtransfers.datearrived IS NULL 
            OR
          branchtransfers.datearrived = ''
        ) 
          AND
        (
          branchtransfers.datecancelled IS NULL 
            OR
          branchtransfers.datecancelled = ''
        ) 
          AND
        branchtransfers.datesent &lt; CurDate() - INTERVAL 7 DAY 
          AND
        branchtransfers.tobranch = &lt;&gt;
      ) 
        OR
      (
        (
          branchtransfers.datearrived IS NULL 
            OR
          branchtransfers.datearrived = ''
        )  
          AND
        (
          branchtransfers.datecancelled IS NULL 
            OR
          branchtransfers.datecancelled = ''
        ) 
          AND
        branchtransfers.datesent &lt; CurDate() - INTERVAL 7 DAY 
          AND
        branchtransfers.frombranch = &lt;&gt;
      ) 
        OR
      (
        (
          branchtransfers.datearrived IS NULL 
            OR
          branchtransfers.datearrived = ''
        ) 
          AND
        (
          branchtransfers.datecancelled IS NULL 
            OR
          branchtransfers.datecancelled = ''
        ) 
          AND
        branchtransfers.datesent &lt; CurDate() - INTERVAL 7 DAY 
          AND
        items.homebranch = &lt;&gt;
      )
  ) missing_in_transit
WHERE
  branches.branchcode = &lt;&gt;

























