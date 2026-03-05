/*
R.001907

----------

Name: GHW - Notices sent to a specific borrower
Created by: Heather Braum

----------

Group: Notices
     -

Created on: 2013-06-11 15:32:54
Modified on: 2025-10-22 18:14:39
Date last run: 2025-10-22 18:14:48

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
    <p id="report_name">Notices sent to a specific borrower</p>

    <label for="report_author">Report author/source:</label>
    <p id="report_author">GHW</p>

    <label for="report_summary">Report summary:</label>
    <p id="report_summary">Generates a report of all notices automatically sent to a specific borrower</p>

  </div>

  <div class="accordion accordion-flush">



<!-- Function section -->
    <div id="accordion_1907-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_1907Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_1907Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_1907Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_1907Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_1907Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Generates a report of all notices automatically sent to a specific borrower</p>
            <ul>

              <li>Shows messages that were queued within the previous 190 days</li>

              <li>For the specific borrower you choose</li>

              <li>grouped by message ID number</li>

              <li>sorted by newest date to oldest date</li>

            <span style="display: none;">
              <li></li>            </span>
            </ul>


            <span style="display: none;">
            <p> - </p>
            </span>

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
            <h4>Koha 22.11 note</h4>
            <p> Notice templates can include HTML code. When we upgraded to Koha 22.11 the way that sent notices display on a borrower's "Notices" tab has changed. Due to some of the HTML we use in our notice templates and the changes in Koha, sometimes the content of sent notices does not display as expected in Koha 22.11. This report allows you to view sent notices that may not be visible on a borrower's "Notices" tab.<br><br>The long-term fix for this problem is to update the CSS and HTML in all sent notices so that they will no longer conflict with the "Notices" tab. </p>
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
    <p><a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=1907" class="direct_download_btn">Download directly to a CSV file</a></p>
  </div>



<!-- Hashtag section -->
  <div class="next_report_hashtags" style="display: none;">
    <p>#notices</p>
    <p>#confidential</p>
    <p>#borrower</p>
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
  Concat_Ws( 
    '<br />', 
    Concat('Subject: ', message_queue.subject), 
    '', 
    Concat( 
      'Message type: ', 
      message_queue.message_transport_type 
    ), 
    Concat('Message status: ', message_queue.status), 
    '', 
    Concat('To: ', message_queue.to_address), 
    Concat('From: ', message_queue.from_address), 
    '', 
    Concat('Time created: ', message_queue.time_queued), 
    Concat('Time sent: ', message_queue.updated_on) 
  ) As META_DATA, 
  message_queue.content As MESSAGE_CONTENT 
From message_queue 
  Join borrowers On message_queue.borrowernumber = borrowers.borrowernumber 
Where 
  borrowers.cardnumber Like <<Enter library card number>> 
Group By 
  message_queue.time_queued, 
  message_queue.updated_on, 
  message_queue.subject, 
  message_queue.message_id 
Order By 
  message_queue.message_id Desc 

























