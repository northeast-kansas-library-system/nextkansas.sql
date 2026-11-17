/*
R.003280

----------

Name: GHW - Borrower count by library / state / city
Created by: George Williams

----------

Group: -
     -

Created on: 2019-11-08 14:37:15
Modified on: 2026-08-28 12:25:44
Date last run: 2026-08-28 12:35:39

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

    <p id="report_id"><strong>Report number:</strong> 3280</p>

    <p id="report_name"><strong>Report name:</strong> Borrower count by library / city / state</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Counts borrowers by home library, grouped by borrower's home library, state, and city</p>

  </div>

  <div class="accordion accordion-flush">

<!-- Function section -->
    <div id="accordion_3280-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3280Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3280Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3280Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3280Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3280Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Counts borrowers</p>
            <ul style="list-style-type:none">

              <li><strong>TIME FRAME:</strong> shows borrowers in Koha at the time the report is run</li>

              <li><strong>AT:</strong> the library you specify</li>

              <li><strong>GROUPED BY:</strong> borrower's home library, borrower's state, and borrower's city</li>

            <span style="display: none;">
              <li><strong>SORTED BY:</strong> </li>
            </span>

              <li><strong>CONTAINS LINKS:</strong> Report 3996</li>
            </ul>


            <p>Updated from older report</p>

          </div>

        </div>
      </div>

    </div>

<!-- Notes section -->
    <div id="accordion_3280-2" class="accordion-item next_report_notes ">

      <h2 class="accordion-header" id="panelsStay_3280Open-headingTwo">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3280Open-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_3280Open-collapseTwo">

          Notes:

        </button>

      </h2>

      <div id="panelsStay_3280Open-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3280Open-headingTwo">
        <div class="accordion-body">

          <div id="notes_1" class="report_section">
            <h4>Column titles</h4>
            <p><ul><br>  <li>STATE_TOTALS = this column indicates that the totals in this row are for the entire state </li>  <li>LIBRARY_TOTALS - this column indicates that the totals in this row are for this library<br>(this will be the last row in the results)</li>  <li>TOTAL_BORROWERS = total of all borrowers with this library set as their home library</li>  <li>UNEXPIRED_BORROWERS = total of all borrowers with with accounts that expire today or after today</li>  <li>EXPIRED_BORROWERS = borrowers whose accounts expired yesterday or earlier</li>  <li>EXPIRED_ONE = count of all borrowers whose accounts expired more than 1 year ago</li>  <li>EXPIRED_TWO = count of all borrowers whose accounts expired more than 2 years ago</li>  <li>EXPIRED_THREE = count of all borrowers whose accounts expired more than 3 years ago</li>  <li>EXPIRED_FOUR = count of all borrowers whose accounts expired more than 4 years ago<br>these borrowers<br>    almost certainly have account problems that will prevent their accounts from being automatically deleted<br>  </li>  <li>REPORT_3996 = clicking the button in this row will run report 3996 with the parameters specified in the button text</li></ul></p>
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

<!-- Training section -->
    <div id="accordion_-5" class="accordion-item next_report_training ">

      <h2 class="accordion-header" id="panelsStay_Open-headingFive">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_Open-collapseFive" aria-expanded="false"
          aria-controls="panelsStay_Open-collapseFive">

          Training available

        </button>

      </h2>

      <div id="panelsStay_Open-collapseFive" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_Open-headingFive" style="color: white !important;">
        <div class="accordion-body">

          <div class="container text-center">
            <div class="row">


              <div id="training_link" class="col-md-3">
                <p><a href="https://nextkansas.org/koha_reports/3280" target="_blank" class="training_btn">Online training</a></p>
                <p>You must be log in to your staff Aspen Discovery account to access</p>
              </div>


              <div id="training_handout" class="col-md-3 report_hidden" >
                <p><a href=" TRAINING_HANDOUT_URL " target="_blank" class="training_btn">Training handout</a></p>
              </div>


              <div id="training_handout" class="col-md-3 report_hidden" >
                <p><a href=" TRAINING_VIDEO_URL " target="_blank" class="training_btn">Video training</a></p>
              </div>

            </div>
          </div>
        </div>
      </div>

    </div>

  </div>

<!-- Hashtag section -->
  <div class="next_report_hashtags" style="display: none;">
    <p>#count</p>
    <p>#borrowers</p>
    <p>#state_needs_training</p>
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
  results.* 
FROM 
( 
  SELECT 
    branches.branchname, 
    If(Coalesce(borrowers.state, '--') = '', '--', Coalesce(borrowers.state, '--')) AS state, 
    If(Coalesce(borrowers.city, '--') = '', '--', Coalesce(borrowers.city, '--')) AS city, 
    '' AS STATE_TOTALS, 
    '' AS LIBRARY_TOTALS, 
    Count(borrowers.borrowernumber) AS TOTAL_BORROWERS, 
    Sum(CASE 
      WHEN borrowers.dateexpiry >= CurDate() 
      THEN 1 
      ELSE 0 
    END) AS UNEXPIRED_BORROWERS, 
    Sum(CASE 
      WHEN borrowers.dateexpiry < CurDate() 
      THEN 1 
      ELSE 0 
    END) AS EXPIRED_BORROWERS, 
    Sum(CASE 
      WHEN borrowers.dateexpiry < (CurDate() - INTERVAL 1 YEAR) 
      THEN 1 
      ELSE 0 
    END) AS EXPIRED_ONE, 
    Sum(CASE 
      WHEN borrowers.dateexpiry < (CurDate() - INTERVAL 2 YEAR) 
      THEN 1 
      ELSE 0 
    END) AS EXPIRED_TWO, 
    Sum(CASE 
      WHEN borrowers.dateexpiry < (CurDate() - INTERVAL 3 YEAR) 
      THEN 1 
      ELSE 0 
    END) AS EXPIRED_THREE, 
    Sum(CASE 
      WHEN borrowers.dateexpiry < (CurDate() - INTERVAL 4 YEAR) 
      THEN 1 
      ELSE 0 
    END) AS EXPIRED_FOUR, 
    CONCAT_WS('',
      '<a class="btn btn-default" href=\"', 
      '/cgi-bin/koha/reports/guided_reports.pl?op=run&id=3996',
      '&sql_params=',
      borrowers.branchcode,
      '&sql_params=',
      If(Coalesce(borrowers.state, '--') = '', '--', Coalesce(borrowers.state, '--')),
      '&sql_params=',
      If(Coalesce(borrowers.city, '--') = '', '--', Coalesce(borrowers.city, '--')),
      '&sql_params=9999-12-31"', 
      ' target="_blank">Run report 3996 for <br>', 
      CONCAT_WS(' / ', 
        If(Coalesce(borrowers.state, '--') = '', '--', Coalesce(borrowers.state, '--')), 
        If(Coalesce(borrowers.city, '--') = '', '--', Coalesce(borrowers.city, '--'))), 
      '<br>combination</a>' 
    ) AS REPORT_3996 
  FROM 
    branches 
    JOIN borrowers 
      ON borrowers.branchcode = branches.branchcode 
  WHERE 
    borrowers.branchcode LIKE <<Choose your library|ZBRAN>> 
  GROUP BY 
    branches.branchname, 
    Coalesce(borrowers.state, ''), 
    Coalesce(borrowers.city, '') 
  UNION ALL 
  SELECT 
    branches.branchname, 
    Coalesce(borrowers.state, '') AS state, 
    '' AS city, 
    Concat(Coalesce(borrowers.state, ''), ' total') AS STATE_TOTALS, 
    '' AS LIBRARY_TOTALS, 
    Count(borrowers.borrowernumber) AS TOTAL_BORROWERS, 
    Sum(CASE 
      WHEN borrowers.dateexpiry >= CurDate() 
      THEN 1 
      ELSE 0 
    END) AS UNEXPIRED_BORROWERS, 
    Sum(CASE 
      WHEN borrowers.dateexpiry < CurDate() 
      THEN 1 
      ELSE 0 
    END) AS EXPIRED_BORROWERS, 
    Sum(CASE 
      WHEN borrowers.dateexpiry < (CurDate() - INTERVAL 1 YEAR) 
      THEN 1 
      ELSE 0 
    END) AS EXPIRED_ONE, 
    Sum(CASE 
      WHEN borrowers.dateexpiry < (CurDate() - INTERVAL 2 YEAR) 
      THEN 1 
      ELSE 0 
    END) AS EXPIRED_TWO, 
    Sum(CASE 
      WHEN borrowers.dateexpiry < (CurDate() - INTERVAL 3 YEAR) 
      THEN 1 
      ELSE 0 
    END) AS EXPIRED_THREE, 
    Sum(CASE 
      WHEN borrowers.dateexpiry < (CurDate() - INTERVAL 4 YEAR) 
      THEN 1 
      ELSE 0 
    END) AS EXPIRED_FOUR, 
    CONCAT_WS('',
      '<a class="btn btn-default" href=\"', 
      '/cgi-bin/koha/reports/guided_reports.pl?op=run&id=3996',
      '&sql_params=',
      borrowers.branchcode,
      '&sql_params=',
      If(Coalesce(borrowers.state, '--') = '', '--', Coalesce(borrowers.state, '--')),
      '&sql_params=',
      '%', 
      '&sql_params=9999-12-31"', 
      ' target="_blank">Run report 3996 for<br>', 
      If(Coalesce(borrowers.state, '--') = '', '--', Coalesce(borrowers.state, '--')), 
      '</a>' 
    ) AS REPORT_3996 
  FROM 
    branches 
    JOIN borrowers 
      ON borrowers.branchcode = branches.branchcode 
  WHERE 
    borrowers.branchcode LIKE <<Choose your library|ZBRAN>> 
  GROUP BY 
    branches.branchname, 
    Coalesce(borrowers.state, '') 
  UNION ALL 
  SELECT 
    branches.branchname, 
    '' AS state, 
    '' AS city, 
    '' AS STATE_TOTALS, 
    Concat(branches.branchname, ' totals') AS LIBRARY_TOTALS, 
    Count(borrowers.borrowernumber) AS TOTAL_BORROWERS, 
    Sum(CASE 
      WHEN borrowers.dateexpiry >= CurDate() 
      THEN 1 
      ELSE 0 
    END) AS UNEXPIRED_BORROWERS, 
    Sum(CASE 
      WHEN borrowers.dateexpiry < CurDate() 
      THEN 1 
      ELSE 0 
    END) AS EXPIRED_BORROWERS, 
    Sum(CASE 
      WHEN borrowers.dateexpiry < (CurDate() - INTERVAL 1 YEAR) 
      THEN 1 
      ELSE 0 
    END) AS EXPIRED_ONE, 
    Sum(CASE 
      WHEN borrowers.dateexpiry < (CurDate() - INTERVAL 2 YEAR) 
      THEN 1 
      ELSE 0 
    END) AS EXPIRED_TWO, 
    Sum(CASE 
      WHEN borrowers.dateexpiry < (CurDate() - INTERVAL 3 YEAR) 
      THEN 1 
      ELSE 0 
    END) AS EXPIRED_THREE, 
    Sum(CASE 
      WHEN borrowers.dateexpiry < (CurDate() - INTERVAL 4 YEAR) 
      THEN 1 
      ELSE 0 
    END) AS EXPIRED_FOUR, 
    CONCAT_WS('', 
      '<a class="btn btn-default" href=\"', 
      '/cgi-bin/koha/reports/guided_reports.pl?op=run&id=3996', 
      '&sql_params=', 
      borrowers.branchcode, 
      '&sql_params=', 
      '%', 
      '&sql_params=', 
      '%', 
      '&sql_params=9999-12-31"', 
      ' target="_blank">Run report 3996 for<br>all patrons at <br>', 
      branches.branchname, '</a>' 
    ) AS REPORT_3996 
  FROM 
    branches 
    JOIN borrowers 
      ON borrowers.branchcode = branches.branchcode 
  WHERE 
    borrowers.branchcode LIKE <<Choose your library|ZBRAN>> 
  GROUP BY 
    branches.branchname 
) AS results 
ORDER BY 
  results.branchname, 
  CASE 
    WHEN results.LIBRARY_TOTALS <> '' 
    THEN 1 
    ELSE 0 
  END, 
  results.state, 
  CASE 
    WHEN results.STATE_TOTALS <> '' 
    THEN 1 
    ELSE 0 
  END, 
  results.city 

























