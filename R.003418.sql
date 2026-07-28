/*
R.003418

----------

Name: 0003 - 2024_99_a_cy monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2021-02-04 16:34:33
Modified on: 2026-01-30 17:26:18
Date last run: 2026-07-08 11:48:33

----------

Public: 0
Expiry: 300

----------

<div class="next_report_info next_noprint">

  <style>
    .report_hidden {
      display: none
    }

    .accordion .accordion-button {
      font-size: 1.1em !important;
      color: #fff !important;
      font-weight: 900
    }

    .next_report_function .accordion-header * {
      background-color: #df6320 !important;
      color: #fff !important
    }

    .next_report_notes .accordion-header * {
      background-color: #dfc220 !important;
      color: #000 !important
    }

    .next_report_instructions .accordion-header * {
      background-color: #3ddf20 !important;
      color: #000 !important
    }

    .next_report_resources .accordion-header * {
      background-color: #1f9bde !important;
      color: #fff !important
    }

    .next_report_training .accordion-header * {
      background-color: #6320df !important;
      color: #fff !important
    }

    .accordion-collapse.collapse * {
      background-color: #e6e6e6;
      color: #000
    }

    .accordion-body h3 {
      font-size: 1.5em !important
    }

    .report_section {
      border: 2px solid #000;
      border-radius: 8px;
      margin: 10px;
      padding: 15px
    }

    .resources_btn,
    .training_btn,
    .direct_download_btn {
      padding: 10px;
      margin: 10px 0 0;
      display: inline-block;
      font-weight: 650;
      line-height: 1.5;
      text-align: center;
      vertical-align: middle;
      white-space: nowrap;
      color: #000
    }

    .resources_btn {
      border: 1px solid #555;
      border-radius: 4px;
      background: #dfc220 !important
    }

    .training_btn {
      border: 1px solid #555;
      border-radius: 4px;
      background: #3ddf20 !important
    }

    .direct_download_btn {
      color: #fff;
      border: 1px solid #555;
      border-radius: 4px;
      background: indigo !important
    }

    .direct_download_btn:hover {
      color: #000000 !important;
      background: #D396FF !important;
    }
  </style>

  <!-- Overview -->

  <div class="next_report_summary">
    <br>

    <p id="report_id"><strong>Report number:</strong> 3418</p>

    <p id="report_name"><strong>Report name:</strong> 0005 - 2024_99_a_cy monthly_statistics</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Generates part of the monthly overview spreadsheet</p>

  </div>

  <div class="accordion accordion-flush">

    <!-- Function section -->
    <div id="accordion_3418-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3418Open-headingOne">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3418Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3418Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3418Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3418Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Gathers item and holding counts</p>
            <ul style="list-style-type:none">

              <li><strong>TIME FRAME:</strong> gathers data for the previous calendar month </li>

              <li><strong>AT:</strong> all next search catalog libraries</li>

              <li><strong>GROUPED BY:</strong> library name</li>

              <li><strong>SORTED BY:</strong> library name</li>

              <span style="display: none;">
                <li><strong>CONTAINS LINKS:</strong> </li>
              </span>
            </ul>


            <span>
              <p>Runs in 00:00:26 // tested 2026-01-30</p>
            </span>

          </div>

        </div>
      </div>

    </div>

    <!-- Notes section -->
    <div id="accordion_3418-2" class="accordion-item next_report_notes ">

      <h2 class="accordion-header" id="panelsStay_3418Open-headingTwo">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3418Open-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_3418Open-collapseTwo">

          Notes:

        </button>

      </h2>

      <div id="panelsStay_3418Open-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3418Open-headingTwo">
        <div class="accordion-body">

          <div id="notes_1" class="report_section">
            <h4>Column header definitions</h4>
            <ul>
              <li>START_I = number of items owned on the first of the month</li>
              <li>END_I = number of items owned on the last day of the month</li>
              <li>ITEMS_ADD_L_M = items added last month</li>
              <li>ITEMS_DEL_L_M = items deleted last month</li>
              <li>TOTAL_HOLDINGS = number of bibliographic records where at least 1 item was held at this library on the
                first of the month</li>
            </ul>
          </div>

          <div id="notes_2" class="report_section">
            <h4>Header row</h4>
            <p>The header row is duplicated to make it easier to schedule the report with the built-in report scheduling tool.</p>
          </div>

          <div id="notes_3" class="report_section report_hidden">
            <h4> NOTE_THREE_TITLE </h4>
            <p> NOTE_THREE_CONTENT </p>
          </div>

          <div id="notes_4" class="report_section report_hidden">
            <h4> NOTE_FOUR_TITLE </h4>
            <p> NOTE_FOUR_CONTENT </p>
          </div>

          <div id="notes_5" class="report_section report_hidden">
            <h4> NOTE_FIVE_TITLE </h4>
            <p> NOTE_FIVE_CONTENT </p>
          </div>

        </div>
      </div>

    </div>

    <!-- Direct download section -->
    <div class="next_report_direct_download ">
      <p><a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=3418"
          class="direct_download_btn">Download directly to a CSV file</a></p>
    </div>

    <!-- Hashtag section -->
    <div class="next_report_hashtags" style="display: none;">
      <p>#statistics</p>
      <p>#monthly_statistics</p>
      <p>#overview</p>
      <p>#monthly_overview</p>
      <p>#</p>
      <p>#</p>
      <p>#</p>
      <p>#</p>
      <p>#</p>
      <p>#</p>
    </div>

  </div>

----------
*/



SELECT 
  'BRANCH' AS BRANCH, 
  'START_I' AS START_I, 
  'END_I' AS END_I, 
  'ITEMS_ADD_L_M' AS ITEMS_ADD_L_M, 
  'ITEMS_DEL_L_M' AS ITEMS_DEL_L_M, 
  'TOTAL_HOLDINGS' AS TOTAL_HOLDINGS 
UNION 
SELECT 
  branches.branchname AS BRANCH, 
  Coalesce(Sum(DISTINCT START_ITEMS.count), 0) AS START_I, 
  Coalesce(Sum(DISTINCT END_ITEMS.count), 0) AS END_I, 
  Coalesce(Sum(DISTINCT ITEMS_ADDED.count), 0) AS ITEMS_ADD_L_M, 
  Coalesce(ITEMS_DELETED.count, 0) AS ITEMS_DEL_L_M, 
  Coalesce(Sum(DISTINCT TOTAL_HOLDINGS.count), 0) AS TOTAL_HOLDINGS 
FROM branches 
  LEFT JOIN ( 
    SELECT 
      items.homebranch, 
      Count(*) AS count 
    FROM items 
    WHERE items.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) 
    GROUP BY items.homebranch 
    UNION 
    SELECT 
      deleteditems.homebranch, 
      Count(*) AS count 
    FROM deleteditems 
    WHERE deleteditems.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) 
      AND deleteditems.timestamp >= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) 
    GROUP BY deleteditems.homebranch 
  ) START_ITEMS ON branches.branchcode = START_ITEMS.homebranch 
  LEFT JOIN ( 
    SELECT 
      items.homebranch, 
      Count(*) AS count 
    FROM items 
    WHERE items.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
    GROUP BY items.homebranch 
    UNION 
    SELECT 
      deleteditems.homebranch, 
      Count(*) AS count 
    FROM deleteditems 
    WHERE deleteditems.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
      AND deleteditems.timestamp >= AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
    GROUP BY deleteditems.homebranch 
  ) END_ITEMS ON branches.branchcode = END_ITEMS.homebranch 
  LEFT JOIN ( 
    SELECT 
      items.homebranch, 
      Count(*) AS count 
    FROM items 
    WHERE Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) 
      AND Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY items.homebranch 
    UNION 
    SELECT 
      deleteditems.homebranch, 
      Count(*) AS count 
    FROM deleteditems 
    WHERE Month(deleteditems.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) 
      AND Year(deleteditems.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY deleteditems.homebranch 
  ) ITEMS_ADDED ON branches.branchcode = ITEMS_ADDED.homebranch 
  LEFT JOIN ( 
    SELECT 
      deleteditems.homebranch, 
      Count(*) AS count 
    FROM deleteditems 
    WHERE Month(deleteditems.timestamp) = Month(Now() - INTERVAL 1 MONTH) 
      AND Year(deleteditems.timestamp) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY deleteditems.homebranch 
  ) ITEMS_DELETED ON branches.branchcode = ITEMS_DELETED.homebranch 
  LEFT JOIN ( 
    SELECT items.homebranch, 
      Count(DISTINCT items.biblionumber) AS count 
    FROM items 
    WHERE items.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
    GROUP BY items.homebranch 
    UNION 
    SELECT 
      deleteditems.homebranch, 
      Count(DISTINCT deleteditems.biblionumber) AS count 
    FROM deleteditems 
    WHERE deleteditems.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
      AND deleteditems.timestamp >= AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
    GROUP BY deleteditems.homebranch 
  ) TOTAL_HOLDINGS ON branches.branchcode = TOTAL_HOLDINGS.homebranch 
GROUP BY branches.branchname 
ORDER BY IF (BRANCH = 'BRANCH', ' AAAAA', BRANCH) 
LIMIT 100 

























