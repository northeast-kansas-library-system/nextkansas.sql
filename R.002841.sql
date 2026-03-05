/*
R.002841

----------

Name: GHW - Daily/hourly statistical tracker
Created by: George Williams

----------

Group: Statistics
     -

Created on: 2016-11-28 15:42:16
Modified on: 2025-10-23 09:05:52
Date last run: 2026-02-27 12:30:31

----------

Public: 0
Expiry: 0

----------

<div class="next_report_info next_noprint">

  <style>

       .page-section .next_report_info {
      font-size: 120% !important;
    }

        .next_report_summary label {
          margin: 2em 0em 0em 0em;
          font-weight: bold;
        }
        
        .next_report_summary p {
          margin: 0em 0em 2em 2em;
        }

        .report_hidden {
          display: none;
        }

        .accordion .accordion-button {
          font-size: 1.1em !important;
          color: white !important;
          font-weight: 900;
        }

        .next_report_function .accordion-header * {
          background-color: #DF6320 !important;
          color: #ffffff !important;
        }

        .next_report_notes .accordion-header * {
          background-color: #DFC220 !important;
          color: #000000 !important;
        }

        .next_report_instructions .accordion-header * {
          background-color: #3DDF20 !important;
          color: #000000 !important;
        }

        .next_report_resources .accordion-header * {
          background-color: #1f9bde !important;
          color: #ffffff !important;
        }

        .next_report_training .accordion-header * {
          background-color: #6320DF !important;
          color: #ffffff !important;
        }

        .accordion-collapse.collapse * {
          background-color: #e6e6e6;
          color: #000000;
        }

        .accordion-body h3 {
          font-size: 1.5em !important;
        }

        .report_section {
          border: 2px solid black;
          border-radius: 8px;
          margin: 10px;
          padding: 15px;
        }

        .resources_btn {
          padding: 10px;
          margin: 10px 0px 0px 0px;
          border: 1px solid #555;
          border-radius: 4px;
          display: inline-block;
          font-weight: 650;
          line-height: 1.5;
          text-align: center;
          vertical-align: middle;
          white-space: nowrap;
          background: #DFC220 none !important;
          color: #000000;
          !important;
        }

        .resources_btn:hover {
          background: #F2E6A5 none !important;
          color: #000000;
          !important;
        }

        .training_btn {
          padding: 10px;
          margin: 10px 0px 0px 0px;
          border: 1px solid #555;
          border-radius: 4px;
          display: inline-block;
          font-weight: 650;
          line-height: 1.5;
          text-align: center;
          vertical-align: middle;
          white-space: nowrap;
          background: #3DDF20 none !important;
          color: #000000;
          !important;
        }

        .training_btn:hover {
          background: #B1F2A5 none !important;
          color: #000000;
          !important;
        }

        .direct_download_btn {
          padding: 10px;
          margin: 10px 0px 0px 0px;
          border: 1px solid #555;
          border-radius: 4px;
          display: inline-block;
          font-weight: 650;
          line-height: 1.5;
          text-align: center;
          vertical-align: middle;
          white-space: nowrap;
          background: #C220DF none !important;
          color: #ffffff;
          !important;
        }

        .direct_download_btn:hover {
          background: #E6A5F2 none !important;
          color: #000000;
          !important;
        }

  </style>



<!-- Overview -->
  <div class="next_report_summary">
    <br>

    <label for="report_name">Report name:</label>
    <p id="report_name">Daily/hourly statistical tracker</p>

    <label for="report_author">Report author/source:</label>
    <p id="report_author">GHW</p>

    <label for="report_summary">Report summary:</label>
    <p id="report_summary">Counts check-outs, renewals, and check-ins and borrower accounts used on an hourly basis</p>

  </div>

  <div class="accordion accordion-flush">



<!-- Function section -->
    <div id="accordion_2841-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_2841Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_2841Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_2841Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_2841Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_2841Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Counts check-outs, renewals, and check-ins and borrower accounts used on an hourly basis</p>
            <ul>

              <li>shows activity during the previous calendar month</li>

              <li>shows activity at a branch you specify</li>

              <li>grouped and sorted by circulation branch, date, day of the week, hour of the day (in 24 hour format), and type of activity</li>

            <span style="display: none;">
              <li></li>            </span>

            <span style="display: none;">
              <li></li>            </span>
            </ul>


            <p>CKO = Checkout; RENEW = Renewal; RETURN = check in</p>

          </div>

        </div>
      </div>

    </div>



<!-- Notes section -->
    <div id="accordion_REPORTID-2" class="accordion-item next_report_notes ">

      <h2 class="accordion-header" id="panelsStay_REPORTIDOpen-headingTwo">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_REPORTIDOpen-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_REPORTIDOpen-collapseTwo">

          Notes:

        </button>

      </h2>

      <div id="panelsStay_REPORTIDOpen-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_REPORTIDOpen-headingTwo">
        <div class="accordion-body">

          <div id="notes_1" class="report_section">
            <h4>Replaces:</h4>
            <p>Replaces report 590</p>
          </div>

          <div id="notes_2" class="report_section">
            <h4>Misceleaneous notes:</h4>
            <p>Updated to include count of borrowers for each type of transaction.<br><br>The hour shows in military format - i.e. 13=1:00 p.m., 18=6:00 p.m., etc.<br><br>Koha counts renewals as happening at the location where the initial check-out happened - i.e. if an item was renewed by the patron via the OPAC, it counts as a renewal at the branch where the item was checked out (This is why you may see renewals on days your library is normally closed).</p>
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




<!-- Instructions section -->
    <div id="accordion_REPORTID-3" class="accordion-item next_report_instructions report_hidden">

      <h2 class="accordion-header" id="panelsStay_REPORTIDOpen-headingThree">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_REPORTIDOpen-collapseThree" aria-expanded="false"
          aria-controls="panelsStay_REPORTIDOpen-collapseThree">

          Instructions:

        </button>

      </h2>

      <div id="panelsStay_REPORTIDOpen-collapseThree" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_REPORTIDOpen-headingThree">
        <div class="accordion-body">

          <div id="instructions_1" class="report_section report_hidden">
            <h4> INSTRUCTION_1_TITLE </h4>
            <p> INSTRUCTION_1_CONTENT </p>
          </div>

          <div id="instructions_2" class="report_section report_hidden">
            <h4> INSTRUCTION_TWO_TITLE </h4>
            <p> INSTRUCTION_TWO_CONTENT </p>
          </div>

          <div id="instructions_3" class="report_section report_hidden">
            <h4> INSTRUCTION_THREE_TITLE </h4>
            <p> INSTRUCTION_THREE_CONTENT </p>
          </div>

          <div id="instructions_4" class="report_section report_hidden">
            <h4> INSTRUCTION_FOUR_TITLE </h4>
            <p> INSTRUCTION_FOUR_CONTENT </p>
          </div>

          <div id="instructions_5" class="report_section report_hidden">
            <h4> INSTRUCTION_FIVE_TITLE </h4>
            <p> INSTRUCTION_FIVE_CONTENT </p>
          </div>

        </div>
      </div>

    </div>



<!-- Resources section -->
    <div id="accordion_REPORTID-4" class="accordion-item next_report_resources report_hidden " style="">

      <h2 class="accordion-header" id="panelsStay_REPORTIDOpen-headingFour">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_REPORTIDOpen-collapseFour" aria-expanded="false"
          aria-controls="panelsStay_REPORTIDOpen-collapseFour">
          Resources:
        </button>
      </h2>

      <div id="panelsStay_REPORTIDOpen-collapseFour" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_REPORTIDOpen-headingFour">

        <div class="accordion-body">

          <div id="resources_1" class="row report_section report_hidden">
            <div class="col col-md-2">
              <p><a href=" RESOURCE_ONE_URL " target="_blank" class="resources_btn"> RESOURCE_ONE_TITLE </a></p>
            </div>            <div class="col col-md-8">
              <p> RESOURCE_ONE_NOTE </p>
            </div>          </div>


          <div id="resources_2" class="row report_section report_hidden">
            <div class="col col-md-2">
              <p><a href=" RESOURCE_TWO_URL " target="_blank" class="resources_btn"> RESOURCE_TWO_TITLE </a></p>
            </div>            <div class="col col-md-8">
              <p> RESOURCE_TWO_NOTE </p>
            </div>          </div>


          <div id="resources_3" class="row report_section report_hidden">
            <div class="col col-md-2">
              <p><a href=" RESOURCE_THREE_URL " target="_blank" class="resources_btn"> RESOURCE_THREE_TITLE </a></p>
            </div>            <div class="col col-md-8">
              <p> RESOURCE_THREE_NOTE </p>
            </div>          </div>


          <div id="resources_4" class="row report_section report_hidden">
            <div class="col col-md-2">
              <p><a href=" RESOURCE_FOUR_URL " target="_blank" class="resources_btn"> RESOURCE_FOUR_TITLE </a></p>
            </div>            <div class="col col-md-8">
              <p> RESOURCE_FOUR_NOTE </p>
            </div>          </div>


          <div id="resources_5" class="row report_section report_hidden">
            <div class="col col-md-2">
              <p><a href=" RESOURCE_FIVE_URL " target="_blank" class="resources_btn"> RESOURCE_FIVE_TITLE </a></p>
            </div>            <div class="col col-md-8">
              <p> RESOURCE_FIVE_NOTE </p>
            </div>          </div>

        </div>

      </div>

    </div>


<!-- Training section -->
    <div id="accordion_REPORTID-5" class="accordion-item next_report_training report_hidden">

      <h2 class="accordion-header" id="panelsStay_REPORTIDOpen-headingFive">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_REPORTIDOpen-collapseFive" aria-expanded="false"
          aria-controls="panelsStay_REPORTIDOpen-collapseFive">

          Training available

        </button>

      </h2>

      <div id="panelsStay_REPORTIDOpen-collapseFive" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_REPORTIDOpen-headingFive" style="color: white !important;">
        <div class="accordion-body">

          <div class="container text-center">
            <div class="row">


              <div id="training_link" class="col-md-3 report_hidden">
                <p><a href=" TRAINING_LINK_URL " target="_blank" class="training_btn">Online training</a></p>
              </div>


              <div id="training_link" class="col-md-3">
                <p><a href="" target="_blank" class="training_btn">Training handout</a></p>
              </div>

              <div id="training_link" class="col-md-3">
                <p><a href="" target="_blank" class="training_btn">Video training</a></p>
              </div>

            </div>
          </div>
        </div>
      </div>

    </div>

  </div>

<!-- Direct download section -->
  <div class="next_report_direct_download report_hidden">
    <p><a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=2841" class="direct_download_btn">Download directly to a CSV file</a></p>
  </div>



<!-- Hashtag section -->
  <div class="next_report_hashtags" style="display: none;">
    <p>#statistics</p>
    <p>#hourly</p>
    <p>#open records compliant</p>
    <p>#</p>
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
  branchess.branchname,
  ALL_STATS.DATE,
  ALL_STATS.DAY,
  Concat(ALL_STATS.HOUR_OF_DAY, ":00 - ", ALL_STATS.HOUR_OF_DAY, ":59") AS HOUR,
  Coalesce(CKO.COUNT, 0) AS CKO,
  Coalesce(RENEWALS.COUNT, 0) AS RENEW,
  Coalesce(RETURNS.COUNT, 0) AS RETURNS,
  ALL_STATS.COUNT AS TOTAL_CKO_RENEW_RETURN,
  Coalesce(ckoborrowers.Count_borrowernumber, 0) AS CKO_BORROWERS,
  Coalesce(renewborrowers.Count_borrowernumber, 0) AS RENEW_BORROWERS,
  totalborrowers.Count_borrowernumber AS CKO_AND_RENEW_BORROWERS
FROM
  (SELECT
     branches.branchcode,
     branches.branchname
   FROM
     branches) branchess LEFT JOIN
  (SELECT
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
     Hour(statistics.datetime)) ALL_STATS ON ALL_STATS.branch =
      branchess.branchcode LEFT JOIN
  (SELECT
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
     Hour(statistics.datetime)) RETURNS ON RETURNS.branch = branchess.branchcode
      AND
      RETURNS.DATE = ALL_STATS.DATE AND
      RETURNS.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY LEFT JOIN
  (SELECT
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
     Hour(statistics.datetime)) CKO ON CKO.branch = branchess.branchcode AND
      CKO.DATE = ALL_STATS.DATE AND
      CKO.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY LEFT JOIN
  (SELECT
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
     Hour(statistics.datetime)) RENEWALS ON
      RENEWALS.branch = branchess.branchcode AND
      RENEWALS.DATE = ALL_STATS.DATE AND
      RENEWALS.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY LEFT JOIN
  (SELECT
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
     Hour(statistics.datetime)) totalborrowers ON totalborrowers.branch =
      branchess.branchcode AND
      totalborrowers.DATE = ALL_STATS.DATE AND
      totalborrowers.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY LEFT JOIN
  (SELECT
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
     Hour(statistics.datetime)) ckoborrowers ON ckoborrowers.branch =
      branchess.branchcode AND
      ckoborrowers.DATE = ALL_STATS.DATE AND
      ckoborrowers.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY LEFT JOIN
  (SELECT
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
     Hour(statistics.datetime)) renewborrowers ON renewborrowers.branch =
      branchess.branchcode AND
      renewborrowers.DATE = ALL_STATS.DATE AND
      renewborrowers.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY
WHERE
  branchess.branchcode LIKE <<Choose your library|branches>>
GROUP BY
  branchess.branchname,
  ALL_STATS.DATE,
  ALL_STATS.DAY,
  ALL_STATS.HOUR_OF_DAY
ORDER BY
  branchess.branchname,
  ALL_STATS.DATE,
  ALL_STATS.DAY,
  ALL_STATS.HOUR_OF_DAY

























