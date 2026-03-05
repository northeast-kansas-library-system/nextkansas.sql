/*
R.003419

----------

Name: 0006 - 2024_99_a_cy monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2021-02-04 16:59:13
Modified on: 2026-01-30 17:26:14
Date last run: 2026-03-01 00:06:02

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

    <p id="report_id"><strong>Report number:</strong> 3419</p>

    <p id="report_name"><strong>Report name:</strong> 0010 - 2024_99_a_cy monthly_statistics</p>

    <span style="display: none;">
      <p id="report_author"><strong>Report author/source:</strong> - </p>
    </span>

    <p id="report_summary"><strong>Report summary:</strong> Generates part of the monthly overview spreadsheet</p>

  </div>

  <div class="accordion accordion-flush">

    <!-- Function section -->
    <div id="accordion_3419-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3419Open-headingOne">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3419Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3419Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3419Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3419Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Counts issues, renewals, and returns</p>
            <ul style="list-style-type:none">

              <li><strong>TIME FRAME:</strong> gathers data for the previous calendar month</li>

              <li><strong>AT:</strong> all next search catalog libraries</li>

              <li><strong>GROUPED BY:</strong> library name</li>

              <li><strong>SORTED BY:</strong> library name</li>

              <span style="display: none;">
                <li><strong>CONTAINS LINKS:</strong> </li>
              </span>
            </ul>


            <span>
              <p>Runs in 00:01:36 // tested 2026-01-30</p>
            </span>

          </div>

        </div>
      </div>

    </div>

    <!-- Notes section -->
    <div id="accordion_3419-2" class="accordion-item next_report_notes ">

      <h2 class="accordion-header" id="panelsStay_3419Open-headingTwo">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3419Open-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_3419Open-collapseTwo">

          Notes:

        </button>

      </h2>

      <div id="panelsStay_3419Open-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3419Open-headingTwo">
        <div class="accordion-body">

          <div id="notes_1" class="report_section">
            <h4>Column header definitions</h4>
            <ul>
              <li>CHECKOUT_RENEW_LM = all items checked out or renewed at this library last month</li>
              <li>CHECKOUT_LM = all items checked out at this library last month</li>
              <li>RENEW_LM = all items renewed at this library last month</li>
              <li>RETURN_LM = all items returned at this library last month</li>
              <li>CR_ADULT_LM includes items with these shelving locations:<br>
                <ul>
                  <li>Adult</li>
                  <li>~Display - BALDWIN - Adult</li>
                  <li>~Display - LEAVENWRTH - Adult</li>
                  <li>~Display - PAOLA - Adult</li>
                  <li>Any situation where the location is recorded as "Recently returned" but the item's permanent
                    location is one
                    of these "Adult" locations</li>
                </ul>
              </li>
              <li>CR_YOUTH_LM includes items with these shelving locations:<br>
                <ul>
                  <li>Young adult</li>
                  <li>~Display - BALDWIN - Young Adult</li>
                  <li>~Display - LEAVENWRTH - Young adult</li>
                  <li>~Display - PAOLA - Young adult</li>
                  <li>Any situation where the location is recorded as "Recently returned" but the item's permanent
                    location is one
                    of these "Young adult" locations</li>
                  <li>Childrens</li>
                  <li>~Display - BALDWIN - Childrens</li>
                  <li>~Display - LEAVENWRTH - Children's</li>
                  <li>~Display - PAOLA - Children's</li>
                </ul>
              </li>
            </ul>
          </div>

          <div id="notes_2" class="report_section">
            <h4>SHELVING_LOCATION</h4>
            <p>SHELVING_LOCATION is based on the shelving location of the item at the time it was checked out *Unless
              the item had a "Recently returned" shelving location.* This report falls back to the items' "Permanent
              shelving location" whenever the statistics data shows that the item's shelving location was "Recently
              returned." If the shelving location is completely ambiguous, the circulation is counted as a "Youth"
              circulation in the CR_YOUTH_LM column.</p>
          </div>

          <div id="notes_3" class="report_section">
            <h4>Header row</h4>
            <p>The header row is duplicated to make it easier to schedule the report with the built-in report scheduling
              tool.</p>
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
      <p><a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=3419"
          class="direct_download_btn">Download directly to a CSV file</a></p>
    </div>

    <!-- Hashtag section -->
    <div class="next_report_hashtags" style="display: none;">
      <p>#monthly</p>
      <p>#statistics</p>
      <p>#monthly_statistics</p>
      <p>#overview</p>
      <p>#monthly_overview</p>
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
  "BRANCH_NAME" AS BRANCH_NAME,
  "CHECKOUT_RENEW_LM" AS CHECKOUT_RENEW_LM,
  "CHECKOUT_LM" AS CHECKOUT_LM,
  "RENEW_LM" AS RENEW_LM,
  "RETURN_LM" AS RETURN_LM,
  "CR_ADULT_LM" AS CR_ADULT_LM,
  "CR_YOUTH_LM" AS CR_YOUTH_LM
UNION  
SELECT 
  branches.branchname AS BRANCH_NAME, 
  Coalesce(CIR_RENEW_LM.count, 0) AS CHECKOUT_RENEW_LM, 
  Coalesce(CKO_LM.count, 0) AS CHECKOUT_LM, 
  Coalesce(RENEW_LM.count, 0) AS RENEW_LM, 
  Coalesce(RETURN_LM.count, 0) AS RETURN_LM, 
  Coalesce(ADULT.count, 0) AS CR_ADULT_LM, 
  Coalesce(YOUTH.count, 0) AS CR_YOUTH_LM 
FROM 
  branches LEFT JOIN 
    (SELECT 
      statistics.branch, 
      Count(*) AS count 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
        statistics.type = 'renew') AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      statistics.branch 
    ) CIR_RENEW_LM 
  ON branches.branchcode = CIR_RENEW_LM.branch LEFT JOIN 
    (SELECT 
      statistics.branch, 
      Count(*) AS count 
    FROM 
      statistics LEFT JOIN 
      items ON items.itemnumber = statistics.itemnumber 
    WHERE 
      (statistics.type = 'issue' OR 
        statistics.type = 'renew') AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      If( 
        Coalesce(statistics.location, "L_AD") = "CART", 
        Coalesce(items.permanent_location, 'L_AD'), 
        Coalesce(statistics.location, "L_AD") 
      ) LIKE "%AD%" 
    GROUP BY 
      statistics.branch 
    ) ADULT 
  ON branches.branchcode = ADULT.branch LEFT JOIN 
    (SELECT 
      statistics.branch, 
      Count(*) AS count 
    FROM 
      statistics LEFT JOIN 
      items ON items.itemnumber = statistics.itemnumber 
    WHERE 
      (statistics.type = 'issue' OR 
        statistics.type = 'renew') AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      If( 
        Coalesce(statistics.location, "L_AD") = "CART", 
        Coalesce(items.permanent_location, 'L_AD'), 
        Coalesce(statistics.location, "L_AD") 
      ) NOT LIKE "%AD%" 
    GROUP BY 
      statistics.branch 
    ) YOUTH 
  ON branches.branchcode = YOUTH.branch LEFT JOIN 
    (SELECT 
      statistics.branch, 
      Count(*) AS count 
    FROM 
      statistics 
    WHERE 
      statistics.type = 'issue' AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      statistics.branch 
    ) CKO_LM 
  ON CKO_LM.branch = branches.branchcode LEFT JOIN 
    (SELECT 
      statistics.branch, 
      Count(*) AS count 
    FROM 
      statistics 
    WHERE 
      statistics.type = 'renew' AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      statistics.branch 
    ) RENEW_LM 
  ON RENEW_LM.branch = branches.branchcode 
  LEFT JOIN 
    (SELECT 
      statistics.branch, 
      Count(*) AS count 
    FROM 
      statistics 
    WHERE 
      statistics.type = 'return' AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      statistics.branch 
    ) RETURN_LM 
  ON RETURN_LM.branch = branches.branchcode 
GROUP BY 
  BRANCH_NAME 
ORDER BY 
  IF(BRANCH_NAME = "BRANCH_NAME", " BRANCH_NAME", BRANCH_NAME) 
LIMIT 100

























