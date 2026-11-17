/*
R.003520

----------

Name: GHW - ATCHISON patrons without Kanopy access
Created by: George Williams

----------

Group:  ATCHISON
     -

Created on: 2021-06-14 11:27:37
Modified on: 2026-11-16 18:13:24
Date last run: 2026-11-16 18:13:24

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

    <p id="report_id"><strong>Report number:</strong> 3520</p>

    <p id="report_name"><strong>Report name:</strong> ATCHISON patrons without Kanopy access</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Lists patrons with a ATCHISON home library but without a "Kanopy (ATCHISON): Allowed . . ." borrower attribute.</p>

  </div>

  <div class="accordion accordion-flush">

<!-- Function section -->
    <div id="accordion_3520-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3520Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3520Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3520Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3520Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3520Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Lists patrons with a ATCHISON home library but without a "Kanopy (ATCHISON): Allowed . . ." borrower attribute.</p>
            <ul style="list-style-type:none">

              <li><strong>TIME FRAME:</strong> lists borrowers that currently lack this attribute</li>

              <li><strong>AT:</strong> ATCHISON</li>

              <li><strong>GROUPED BY:</strong> grouped by categorycode and borrowernumber</li>

              <li><strong>SORTED BY:</strong> sorted by library card number</li>

              <li><strong>CONTAINS LINKS:</strong> the borrower account</li>
            </ul>

          </div>

        </div>
      </div>

    </div>

<!-- Notes section -->
    <div id="accordion_3520-2" class="accordion-item next_report_notes ">

      <h2 class="accordion-header" id="panelsStay_3520Open-headingTwo">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3520Open-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_3520Open-collapseTwo">

          Notes:

        </button>

      </h2>

      <div id="panelsStay_3520Open-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3520Open-headingTwo">
        <div class="accordion-body">

          <div id="notes_1" class="report_section">
            <h4>Frequency</h4>
            <p>Should be run monthly at ATCHISON so the attribute can be added to those accounts</p>
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
    <p>#kanopy</p>
    <p>#attributes</p>
    <p>#ATCHISON</p>
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
  Concat(
    '<a class="next_btn next_yellow noprint" ',
    'href="/cgi-bin/koha/members/moremember.pl?borrowernumber=', 
    borrowers.borrowernumber, 
    '#patron-extended-attributes" ', 
    'target="_blank">Go to patron account</a>'
  ) AS LINK,
  borrowers.cardnumber AS CARD_NUMBER
FROM
  borrowers
  LEFT JOIN (
    SELECT
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute
    FROM
      borrower_attributes
    WHERE
      borrower_attributes.code = 'ATCHKANOPY'
  ) kanopy
    ON kanopy.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode = 'ATCHISON' AND
  kanopy.attribute IS NULL AND
  borrowers.categorycode <> 'STAFF' AND
  borrowers.categorycode <> "ILL" AND
  borrowers.categorycode <> "INHOUSE" AND
  borrowers.categorycode <> "STATISTIC" AND 
  borrowers.categorycode <> "S_SIP" AND 
  borrowers.othernames <> 'SIP2 test account'
GROUP BY
  borrowers.categorycode,
  borrowers.borrowernumber
ORDER BY
  borrowers.cardnumber

























