/*
R.003929

----------

Name: GHW - Borrower count by expired attribute
Created by: George Williams

----------

Group: -
     -

Created on: 2025-11-17 17:49:18
Modified on: 2025-11-17 21:25:44
Date last run: 2026-01-30 16:30:20

----------

Public: 0
Expiry: 300

----------

<div class="next_report_info next_noprint">

  <style>

       .page-section .next_report_info {
      font-size: 120% !important;
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

    <p id="report_id"><strong>Report number:</strong> 3929</p>

    <p id="report_name"><strong>Report name:</strong> Borrower count by expired attribute</p>

    <span style="display: none;">
      <p id="report_author"><strong>Report author/source:</strong> - </p>
    </span>

    <p id="report_summary"><strong>Report summary:</strong> Produces a count of borrowers based on their account expired attribute.</p>

  </div>

  <div class="accordion accordion-flush">



<!-- Function section -->
    <div id="accordion_3929-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3929Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3929Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3929Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3929Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3929Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>This report produces a count of borrowers</p>
            <ul>

              <li>Counts borrowers currently in the system</li>

              <li>At the library you specify</li>

              <li>Grouped by borrower's home branch and category code</li>

              <li>Sorted by borrower's home branch and category code</li>

              <li>Contains links to report 3000 - Borrower list by expired attribute</li>
            </ul>


            <span style="display: none;">
            <p> - </p>
            </span>

          </div>

        </div>
      </div>

    </div>



<!-- Notes section -->
    <div id="accordion_REPORTID-2" class="accordion-item next_report_notes report_hidden">

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

          <div id="notes_1" class="report_section report_hidden">
            <h4> NOTE_ONE_TITLE </h4>
            <p> NOTE_ONE_CONTENT </p>
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

<!-- Direct download section -->
  <div class="next_report_direct_download report_hidden">
    <p><a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=3929" class="direct_download_btn">Download directly to a CSV file</a></p>
  </div>



<!-- Hashtag section -->
  <div class="next_report_hashtags" style="display: none;">
    <p>#borrower count</p>
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



Select
  branches.branchname,
  categories.description,
  Coalesce(expired_account.lib, '-- Active borrowers --') As 'Expiration attribute',
  Count(borrowers.cardnumber) As 'Number of users',
  Concat( 
      '<a class="next_btn next_indigo noprint" ', 
      'href="/cgi-bin/koha/reports/guided_reports.pl?id=',
      '3000' /* report number for attribute report */, 
      '&param_name=Choose+your+library|LBRANCH&sql_params=',
      borrowers.branchcode,
      '&param_name=Choose+expiration+notice|LEXPIRED&sql_params=',
      expired_account.authorised_value,
      '&op=run',
      '" target="_blank">Attribute report</a>' 
    ) AS LINK
From
  borrowers Left Join
  (Select
      borrower_attributes.borrowernumber,
      authorised_values.lib,
      borrower_attributes.attribute,
      authorised_values.authorised_value
    From
      borrower_attributes Join
      authorised_values On borrower_attributes.attribute = authorised_values.authorised_value
    Where
      borrower_attributes.code = 'EXPIRED' And
      authorised_values.category = 'EXPIRED'
    Group By
      borrower_attributes.borrowernumber,
      borrower_attributes.attribute,
      borrower_attributes.code) expired_account On borrowers.borrowernumber = expired_account.borrowernumber Left Join
  branches On borrowers.branchcode = branches.branchcode Left Join
  categories On borrowers.categorycode = categories.categorycode
Where
  borrowers.branchcode Like <<Choose your library|ZBRAN>>
Group By
  borrowers.branchcode,
  borrowers.categorycode,
  Coalesce(expired_account.lib, '')

























