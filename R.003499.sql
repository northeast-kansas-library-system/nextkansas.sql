/*
R.003499

----------

Name: 0020 - 2024_99_b_circulation_hourly monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2021-04-30 15:05:03
Modified on: 2026-01-30 17:26:02
Date last run: 2026-04-01 00:20:02

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

    <p id="report_id"><strong>Report number:</strong> 3499</p>

    <p id="report_name"><strong>Report name:</strong> 0030 - 2024_99_b_circulation_hourly monthly_statistics</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Generates data for monthly statistics</p>

  </div>

  <div class="accordion accordion-flush">

    <!-- Function section -->
    <div id="accordion_3499-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3499Open-headingOne">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3499Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3499Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3499Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3499Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Counts checkouts, renewals, and returns for each hour of each day</p>
            <ul style="list-style-type:none">

              <li><strong>TIME FRAME:</strong> gathers data for the previous calendar month</li>

              <li><strong>AT:</strong> all next search catalog libraries</li>

              <li><strong>GROUPED BY:</strong> library name, date, day, and hour of the day</li>

              <li><strong>SORTED BY:</strong> library name, date, day, and hour of the day</li>

              <span style="display: none;">
                <li><strong>CONTAINS LINKS:</strong> </li>
              </span>
            </ul>


            <span style="display: none;">
              <p> - </p>
            </span>

          </div>

        </div>
      </div>

    </div>

    <!-- Notes section -->
    <div id="accordion_3499-2" class="accordion-item next_report_notes ">

      <h2 class="accordion-header" id="panelsStay_3499Open-headingTwo">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3499Open-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_3499Open-collapseTwo">

          Notes:

        </button>

      </h2>

      <div id="panelsStay_3499Open-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3499Open-headingTwo">
        <div class="accordion-body">

          <div id="notes_1" class="report_section">
            <h4>Column header definitions</h4>
            <p>
            <ul><br>
              <li>CKO = number of items newly checked out</li>
              <li>RENEW = number of items renewed</li>
              <li>RETURNS = number of items checked in</li>
              <li>TOTAL_CKO_RENEW_RETURN = sum of the previous 3 columns</li>
              <li>CKO_BORROWERS = number of unique accounts used to check out the items in the CKO column</li>
              <li>RENEW_BORROWERS = number of unique accounts used to renew the items in the RENEW column</li>
              <li>CKO_AND_RENEW_BORROWERS = number of unique accounts used to check out and renew items</li>
            </ul>
            </p>
          </div>

          <div id="notes_2" class="report_section">
            <h4>Renewals</h4>
            <p>OPAC and Aspen renewals are counted as occurring at the library where the item was originally checked
              out. This is why you may see data for days and times that your library is closed.</p>
          </div>

          <div id="notes_3" class="report_section">
            <h4>Header row</h4>
            <p>The header row is duplicated to make it easier to schedule the report with the built-in report scheduling tool.</p>
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
      <p><a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=3499"
          class="direct_download_btn">Download directly to a CSV file</a></p>
    </div>

    <!-- Hashtag section -->
    <div class="next_report_hashtags" style="display: none;">
      <p>#statistics</p>
      <p>#library</p>
      <p>#hourly</p>
      <p>#cirulation_by_library_details</p>
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



SELECT 'Library name' AS 'Library name',  
  'Date' AS 'Date',  
  'Day' AS 'Day',  
  'Hour' AS 'Hour',  
  'Checkouts' AS 'Checkouts',  
  'Renewals' AS 'Renewals',  
  'Returns' AS 'Returns',  
  'Checkouts + renewals + returns' AS 'Checkouts + renewals + returns',  
  'Check out borrower count' AS 'Check out borrower count',  
  'Renewal borrower count' AS 'Renewal borrower count',  
  'Check out + renewal borrower count' AS 'Check out + renewal borrower count'
UNION 
(SELECT 
  branchess.branchname AS "Library name", 
  ALL_STATS.DATE AS "Date", 
  ALL_STATS.DAY AS "Day", 
  Concat(ALL_STATS.HOUR_OF_DAY, ":00 - ", ALL_STATS.HOUR_OF_DAY, ":59") AS "Hour", 
  Coalesce(CKO.COUNT, 0) AS "Checkouts", 
  Coalesce(RENEWALS.COUNT, 0) AS "Renewals", 
  Coalesce(RETURNS.COUNT, 0) AS "Returns", 
  ALL_STATS.COUNT AS "Checkouts + renewals + returns", 
  Coalesce(ckoborrowers.Count_borrowernumber, 0) AS "Check out borrower count", 
  Coalesce(renewborrowers.Count_borrowernumber, 0) AS "Renewal borrower count", 
  totalborrowers.Count_borrowernumber AS "Check out + renewal borrower count" 
FROM 
  ( 
    SELECT 
     branches.branchcode, 
     branches.branchname 
   FROM 
     branches) branchess 
  LEFT JOIN 
  ( 
    SELECT 
     statistics.branch, 
     DayName(statistics.datetime) AS DAY, 
     Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE, 
     Hour(statistics.datetime) AS HOUR_OF_DAY, 
     count(*) AS COUNT 
   FROM 
     statistics 
   WHERE 
     (statistics.type = 'issue' OR 
         statistics.type = 'renew' OR 
         statistics.type = 'return') AND 
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
   GROUP BY 
     statistics.branch, 
     DayName(statistics.datetime), 
     Date_Format(statistics.datetime, '%Y-%m-%d'), 
     Hour(statistics.datetime) 
  ) ALL_STATS 
    ON ALL_STATS.branch = branchess.branchcode 
  LEFT JOIN 
  ( 
    SELECT 
     statistics.branch, 
     DayName(statistics.datetime) AS DAY, 
     Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE, 
     Hour(statistics.datetime) AS HOUR_OF_DAY, 
     count(*) AS COUNT 
   FROM 
     statistics 
   WHERE 
     statistics.type = 'return' AND 
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
   GROUP BY 
     statistics.branch, 
     DayName(statistics.datetime), 
     Date_Format(statistics.datetime, '%Y-%m-%d'), 
     Hour(statistics.datetime) 
  ) RETURNS 
    ON RETURNS.branch = branchess.branchcode 
    AND RETURNS.DATE = ALL_STATS.DATE 
    AND RETURNS.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY 
  LEFT JOIN 
  ( 
    SELECT 
     statistics.branch, 
     DayName(statistics.datetime) AS DAY, 
     Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE, 
     Hour(statistics.datetime) AS HOUR_OF_DAY, 
     count(*) AS COUNT 
   FROM 
     statistics 
   WHERE 
     statistics.type = 'issue' AND 
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
   GROUP BY 
     statistics.branch, 
     DayName(statistics.datetime), 
     Date_Format(statistics.datetime, '%Y-%m-%d'), 
     Hour(statistics.datetime) 
  ) CKO 
    ON CKO.branch = branchess.branchcode 
    AND CKO.DATE = ALL_STATS.DATE 
    AND CKO.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY 
  LEFT JOIN 
  ( 
    SELECT 
     statistics.branch, 
     DayName(statistics.datetime) AS DAY, 
     Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE, 
     Hour(statistics.datetime) AS HOUR_OF_DAY, 
     count(*) AS COUNT 
   FROM 
     statistics 
   WHERE 
     statistics.type = 'renew' AND 
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
   GROUP BY 
     statistics.branch, 
     DayName(statistics.datetime), 
     Date_Format(statistics.datetime, '%Y-%m-%d'), 
     Hour(statistics.datetime) 
  ) RENEWALS 
    ON RENEWALS.branch = branchess.branchcode 
    AND RENEWALS.DATE = ALL_STATS.DATE 
    AND RENEWALS.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY 
  LEFT JOIN 
  ( 
    SELECT 
     statistics.branch, 
     DayName(statistics.datetime) AS DAY, 
     Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE, 
     Hour(statistics.datetime) AS HOUR_OF_DAY, 
     Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
   FROM 
     statistics 
   WHERE 
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
     (statistics.type = 'issue' OR 
         statistics.type = 'renew') 
   GROUP BY 
     statistics.branch, 
     DayName(statistics.datetime), 
     Date_Format(statistics.datetime, '%Y-%m-%d'), 
     Hour(statistics.datetime) 
  ) totalborrowers 
    ON totalborrowers.branch = branchess.branchcode 
    AND totalborrowers.DATE = ALL_STATS.DATE 
    AND totalborrowers.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY 
  LEFT JOIN 
  ( 
    SELECT 
     statistics.branch, 
     DayName(statistics.datetime) AS DAY, 
     Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE, 
     Hour(statistics.datetime) AS HOUR_OF_DAY, 
     Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
   FROM 
     statistics 
   WHERE 
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
     statistics.type = 'issue' 
   GROUP BY 
     statistics.branch, 
     DayName(statistics.datetime), 
     Date_Format(statistics.datetime, '%Y-%m-%d'), 
     Hour(statistics.datetime) 
  ) ckoborrowers 
    ON ckoborrowers.branch = branchess.branchcode 
    AND ckoborrowers.DATE = ALL_STATS.DATE 
    AND ckoborrowers.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY 
  LEFT JOIN 
  ( 
    SELECT 
     statistics.branch, 
     DayName(statistics.datetime) AS DAY, 
     Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE, 
     Hour(statistics.datetime) AS HOUR_OF_DAY, 
     Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
   FROM 
     statistics 
   WHERE 
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
     statistics.type = 'renew' 
   GROUP BY 
     statistics.branch, 
     DayName(statistics.datetime), 
     Date_Format(statistics.datetime, '%Y-%m-%d'), 
     Hour(statistics.datetime) 
  ) renewborrowers 
    ON renewborrowers.branch = branchess.branchcode 
    AND renewborrowers.DATE = ALL_STATS.DATE 
    AND renewborrowers.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY 
WHERE 
  branchess.branchcode LIKE '%' 
GROUP BY 
  branchess.branchname, 
  ALL_STATS.DATE, 
  ALL_STATS.DAY, 
  ALL_STATS.HOUR_OF_DAY 
ORDER BY 
  branchess.branchname, 
  ALL_STATS.DATE, 
  ALL_STATS.DAY, 
  ALL_STATS.HOUR_OF_DAY )

























