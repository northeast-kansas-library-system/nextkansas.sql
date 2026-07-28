/*
R.003972

----------

Name: GHW - Borrower accounts - count by unexpired/expired
Created by: George Williams

----------

Group: -
     -

Created on: 2026-07-26 23:54:23
Modified on: 2026-07-27 11:16:29
Date last run: 2026-07-27 14:20:13

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

    <p id="report_id"><strong>Report number:</strong> 3972</p>

    <p id="report_name"><strong>Report name:</strong> Borrower accounts - count by unexpired/expired</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Counts borrowers by library and give a breakdown by unexpired/expired with percentages</p>

  </div>

  <div class="accordion accordion-flush">

<!-- Function section -->
    <div id="accordion_3972-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3972Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3972Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3972Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3972Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3972Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Counts unexpired and expired borrowers</p>
            <ul style="list-style-type:none">

              <li><strong>TIME FRAME:</strong> counts borrowers in Koha at the time the report is run</li>

              <li><strong>AT:</strong> all libraries or the library you specify</li>

              <li><strong>GROUPED BY:</strong> borrower home library</li>

              <li><strong>SORTED BY:</strong> library name</li>

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
    <div id="accordion_3972-2" class="accordion-item next_report_notes ">

      <h2 class="accordion-header" id="panelsStay_3972Open-headingTwo">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3972Open-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_3972Open-collapseTwo">

          Notes:

        </button>

      </h2>

      <div id="panelsStay_3972Open-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3972Open-headingTwo">
        <div class="accordion-body">

          <div id="notes_1" class="report_section">
            <h4>Purpose</h4>
            <p>This report was written to help give library directors data to review in preparation for discussing the default borrower expiration date.</p>
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

<!-- Hashtag section -->
  <div class="next_report_hashtags" style="display: none;">
    <p>#</p>
    <p>#</p>
    <p>#</p>
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
  branches.branchname,
  total_accounts.Count_borrowernumber AS `Total number of accounts`,
  unexpired_accounts.Count_borrowernumber AS `Unexpired accounts`,
  Concat(ROUND((unexpired_accounts.Count_borrowernumber /
  total_accounts.Count_borrowernumber) * 100, 2),
  '%') AS `Percentage of unexpired accounts`,
  expired_accounts.Count_borrowernumber AS `Expired accounts`,
  Concat(ROUND((expired_accounts.Count_borrowernumber /
  total_accounts.Count_borrowernumber) * 100, 2),
  '%') AS `Percentage of expired accounts`
FROM
  branches LEFT JOIN
  (SELECT
      borrowers.branchcode,
      Count(borrowers.borrowernumber) AS Count_borrowernumber
    FROM
      borrowers
    GROUP BY
      borrowers.branchcode) total_accounts ON total_accounts.branchcode =
      branches.branchcode LEFT JOIN
  (SELECT
      borrowers.branchcode,
      Count(borrowers.borrowernumber) AS Count_borrowernumber
    FROM
      borrowers
    WHERE
      borrowers.dateexpiry < CurDate()
    GROUP BY
      borrowers.branchcode) expired_accounts ON expired_accounts.branchcode =
      branches.branchcode LEFT JOIN
  (SELECT
      borrowers.branchcode,
      Count(borrowers.borrowernumber) AS Count_borrowernumber
    FROM
      borrowers
    WHERE
      borrowers.dateexpiry >= CurDate()
    GROUP BY
      borrowers.branchcode) unexpired_accounts ON unexpired_accounts.branchcode
      = branches.branchcode
WHERE
  branches.branchcode LIKE <<Choose your library|branches:all>>
LIMIT 250

























