/*
R.003996

----------

Name: GHW - Card numbers by library, state, city, expiration
Created by: George Williams

----------

Group: -
     -

Created on: 2026-08-27 15:54:48
Modified on: 2026-08-28 16:03:51
Date last run: 2026-08-28 16:05:19

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

    <p id="report_id"><strong>Report number:</strong> 3996</p>

    <p id="report_name"><strong>Report name:</strong> Card numbers by library, state, city, expiration</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Lists borrowers by home library, state, city, account expiration, borrower category, and card number</p>

  </div>

  <div class="accordion accordion-flush">

<!-- Function section -->
    <div id="accordion_3996-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3996Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3996Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3996Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3996Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3996Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Lists borrowers by home library, state, city, account expiration, borrower category, and card number</p>
            <ul style="list-style-type:none">

              <li><strong>TIME FRAME:</strong> shows borrowers in Koha at the time the report is run</li>

              <li><strong>AT:</strong> the library you specify</li>

              <li><strong>GROUPED BY:</strong> borrower number</li>

              <li><strong>SORTED BY:</strong> home library, state, city, account expiration</li>

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
    <div id="accordion_3996-2" class="accordion-item next_report_notes ">

      <h2 class="accordion-header" id="panelsStay_3996Open-headingTwo">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3996Open-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_3996Open-collapseTwo">

          Notes:

        </button>

      </h2>

      <div id="panelsStay_3996Open-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3996Open-headingTwo">
        <div class="accordion-body">

          <div id="notes_1" class="report_section">
            <h4>Protected borrowers</h4>
            <p>Card numbers for accounts in the patron categories "Staff - Permissions template," "Staff - SIP user," and "Staff - system login (exempt)" are redacted from view in this report.<br><br>These accounts are for system use and should not be modified by unauthorized staff, so the report prevents staff from accessing those card numbers via this report.</p>
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
                <p><a href="https://nextkansas.org/koha_reports/3996" target="_blank" class="training_btn">Online training</a></p>
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

<!-- Hashtag section -->
  <div class="next_report_hashtags" style="display: none;">
    <p>#borrower_list</p>
    <p>#cardnumber</p>
    <p>#state_needs_training</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#3996</p>
  </div>

</div>

----------
*/



SELECT
  branches.branchname AS HOME_LIBRARY,
  If(Coalesce(borrowers.state, '--') = '', '--', Coalesce(borrowers.state, '--')) as STATE,
  If(Coalesce(borrowers.city, '--') = '', '--', Coalesce(borrowers.city, '--')) AS CITY,
  borrowers.dateexpiry AS ACCOUNT_EXPIRATION,
  categories.description AS BORROWER_CATEGORY,
  CASE
    WHEN categories.categorycode = 'S_TT' OR 
      categories.categorycode = 'S_SIP' OR 
      categories.categorycode = 'STAFF'
    THEN 'Card number redacted from this report'
    ELSE borrowers.cardnumber
  END AS CARD_NUMBER
FROM
  branches
  JOIN borrowers
    ON borrowers.branchcode = branches.branchcode
  JOIN categories
    ON borrowers.categorycode = categories.categorycode
WHERE
  borrowers.branchcode LIKE <<Borrower home library|branches>> AND
  If(Coalesce(borrowers.state, '--') = '', '--', Coalesce(borrowers.state, '--')) LIKE CONCAT('%', <<Enter part of state name or abbreviation or a % symbol>>, '%') AND
  If(Coalesce(borrowers.city, '--') = '', '--', Coalesce(borrowers.city, '--')) LIKE CONCAT('%', <<Enter part of city name or a % symbol>>, '%') AND 
  borrowers.dateexpiry < <<Account expiration before|date>>
GROUP BY
  borrowers.borrowernumber
ORDER BY
  branches.branchname,
  borrowers.state,
  borrowers.city,
  borrowers.dateexpiry DESC

























