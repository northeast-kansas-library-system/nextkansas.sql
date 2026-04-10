/*
R.003701

----------

Name: 0035 - 2024_99_d_circulation_borrower_category monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2023-02-10 09:36:34
Modified on: 2026-01-30 17:27:43
Date last run: 2026-04-01 00:35:02

----------

Public: 0
Expiry: 300

----------

<div class="next_report_info next_noprint">

<style>

  .report_hidden {
    display:  none
  }

  .accordion .accordion-button {
    font-size:  1.1em !important;
    color:  #fff !important;
    font-weight:  900
  }

  .next_report_function .accordion-header * {
    background-color:  #df6320 !important;
    color:  #fff !important
  }

  .next_report_notes .accordion-header * {
    background-color:  #dfc220 !important;
    color:  #000 !important
  }

  .next_report_instructions .accordion-header * {
    background-color:  #3ddf20 !important;
    color:  #000 !important
  }

  .next_report_resources .accordion-header * {
    background-color:  #1f9bde !important;
    color:  #fff !important
  }

  .next_report_training .accordion-header * {
    background-color:  #6320df !important;
    color:  #fff !important
  }

  .accordion-collapse.collapse * {
    background-color:  #e6e6e6;
    color:  #000
  }

  .accordion-body h3 {
    font-size:  1.5em !important
  }

  .report_section {
    border:  2px solid #000;
    border-radius:  8px;
    margin:  10px;
    padding:  15px
  }

  .resources_btn, .training_btn, .direct_download_btn {
    padding:  10px;
    margin:  10px 0 0;
    display:  inline-block;
    font-weight:  650;
    line-height:  1.5;
    text-align:  center;
    vertical-align:  middle;
    white-space:  nowrap;
    color:  #000
  }

  .resources_btn {
    border:  1px solid #555;
    border-radius:  4px;
    background:  #dfc220 !important
  }

  .training_btn {
    border:  1px solid #555;
    border-radius:  4px;
    background:  #3ddf20 !important
  }

  .direct_download_btn {
    color:  #fff;
    border:  1px solid #555;
    border-radius:  4px;
    background:  indigo !important
  }
  .direct_download_btn:hover {
    color: #000000 !important;
    background: #D396FF !important;
  }

</style>

<!-- Overview -->

  <div class="next_report_summary">
    <br>

    <p id="report_id"><strong>Report number:</strong> 3701</p>

    <p id="report_name"><strong>Report name:</strong> 0045 - 2024_99_d_circulation_borrower_category monthly_statistics</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Generates data for monthly statistics</p>

  </div>

  <div class="accordion accordion-flush">

<!-- Function section -->
    <div id="accordion_3701-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3701Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3701Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3701Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3701Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3701Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Gathers statistics for circulation and renewals organized by borrower category</p>
            <ul style="list-style-type:none">

              <li><strong>TIME FRAME:</strong> previous calendar month</li>

              <li><strong>AT:</strong> all Next Search Catalog libraries</li>

              <li><strong>GROUPED BY:</strong> library name and borrower category</li>

              <li><strong>SORTED BY:</strong> library name and borrower category</li>

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
    <div id="accordion_3701-2" class="accordion-item next_report_notes ">

      <h2 class="accordion-header" id="panelsStay_3701Open-headingTwo">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3701Open-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_3701Open-collapseTwo">

          Notes:

        </button>

      </h2>

      <div id="panelsStay_3701Open-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3701Open-headingTwo">
        <div class="accordion-body">

          <div id="notes_1" class="report_section">
            <h4>Header row</h4>
            <p>The header row is duplicated to make it easier to schedule the report with the built-in report scheduling tool.</p>
          </div>

          <div id="notes_2" class="report_section report_hidden">
            <h4> NOTE_TWO_TITLE </h4>
            <p> NOTE_TWO_CONTENT </p>
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
    <p><a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=3701" class="direct_download_btn">Download directly to a CSV file</a></p>
  </div>

<!-- Hashtag section -->
  <div class="next_report_hashtags" style="display: none;">
    <p>##monthly#####</p>
    <p>#statistics</p>
    <p>#borrower</p>
    <p>#details</p>
    <p>#borrower_category</p>
    <p>#circulation_by_borrower_details</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
  </div>

</div>

----------
*/



SELECT 
  'Library' AS 'Library',  
  'Borrower category' AS 'Borrower category',  
  'Total items checked out/renewed' AS 'Total items checked out/renewed',  
  'Adult items checked out/renewed' AS 'Adult items checked out/renewed',  
  'Young-adult items checked out/renewed' AS 'Young-adult items checked out/renewed',  
  'Juvenile items checked out/renewed' AS 'Juvenile items checked out/renewed',  
  'Other items checked out/renewed' AS 'Other items checked out/renewed'
UNION 
(SELECT 
  branchescategories.branchname AS 'Library', 
  branchescategories.description AS 'Borrower category', 
  CIR_RENEW_LM.count AS 'Total items checked out/renewed', 
  ADULT.count AS 'Adult items checked out/renewed', 
  YOUNG_ADULT.count AS 'Young-adult items checked out/renewed', 
  JUVENILE.count AS 'Juvenile items checked out/renewed', 
  OTHER.count AS 'Other items checked out/renewed' 
FROM 
  ( 
    SELECT 
      branches.branchcode, 
      branches.branchname, 
      categories.categorycode, 
      categories.description 
    FROM 
      branches, 
      categories 
    GROUP BY 
      branches.branchcode, 
      branches.branchname, 
      categories.categorycode, 
      categories.description 
  ) branchescategories 
    LEFT JOIN 
  ( 
    SELECT 
      statistics.branch, 
      Coalesce( 
        borrowers.categorycode, 
        deletedborrowers.categorycode, 
        'ADULT' 
      ) AS CATEGORY_CODE, 
      Count(*) AS count 
    FROM 
      statistics LEFT JOIN 
      borrowers ON borrowers.borrowernumber = statistics.borrowernumber LEFT JOIN 
      deletedborrowers ON deletedborrowers.borrowernumber = statistics.borrowernumber 
    WHERE 
      ( 
        statistics.type = 'issue' OR 
        statistics.type = 'renew' 
      ) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      statistics.branch, 
      Coalesce( 
        borrowers.categorycode, 
        deletedborrowers.categorycode, 
        'ADULT' 
      ) 
  ) CIR_RENEW_LM 
    ON CIR_RENEW_LM.CATEGORY_CODE = branchescategories.categorycode AND 
    CIR_RENEW_LM.branch = branchescategories.branchcode LEFT JOIN 
  ( 
    SELECT 
      statistics.branch, 
      Coalesce( 
        borrowers.categorycode, 
        deletedborrowers.categorycode, 
        'ADULT' 
      ) AS CATEGORY_CODE, 
      Count(*) AS count 
    FROM 
      statistics LEFT JOIN 
      items ON items.itemnumber = statistics.itemnumber LEFT JOIN 
      borrowers ON borrowers.borrowernumber = statistics.borrowernumber LEFT JOIN 
      deletedborrowers ON deletedborrowers.borrowernumber = statistics.borrowernumber 
    WHERE 
      ( 
        statistics.type = 'issue' OR 
        statistics.type = 'renew' 
      ) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      If( 
        Coalesce(statistics.location, "L_AD") = "CART", 
        Coalesce(items.permanent_location, "L_AD"), 
        Coalesce(statistics.location, "L_AD") 
      ) LIKE "%AD%" 
    GROUP BY 
      statistics.branch, 
      Coalesce(borrowers.categorycode, deletedborrowers.categorycode, 'ADULT') 
  ) ADULT 
    ON ADULT.branch = branchescategories.branchcode AND 
    ADULT.CATEGORY_CODE = branchescategories.categorycode LEFT JOIN 
  ( 
    SELECT 
      statistics.branch, 
      Coalesce( 
        borrowers.categorycode, 
        deletedborrowers.categorycode, 
        'ADULT' 
      ) AS CATEGORY_CODE, 
      Count(*) AS count 
    FROM 
      statistics LEFT JOIN 
      items ON items.itemnumber = statistics.itemnumber LEFT JOIN 
      borrowers ON borrowers.borrowernumber = statistics.borrowernumber LEFT JOIN 
      deletedborrowers ON deletedborrowers.borrowernumber = statistics.borrowernumber 
    WHERE 
      ( 
        statistics.type = 'issue' OR 
        statistics.type = 'renew' 
      ) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      If( 
        Coalesce(statistics.location, "L_AD") = "CART", 
        Coalesce(items.permanent_location, "L_AD"), 
        Coalesce(statistics.location, "L_AD") 
      ) LIKE "%YA%" 
    GROUP BY 
      statistics.branch, 
      Coalesce(borrowers.categorycode, deletedborrowers.categorycode, 'ADULT') 
  ) YOUNG_ADULT 
    ON YOUNG_ADULT.branch = branchescategories.branchcode AND 
    YOUNG_ADULT.CATEGORY_CODE = branchescategories.categorycode LEFT JOIN 
  ( 
    SELECT 
      statistics.branch, 
      Coalesce( 
        borrowers.categorycode, 
        deletedborrowers.categorycode, 
        'ADULT' 
      ) AS CATEGORY_CODE, 
      Count(*) AS count 
    FROM 
      statistics LEFT JOIN 
      items ON items.itemnumber = statistics.itemnumber LEFT JOIN 
      borrowers ON borrowers.borrowernumber = statistics.borrowernumber LEFT JOIN 
      deletedborrowers ON deletedborrowers.borrowernumber = statistics.borrowernumber 
    WHERE 
      ( 
        statistics.type = 'issue' OR 
        statistics.type = 'renew' 
      ) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      If( 
        Coalesce(statistics.location, "L_AD") = "CART", 
        Coalesce(items.permanent_location, "L_AD"), 
        Coalesce(statistics.location, "L_AD") 
      ) LIKE"%JU%" 
    GROUP BY 
      statistics.branch, 
      Coalesce( 
        borrowers.categorycode, 
        deletedborrowers.categorycode, 
        'ADULT' 
      ) 
  ) JUVENILE 
    ON JUVENILE.branch = branchescategories.branchcode AND 
    JUVENILE.CATEGORY_CODE = branchescategories.categorycode LEFT JOIN 
  ( 
    SELECT 
      statistics.branch, 
      Coalesce( 
        borrowers.categorycode, 
        deletedborrowers.categorycode, 
        'ADULT' 
      ) AS CATEGORY_CODE, 
      Count(*) AS count 
    FROM 
      statistics LEFT JOIN 
      items ON items.itemnumber = statistics.itemnumber LEFT JOIN 
      borrowers ON borrowers.borrowernumber = statistics.borrowernumber LEFT JOIN 
      deletedborrowers ON deletedborrowers.borrowernumber = statistics.borrowernumber 
    WHERE 
      ( 
        statistics.type = 'issue' OR 
        statistics.type = 'renew' 
      ) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      If( 
        Coalesce(statistics.location, "L_AD") = "CART", 
        Coalesce(items.permanent_location, "L_AD"), 
        Coalesce(statistics.location, "L_AD") 
      ) NOT LIKE "%AD%" AND 
      If( 
        Coalesce(statistics.location, "L_AD") = "CART", 
        Coalesce(items.permanent_location, "L_AD"), 
        Coalesce(statistics.location, "L_AD")) NOT LIKE "%YA%" AND 
      If( 
        Coalesce(statistics.location, "L_AD") = "CART", 
        Coalesce(items.permanent_location, "L_AD"), 
        Coalesce(statistics.location, "L_AD") 
      ) NOT LIKE "%JU%" 
    GROUP BY 
      statistics.branch, 
      Coalesce( 
        borrowers.categorycode, 
        deletedborrowers.categorycode, 
        'ADULT' 
      ) 
  ) OTHER 
    ON OTHER.branch = branchescategories.branchcode AND 
    OTHER.CATEGORY_CODE = branchescategories.categorycode 
GROUP BY 
  branchescategories.branchname, 
  branchescategories.description, 
  CIR_RENEW_LM.count, 
  ADULT.count, 
  YOUNG_ADULT.count, 
  JUVENILE.count, 
  OTHER.count 
ORDER BY 
  branchescategories.branchname, 
  branchescategories.description )

























