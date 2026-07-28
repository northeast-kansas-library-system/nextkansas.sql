/*
R.003973

----------

Name: GHW - Expired borrower accounts by year
Created by: George Williams

----------

Group: -
     -

Created on: 2026-07-27 01:04:29
Modified on: 2026-07-27 11:16:45
Date last run: 2026-07-27 13:18:27

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

    <p id="report_id"><strong>Report number:</strong> 3973</p>

    <p id="report_name"><strong>Report name:</strong> Expired borrower accounts by year</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Counts expired borrower accounts and gives year-by-year breakdown of when they expired</p>

  </div>

  <div class="accordion accordion-flush">

<!-- Function section -->
    <div id="accordion_3973-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3973Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3973Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3973Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3973Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3973Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Counts expired borrower accounts</p>
            <ul style="list-style-type:none">

              <li><strong>TIME FRAME:</strong> counts accounts in Koha right now</li>

              <li><strong>AT:</strong> all libraries or the library you specify</li>

              <li><strong>GROUPED BY:</strong> library name</li>

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
    <div id="accordion_3973-2" class="accordion-item next_report_notes ">

      <h2 class="accordion-header" id="panelsStay_3973Open-headingTwo">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3973Open-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_3973Open-collapseTwo">

          Notes:

        </button>

      </h2>

      <div id="panelsStay_3973Open-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3973Open-headingTwo">
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
    <p>#borrower count</p>
    <p>#expired borrowers</p>
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
  '-' AS branchname,
  '--' AS `Total borrowers`,
  '---' AS `Total expired borrowers`,
  Concat(Year(CurDate() - INTERVAL 6 YEAR), ' and older') AS `Expired more than 5 years`,
  Year(CurDate() - INTERVAL 5 YEAR) AS `Expired 5 years ago`,
  Year(CurDate() - INTERVAL 4 YEAR) AS `Expired 4 years ago`,
  Year(CurDate() - INTERVAL 3 YEAR) AS `Expired 3 years ago`,
  Year(CurDate() - INTERVAL 2 YEAR) AS `Expired 2 years ago`,
  Year(CurDate() - INTERVAL 1 YEAR) AS `Expired last year`,
  Year(CurDate()) AS `Expired this year`
UNION
SELECT
  branches.branchname,
  total_borrowers.TOTAL AS `Total borrowers`,
  total_expired.TOTAL AS `Total expired borrowers`,
  expired_5_plus.TOTAL AS `Expired more than 5 years`,
  expired_5.TOTAL AS `Expired 5 years ago`,
  expired_4.TOTAL AS `Expired 4 years ago`,
  expired_3.TOTAL AS `Expired 3 years ago`,
  expired_2.TOTAL AS `Expired 2 years ago`,
  expired_1.TOTAL AS `Expired last year`,
  expired_this_year.TOTAL AS `Expired this year`
FROM
  branches
  LEFT JOIN (SELECT
     borrowers.branchcode,
     Count(borrowers.borrowernumber) AS TOTAL
   FROM
     borrowers
   GROUP BY
     borrowers.branchcode) total_borrowers
    ON total_borrowers.branchcode = branches.branchcode
  LEFT JOIN (SELECT
     borrowers.branchcode,
     Count(borrowers.borrowernumber) AS TOTAL
   FROM
     borrowers
   WHERE
     Year(borrowers.dateexpiry) < Year(CurDate() - INTERVAL 5 YEAR)
   GROUP BY
     borrowers.branchcode) expired_5_plus
    ON expired_5_plus.branchcode = branches.branchcode
  LEFT JOIN (SELECT
     borrowers.branchcode,
     Count(borrowers.borrowernumber) AS TOTAL
   FROM
     borrowers
   WHERE
     Year(borrowers.dateexpiry) = Year(CurDate() - INTERVAL 5 YEAR)
   GROUP BY
     borrowers.branchcode) expired_5
    ON expired_5.branchcode = branches.branchcode
  LEFT JOIN (SELECT
     borrowers.branchcode,
     Count(borrowers.borrowernumber) AS TOTAL
   FROM
     borrowers
   WHERE
     Year(borrowers.dateexpiry) = Year(CurDate() - INTERVAL 4 YEAR)
   GROUP BY
     borrowers.branchcode) expired_4
    ON expired_4.branchcode = branches.branchcode
  LEFT JOIN (SELECT
     borrowers.branchcode,
     Count(borrowers.borrowernumber) AS TOTAL
   FROM
     borrowers
   WHERE
     Year(borrowers.dateexpiry) = Year(CurDate() - INTERVAL 3 YEAR)
   GROUP BY
     borrowers.branchcode) expired_3
    ON expired_3.branchcode = branches.branchcode
  LEFT JOIN (SELECT
     borrowers.branchcode,
     Count(borrowers.borrowernumber) AS TOTAL
   FROM
     borrowers
   WHERE
     Year(borrowers.dateexpiry) = Year(CurDate() - INTERVAL 2 YEAR)
   GROUP BY
     borrowers.branchcode) expired_2
    ON expired_2.branchcode = branches.branchcode
  LEFT JOIN (SELECT
     borrowers.branchcode,
     Count(borrowers.borrowernumber) AS TOTAL
   FROM
     borrowers
   WHERE
     Year(borrowers.dateexpiry) = Year(CurDate() - INTERVAL 1 YEAR)
   GROUP BY
     borrowers.branchcode) expired_1
    ON expired_1.branchcode = branches.branchcode
  LEFT JOIN (SELECT
     borrowers.branchcode,
     Count(borrowers.borrowernumber) AS TOTAL
   FROM
     borrowers
   WHERE
     borrowers.dateexpiry <= CurDate() AND
     Year(borrowers.dateexpiry) = Year(CurDate())
   GROUP BY
     borrowers.branchcode) expired_this_year
    ON expired_this_year.branchcode = branches.branchcode
  LEFT JOIN (SELECT
     borrowers.branchcode,
     Count(borrowers.borrowernumber) AS TOTAL
   FROM
     borrowers
   WHERE
     borrowers.dateexpiry < CurDate()
   GROUP BY
     borrowers.branchcode) total_expired
    ON total_expired.branchcode = branches.branchcode
WHERE 
  branches.branchcode like <<Choose your library|branches:all>>
LIMIT 250

























