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
Date last run: 2025-10-23 09:06:07

----------

Public: 0
Expiry: 0

----------

&lt;div class="next_report_info next_noprint"&gt;

  &lt;style&gt;

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

  &lt;/style&gt;



&lt;!-- Overview --&gt;
  &lt;div class="next_report_summary"&gt;
    &lt;br&gt;

    &lt;label for="report_name"&gt;Report name:&lt;/label&gt;
    &lt;p id="report_name"&gt;Daily/hourly statistical tracker&lt;/p&gt;

    &lt;label for="report_author"&gt;Report author/source:&lt;/label&gt;
    &lt;p id="report_author"&gt;GHW&lt;/p&gt;

    &lt;label for="report_summary"&gt;Report summary:&lt;/label&gt;
    &lt;p id="report_summary"&gt;Counts check-outs, renewals, and check-ins and borrower accounts used on an hourly basis&lt;/p&gt;

  &lt;/div&gt;

  &lt;div class="accordion accordion-flush"&gt;



&lt;!-- Function section --&gt;
    &lt;div id="accordion_2841-1" class="accordion-item next_report_function"&gt;

      &lt;h2 class="accordion-header" id="panelsStay_2841Open-headingOne" &gt;

        &lt;button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_2841Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_2841Open-collapseOne"&gt;

          Function:

        &lt;/button&gt;

      &lt;/h2&gt;

      &lt;div id="panelsStay_2841Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_2841Open-headingOne"&gt;
        &lt;div class="accordion-body"&gt;

          &lt;div id="function_section" class="report_section"&gt;


            &lt;p&gt;Counts check-outs, renewals, and check-ins and borrower accounts used on an hourly basis&lt;/p&gt;
            &lt;ul&gt;

              &lt;li&gt;shows activity during the previous calendar month&lt;/li&gt;

              &lt;li&gt;shows activity at a branch you specify&lt;/li&gt;

              &lt;li&gt;grouped and sorted by circulation branch, date, day of the week, hour of the day (in 24 hour format), and type of activity&lt;/li&gt;

            &lt;span style="display: none;"&gt;
              &lt;li&gt;&lt;/li&gt;            &lt;/span&gt;

            &lt;span style="display: none;"&gt;
              &lt;li&gt;&lt;/li&gt;            &lt;/span&gt;
            &lt;/ul&gt;


            &lt;p&gt;CKO = Checkout; RENEW = Renewal; RETURN = check in&lt;/p&gt;

          &lt;/div&gt;

        &lt;/div&gt;
      &lt;/div&gt;

    &lt;/div&gt;



&lt;!-- Notes section --&gt;
    &lt;div id="accordion_REPORTID-2" class="accordion-item next_report_notes "&gt;

      &lt;h2 class="accordion-header" id="panelsStay_REPORTIDOpen-headingTwo"&gt;

        &lt;button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_REPORTIDOpen-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_REPORTIDOpen-collapseTwo"&gt;

          Notes:

        &lt;/button&gt;

      &lt;/h2&gt;

      &lt;div id="panelsStay_REPORTIDOpen-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_REPORTIDOpen-headingTwo"&gt;
        &lt;div class="accordion-body"&gt;

          &lt;div id="notes_1" class="report_section"&gt;
            &lt;h4&gt;Replaces:&lt;/h4&gt;
            &lt;p&gt;Replaces report 590&lt;/p&gt;
          &lt;/div&gt;

          &lt;div id="notes_2" class="report_section"&gt;
            &lt;h4&gt;Misceleaneous notes:&lt;/h4&gt;
            &lt;p&gt;Updated to include count of borrowers for each type of transaction.&lt;br&gt;&lt;br&gt;The hour shows in military format - i.e. 13=1:00 p.m., 18=6:00 p.m., etc.&lt;br&gt;&lt;br&gt;Koha counts renewals as happening at the location where the initial check-out happened - i.e. if an item was renewed by the patron via the OPAC, it counts as a renewal at the branch where the item was checked out (This is why you may see renewals on days your library is normally closed).&lt;/p&gt;
          &lt;/div&gt;

          &lt;div id="notes_3" class="report_section report_hidden"&gt;
            &lt;h4&gt; NOTE_THREE_TITLE &lt;/h4&gt;
            &lt;p&gt; NOTE_THREE_CONTENT &lt;/p&gt;
          &lt;/div&gt;

          &lt;div id="notes_4" class="report_section report_hidden"&gt;
            &lt;h4&gt; NOTE_FOUR_TITLE &lt;/h4&gt;
            &lt;p&gt; NOTE_FOUR_CONTENT &lt;/p&gt;
          &lt;/div&gt;

          &lt;div id="notes_5" class="report_section report_hidden"&gt;
            &lt;h4&gt; NOTE_FIVE_TITLE &lt;/h4&gt;
            &lt;p&gt; NOTE_FIVE_CONTENT &lt;/p&gt;
          &lt;/div&gt;

        &lt;/div&gt;
      &lt;/div&gt;

    &lt;/div&gt;




&lt;!-- Instructions section --&gt;
    &lt;div id="accordion_REPORTID-3" class="accordion-item next_report_instructions report_hidden"&gt;

      &lt;h2 class="accordion-header" id="panelsStay_REPORTIDOpen-headingThree"&gt;

        &lt;button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_REPORTIDOpen-collapseThree" aria-expanded="false"
          aria-controls="panelsStay_REPORTIDOpen-collapseThree"&gt;

          Instructions:

        &lt;/button&gt;

      &lt;/h2&gt;

      &lt;div id="panelsStay_REPORTIDOpen-collapseThree" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_REPORTIDOpen-headingThree"&gt;
        &lt;div class="accordion-body"&gt;

          &lt;div id="instructions_1" class="report_section report_hidden"&gt;
            &lt;h4&gt; INSTRUCTION_1_TITLE &lt;/h4&gt;
            &lt;p&gt; INSTRUCTION_1_CONTENT &lt;/p&gt;
          &lt;/div&gt;

          &lt;div id="instructions_2" class="report_section report_hidden"&gt;
            &lt;h4&gt; INSTRUCTION_TWO_TITLE &lt;/h4&gt;
            &lt;p&gt; INSTRUCTION_TWO_CONTENT &lt;/p&gt;
          &lt;/div&gt;

          &lt;div id="instructions_3" class="report_section report_hidden"&gt;
            &lt;h4&gt; INSTRUCTION_THREE_TITLE &lt;/h4&gt;
            &lt;p&gt; INSTRUCTION_THREE_CONTENT &lt;/p&gt;
          &lt;/div&gt;

          &lt;div id="instructions_4" class="report_section report_hidden"&gt;
            &lt;h4&gt; INSTRUCTION_FOUR_TITLE &lt;/h4&gt;
            &lt;p&gt; INSTRUCTION_FOUR_CONTENT &lt;/p&gt;
          &lt;/div&gt;

          &lt;div id="instructions_5" class="report_section report_hidden"&gt;
            &lt;h4&gt; INSTRUCTION_FIVE_TITLE &lt;/h4&gt;
            &lt;p&gt; INSTRUCTION_FIVE_CONTENT &lt;/p&gt;
          &lt;/div&gt;

        &lt;/div&gt;
      &lt;/div&gt;

    &lt;/div&gt;



&lt;!-- Resources section --&gt;
    &lt;div id="accordion_REPORTID-4" class="accordion-item next_report_resources report_hidden " style=""&gt;

      &lt;h2 class="accordion-header" id="panelsStay_REPORTIDOpen-headingFour"&gt;
        &lt;button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_REPORTIDOpen-collapseFour" aria-expanded="false"
          aria-controls="panelsStay_REPORTIDOpen-collapseFour"&gt;
          Resources:
        &lt;/button&gt;
      &lt;/h2&gt;

      &lt;div id="panelsStay_REPORTIDOpen-collapseFour" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_REPORTIDOpen-headingFour"&gt;

        &lt;div class="accordion-body"&gt;

          &lt;div id="resources_1" class="row report_section report_hidden"&gt;
            &lt;div class="col col-md-2"&gt;
              &lt;p&gt;&lt;a href=" RESOURCE_ONE_URL " target="_blank" class="resources_btn"&gt; RESOURCE_ONE_TITLE &lt;/a&gt;&lt;/p&gt;
            &lt;/div&gt;            &lt;div class="col col-md-8"&gt;
              &lt;p&gt; RESOURCE_ONE_NOTE &lt;/p&gt;
            &lt;/div&gt;          &lt;/div&gt;


          &lt;div id="resources_2" class="row report_section report_hidden"&gt;
            &lt;div class="col col-md-2"&gt;
              &lt;p&gt;&lt;a href=" RESOURCE_TWO_URL " target="_blank" class="resources_btn"&gt; RESOURCE_TWO_TITLE &lt;/a&gt;&lt;/p&gt;
            &lt;/div&gt;            &lt;div class="col col-md-8"&gt;
              &lt;p&gt; RESOURCE_TWO_NOTE &lt;/p&gt;
            &lt;/div&gt;          &lt;/div&gt;


          &lt;div id="resources_3" class="row report_section report_hidden"&gt;
            &lt;div class="col col-md-2"&gt;
              &lt;p&gt;&lt;a href=" RESOURCE_THREE_URL " target="_blank" class="resources_btn"&gt; RESOURCE_THREE_TITLE &lt;/a&gt;&lt;/p&gt;
            &lt;/div&gt;            &lt;div class="col col-md-8"&gt;
              &lt;p&gt; RESOURCE_THREE_NOTE &lt;/p&gt;
            &lt;/div&gt;          &lt;/div&gt;


          &lt;div id="resources_4" class="row report_section report_hidden"&gt;
            &lt;div class="col col-md-2"&gt;
              &lt;p&gt;&lt;a href=" RESOURCE_FOUR_URL " target="_blank" class="resources_btn"&gt; RESOURCE_FOUR_TITLE &lt;/a&gt;&lt;/p&gt;
            &lt;/div&gt;            &lt;div class="col col-md-8"&gt;
              &lt;p&gt; RESOURCE_FOUR_NOTE &lt;/p&gt;
            &lt;/div&gt;          &lt;/div&gt;


          &lt;div id="resources_5" class="row report_section report_hidden"&gt;
            &lt;div class="col col-md-2"&gt;
              &lt;p&gt;&lt;a href=" RESOURCE_FIVE_URL " target="_blank" class="resources_btn"&gt; RESOURCE_FIVE_TITLE &lt;/a&gt;&lt;/p&gt;
            &lt;/div&gt;            &lt;div class="col col-md-8"&gt;
              &lt;p&gt; RESOURCE_FIVE_NOTE &lt;/p&gt;
            &lt;/div&gt;          &lt;/div&gt;

        &lt;/div&gt;

      &lt;/div&gt;

    &lt;/div&gt;


&lt;!-- Training section --&gt;
    &lt;div id="accordion_REPORTID-5" class="accordion-item next_report_training report_hidden"&gt;

      &lt;h2 class="accordion-header" id="panelsStay_REPORTIDOpen-headingFive"&gt;

        &lt;button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_REPORTIDOpen-collapseFive" aria-expanded="false"
          aria-controls="panelsStay_REPORTIDOpen-collapseFive"&gt;

          Training available

        &lt;/button&gt;

      &lt;/h2&gt;

      &lt;div id="panelsStay_REPORTIDOpen-collapseFive" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_REPORTIDOpen-headingFive" style="color: white !important;"&gt;
        &lt;div class="accordion-body"&gt;

          &lt;div class="container text-center"&gt;
            &lt;div class="row"&gt;


              &lt;div id="training_link" class="col-md-3 report_hidden"&gt;
                &lt;p&gt;&lt;a href=" TRAINING_LINK_URL " target="_blank" class="training_btn"&gt;Online training&lt;/a&gt;&lt;/p&gt;
              &lt;/div&gt;


              &lt;div id="training_link" class="col-md-3"&gt;
                &lt;p&gt;&lt;a href="" target="_blank" class="training_btn"&gt;Training handout&lt;/a&gt;&lt;/p&gt;
              &lt;/div&gt;

              &lt;div id="training_link" class="col-md-3"&gt;
                &lt;p&gt;&lt;a href="" target="_blank" class="training_btn"&gt;Video training&lt;/a&gt;&lt;/p&gt;
              &lt;/div&gt;

            &lt;/div&gt;
          &lt;/div&gt;
        &lt;/div&gt;
      &lt;/div&gt;

    &lt;/div&gt;

  &lt;/div&gt;

&lt;!-- Direct download section --&gt;
  &lt;div class="next_report_direct_download report_hidden"&gt;
    &lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=2841" class="direct_download_btn"&gt;Download directly to a CSV file&lt;/a&gt;&lt;/p&gt;
  &lt;/div&gt;



&lt;!-- Hashtag section --&gt;
  &lt;div class="next_report_hashtags" style="display: none;"&gt;
    &lt;p&gt;#statistics&lt;/p&gt;
    &lt;p&gt;#hourly&lt;/p&gt;
    &lt;p&gt;#open records compliant&lt;/p&gt;
    &lt;p&gt;#&lt;/p&gt;
    &lt;p&gt;#&lt;/p&gt;
    &lt;p&gt;#&lt;/p&gt;
    &lt;p&gt;#&lt;/p&gt;
    &lt;p&gt;#&lt;/p&gt;
    &lt;p&gt;#&lt;/p&gt;
    &lt;p&gt;#&lt;/p&gt;
  &lt;/div&gt;

&lt;/div&gt;

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
  branchess.branchcode LIKE &lt;&gt;
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

























