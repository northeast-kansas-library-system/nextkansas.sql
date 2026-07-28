/*
R.003975

----------

Name: GHW - Expired borrower accounts by expected deletion date
Created by: George Williams

----------

Group: -
     -

Created on: 2026-07-27 10:31:46
Modified on: 2026-07-27 11:45:19
Date last run: 2026-07-27 13:24:21

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

    <p id="report_id"><strong>Report number:</strong> 3975</p>

    <p id="report_name"><strong>Report name:</strong> Expired borrower accounts by expected deletion date</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Counts expired borrowers by their expected deletion date</p>

  </div>

  <div class="accordion accordion-flush">

<!-- Function section -->
    <div id="accordion_3975-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3975Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3975Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3975Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3975Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3975Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Counts expired borrower accounts and groups them by their expired account attribute</p>
            <ul style="list-style-type:none">

              <li><strong>TIME FRAME:</strong> counts accounts in Koha right now</li>

              <li><strong>AT:</strong> all libraries or the library you specify</li>

              <li><strong>GROUPED BY:</strong> library name and expired attribute</li>

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
    <div id="accordion_3975-2" class="accordion-item next_report_notes ">

      <h2 class="accordion-header" id="panelsStay_3975Open-headingTwo">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3975Open-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_3975Open-collapseTwo">

          Notes:

        </button>

      </h2>

      <div id="panelsStay_3975Open-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3975Open-headingTwo">
        <div class="accordion-body">

          <div id="notes_1" class="report_section">
            <h4>Purpose</h4>
            <p>This report was written to help give library directors data to review in preparation for discussing the default borrower expiration date.</p>
          </div>

          <div id="notes_2" class="report_section report_hidden">
            <h4> Additional report </h4>
            <p> Run report 3000 to see which specific borrowers have an expired account attribute </p>
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
    <p>#borrower</p>
    <p>#expired</p>
    <p>#count</p>
    <p>#attriubtes</p>
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
  accounts_expired.Count_borrowernumber AS `Expired accounts`,
  Sum(CASE
    WHEN
      expired_by_attribute.attribute = 1
    THEN 1
    ELSE 0
  END) AS `2 years - deletion at 3`,
  Sum(CASE
    WHEN
      expired_by_attribute.attribute = 2
    THEN 1
    ELSE 0
  END) AS `2 years - auto-deletion will be blocked`,
  Sum(CASE
    WHEN
      expired_by_attribute.attribute = 5
    THEN 1
    ELSE 0
  END) AS `Will be deleted in January`,
  Sum(CASE
    WHEN
      expired_by_attribute.attribute = 6
    THEN 1
    ELSE 0
  END) AS `Will be deleted in February`,
  Sum(CASE
    WHEN
      expired_by_attribute.attribute = 7
    THEN 1
    ELSE 0
  END) AS `Will be deleted in March`,
  Sum(CASE
    WHEN
      expired_by_attribute.attribute = 8
    THEN 1
    ELSE 0
  END) AS `Will be deleted in April`,
  Sum(CASE
    WHEN
      expired_by_attribute.attribute = 9
    THEN 1
    ELSE 0
  END) AS `Will be deleted in May`,
  Sum(CASE
    WHEN
      expired_by_attribute.attribute = 10
    THEN 1
    ELSE 0
  END) AS `Will be deleted in June`,
  Sum(CASE
    WHEN
      expired_by_attribute.attribute = 11
    THEN 1
    ELSE 0
  END) AS `Will be deleted in July`,
  Sum(CASE
    WHEN
      expired_by_attribute.attribute = 12
    THEN 1
    ELSE 0
  END) AS `Will be deleted in August`,
  Sum(CASE
    WHEN
      expired_by_attribute.attribute = 13
    THEN 1
    ELSE 0
  END) AS `Will be deleted in September`,
  Sum(CASE
    WHEN
      expired_by_attribute.attribute = 14
    THEN 1
    ELSE 0
  END) AS `Will be deleted in October`,
  Sum(CASE
    WHEN
      expired_by_attribute.attribute = 15
    THEN 1
    ELSE 0
  END) AS `Will be deleted in November`,
  Sum(CASE
    WHEN
      expired_by_attribute.attribute = 16
    THEN 1
    ELSE 0
  END) AS `Will be deleted in December`,
  Sum(CASE
    WHEN
      expired_by_attribute.attribute = 4
    THEN 1
    ELSE 0
  END) AS `3 years expired - auto-deletion is blocked`
FROM
  branches LEFT JOIN
  (SELECT
      borrowers.branchcode,
      Count(borrowers.borrowernumber) AS Count_borrowernumber
    FROM
      borrowers
    WHERE
      borrowers.dateexpiry < CurDate()
    GROUP BY
      borrowers.branchcode) accounts_expired ON accounts_expired.branchcode =
      branches.branchcode LEFT JOIN
  (SELECT
      borrowers.branchcode,
      borrower_attributes.attribute,
      authorised_values.lib,
      borrower_attributes.borrowernumber
    FROM
      authorised_values JOIN
      borrower_attributes ON borrower_attributes.attribute =
          authorised_values.authorised_value JOIN
      borrowers ON borrower_attributes.borrowernumber = borrowers.borrowernumber
    WHERE
      authorised_values.category = 'EXPIRED' AND
      borrower_attributes.code = 'EXPIRED'
    GROUP BY
      borrowers.branchcode,
      borrower_attributes.attribute,
      authorised_values.lib,
      borrower_attributes.borrowernumber
    ORDER BY
      borrowers.branchcode,
      authorised_values.lib) expired_by_attribute ON
      expired_by_attribute.branchcode = branches.branchcode
WHERE
  branches.branchcode LIKE <<Choose your library|branches:all>>
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchname
LIMIT 250

























