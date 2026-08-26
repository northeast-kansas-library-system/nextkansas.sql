/*
R.003420

----------

Name: 0009 - 2024_99_a_cy monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2021-02-04 17:10:37
Modified on: 2026-01-30 17:26:11
Date last run: 2026-08-12 14:55:39

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

    <p id="report_id"><strong>Report number:</strong> 3420</p>

    <p id="report_name"><strong>Report name:</strong> 0015 - 2024_99_a_cy monthly_statistics </p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Generates part of the monthly overview spreadsheet</p>

  </div>

  <div class="accordion accordion-flush">

    <!-- Function section -->
    <div id="accordion_3420-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3420Open-headingOne">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3420Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3420Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3420Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3420Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Gathers borrower account statistics for the monthly overview report</p>
            <ul style="list-style-type:none">

              <li><strong>TIME FRAME:</strong> gathers data for the previous calendar month</li>

              <li><strong>AT:</strong> all next search catalog libraries</li>

              <li><strong>GROUPED BY:</strong> library name</li>

              <li><strong>SORTED BY:</strong> library name</li>

              <span style="display: none;">
                <li><strong>CONTAINS LINKS:</strong> </li>
              </span>
            </ul>


            <p>These counts are current at the time the report is run (which for Next Search Catalog is usually between
              12:01 a.m. and 4:00 a.m. on the first day of the month).</p>
            <p>Runs in 00:00:20 // tested 2026-01-30</p>

          </div>

        </div>
      </div>

    </div>

    <!-- Notes section -->
    <div id="accordion_3420-2" class="accordion-item next_report_notes ">

      <h2 class="accordion-header" id="panelsStay_3420Open-headingTwo">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3420Open-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_3420Open-collapseTwo">

          Notes:

        </button>

      </h2>

      <div id="panelsStay_3420Open-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3420Open-headingTwo">
        <div class="accordion-body">

          <div id="notes_1" class="report_section">
            <h4>Column header definitions</h4>
            <ul>
              <li>BORROWER_ACCT_USED_LM = number of borrower accounts used to check out materials last month</li>
              <li>TOTAL_BORROWERS = number of total borrowers with this home library</li>
              <li>B_ADDED_LM = number of borrowers with this home library added last month</li>
              <li>B_RENEWED_LM = number of borrowers with this home library renewed last month</li>
              <li>B_DELETED_LM = number of borrowers with this home library deleted last month</li>
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
      <p><a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=3420"
          class="direct_download_btn">Download directly to a CSV file</a></p>
    </div>

    <!-- Hashtag section -->
    <div class="next_report_hashtags" style="display: none;">
      <p>#monthly</p>
      <p>#statistics</p>
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
  'branchname' AS branchname,
  'BORROWER_ACCT_USED_LM' AS BORROWER_ACCT_USED_LM,
  'TOTAL_BORROWERS' AS TOTAL_BORROWERS,
  'B_ADDED_LM' AS B_ADDED_LM,
  'B_RENEWED_LM' AS B_RENEWED_LM,
  'B_DELETED_LM' AS B_DELETED_LM
UNION 
(SELECT 
  branches.branchname, 
  Coalesce(ACCT_USED.count, 0) AS BORROWER_ACCT_USED_LM, 
  Coalesce(BORROWERS1.COUNT, 0) AS TOTAL_BORROWERS, 
  Coalesce(BORROWERSA.COUNT, 0) AS B_ADDED_LM, 
  Coalesce(BORROWERSR.COUNT, 0) AS B_RENEWED_LM, 
  Coalesce(BORROWESD.COUNT, 0) AS B_DELETED_LM 
FROM 
  branches LEFT JOIN 
    (SELECT 
      borrowers.branchcode, 
      Count(*) AS COUNT 
    FROM 
      borrowers 
    WHERE 
      borrowers.dateenrolled < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
    GROUP BY 
      borrowers.branchcode 
    ) BORROWERS1 
  ON branches.branchcode = BORROWERS1.branchcode LEFT JOIN 
    (SELECT 
      borrowers.branchcode, 
      Count(*) AS COUNT 
    FROM 
      borrowers 
    WHERE 
      Month(borrowers.dateenrolled) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(borrowers.dateenrolled) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      borrowers.branchcode 
    ) BORROWERSA 
  ON branches.branchcode = BORROWERSA.branchcode LEFT JOIN 
    (SELECT 
      deletedborrowers.branchcode, 
      Count(*) AS COUNT 
    FROM 
      action_logs JOIN 
      deletedborrowers ON deletedborrowers.borrowernumber = action_logs.object 
    WHERE 
      action_logs.module = 'MEMBERS' AND 
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND 
      action_logs.action LIKE 'DELET%' 
    GROUP BY 
      deletedborrowers.branchcode 
    ) BORROWESD 
  ON branches.branchcode = BORROWESD.branchcode LEFT JOIN 
    (SELECT 
      borrowers.branchcode, 
      Count(*) AS COUNT 
    FROM 
      borrowers 
    WHERE 
      Month(borrowers.date_renewed) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(borrowers.date_renewed) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      borrowers.branchcode 
    ) BORROWERSR 
  ON branches.branchcode = BORROWERSR.branchcode LEFT JOIN 
    (SELECT 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS count 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
        statistics.type = 'renew' OR 
        statistics.type = 'localuse') AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      statistics.branch 
    ) ACCT_USED 
  ON ACCT_USED.branch = branches.branchcode 
GROUP BY 
  branches.branchname 
ORDER BY 
  branches.branchname)

























