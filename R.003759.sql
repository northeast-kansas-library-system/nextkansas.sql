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
Date last run: 2026-03-05 16:46:33

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
        '<div ',
          'id="holds_queue_clear" ',
          'class="page-section" ',
          'style="text-align: center; background-color: #f3f4f4',
        '">',
        '<h3 class="next_label next_green">', 
        'Holds queue is empty',
        '</h3>',
        '</div>'
      ),
      Concat_WS('',
        '<div id="holds_queue_action" class="row justify-content-md-center" style="background-color: #f3f4f4 !important">',
        '<h4 style="background-color: #1f9bde; border-radius: 6px; padding: 1em; text-align: center; ">',
        'Holds queue</h4>',
        '<a class="next_btn next_light next_embiggen2 noprint" ',
        'style="width: 75%; background-color: #d7ebff;"',
        'href="/cgi-bin/koha/reports/guided_reports.pl?op=run&id=3084&sql_params=',
        branches.branchcode,
        '&param_name=Choose+your+library%7CZBRAN&limit=1000" ',
        'target="_blank"> ',
        '<i class="fa fa-tasks"></i> Holds queue <br />',
        '<span style="font-weight: bold;">(',
        COALESCE(request_queue_count.REQUEST_COUNT, 0),
        '</span> items)</a>',
        '</div>'
      )
    ),
    IF(
      COALESCE(missing_in_transit.MIT_COUNT, 0) = 0, 
      Concat_WS('',
        '<div ',
          'id="holds_queue_clear" ',
          'class="page-section" ',
          'style="text-align: center; background-color: #f3f4f4',
        '">',
        '<h3 class="next_label next_green">',
        'No missing in transit items',
        '</h3>',
        '</div>'
      ),
      Concat_WS('',
        '<div id="missing_in_transit_action" class="row justify-content-md-center" style="background-color: #f3f4f4">',
        '<h4 style="background-color: #1f9bde; border-radius: 6px; padding: 1em; text-align: center; ">',
        'Missing in transit</h4>',
        '<a class="next_btn next_light next_embiggen2 noprint" ',
        'style="width: 75%;" ',
        'href="/cgi-bin/koha/reports/guided_reports.pl?op=run&id=3658',
        '&sql_params=1',
        '&sql_params=',
        branches.branchcode,
        '&param_name=Sort+by|XS_BRANCH',
        '&param_name=Choose+your+library|branches',
        '&limit=1000" ',
        'target="_blank"> ',
        '<i class="fa fa-tasks"></i> Missing in transit <br />',
        '<span style="font-weight: bold;">(',
        COALESCE(missing_in_transit.MIT_COUNT, 0),
        '</span> items)</a>',
        '</div>'
      )
    ),
    IF(
      COALESCE(request_cancellations.HOLD_CNX_COUNT, 0) = 0,
      '',
      Concat_WS('', 
        '<div id="cnx_requests_action" class="row justify-content-md-center">',
        '<h4 style="background-color: #1f9bde; border-radius: 6px; padding: 1em; text-align: center; ">',
        'Cancelled requests needing action</h4>',
        '<a class="next_btn next_light next_embiggen2 noprint" ',
        'style="width: 75%;" ',
        'href="/cgi-bin/koha/circ/waitingreserves.pl#holdscancelled_panel" ',
        'target="_blank"> ',
        '<i class="fa fa-tasks"></i> Cancelled requests <br />',
        '<span style="font-weight: bold;">(',
        COALESCE(request_cancellations.HOLD_CNX_COUNT, 0),
        '</span> requests)</a>',
        '</div>'
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
        branchtransfers.datesent < CurDate() - INTERVAL 7 DAY 
          AND
        branchtransfers.tobranch = <<branchcode 1>>
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
        branchtransfers.datesent < CurDate() - INTERVAL 7 DAY 
          AND
        branchtransfers.frombranch = <<branchcode 2>>
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
        branchtransfers.datesent < CurDate() - INTERVAL 7 DAY 
          AND
        items.homebranch = <<branchcode 3>>
      )
  ) missing_in_transit
WHERE
  branches.branchcode = <<branchcode 4>>

























