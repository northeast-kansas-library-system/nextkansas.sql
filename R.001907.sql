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
    &lt;p id="report_name"&gt;Notices sent to a specific borrower&lt;/p&gt;

    &lt;label for="report_author"&gt;Report author/source:&lt;/label&gt;
    &lt;p id="report_author"&gt;GHW&lt;/p&gt;

    &lt;label for="report_summary"&gt;Report summary:&lt;/label&gt;
    &lt;p id="report_summary"&gt;Generates a report of all notices automatically sent to a specific borrower&lt;/p&gt;

  &lt;/div&gt;

  &lt;div class="accordion accordion-flush"&gt;



&lt;!-- Function section --&gt;
    &lt;div id="accordion_1907-1" class="accordion-item next_report_function"&gt;

      &lt;h2 class="accordion-header" id="panelsStay_1907Open-headingOne" &gt;

        &lt;button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_1907Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_1907Open-collapseOne"&gt;

          Function:

        &lt;/button&gt;

      &lt;/h2&gt;

      &lt;div id="panelsStay_1907Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_1907Open-headingOne"&gt;
        &lt;div class="accordion-body"&gt;

          &lt;div id="function_section" class="report_section"&gt;


            &lt;p&gt;Generates a report of all notices automatically sent to a specific borrower&lt;/p&gt;
            &lt;ul&gt;

              &lt;li&gt;Shows messages that were queued within the previous 190 days&lt;/li&gt;

              &lt;li&gt;For the specific borrower you choose&lt;/li&gt;

              &lt;li&gt;grouped by message ID number&lt;/li&gt;

              &lt;li&gt;sorted by newest date to oldest date&lt;/li&gt;

            &lt;span style="display: none;"&gt;
              &lt;li&gt;&lt;/li&gt;            &lt;/span&gt;
            &lt;/ul&gt;


            &lt;span style="display: none;"&gt;
            &lt;p&gt; - &lt;/p&gt;
            &lt;/span&gt;

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
            &lt;h4&gt;Koha 22.11 note&lt;/h4&gt;
            &lt;p&gt; Notice templates can include HTML code. When we upgraded to Koha 22.11 the way that sent notices display on a borrower's "Notices" tab has changed. Due to some of the HTML we use in our notice templates and the changes in Koha, sometimes the content of sent notices does not display as expected in Koha 22.11. This report allows you to view sent notices that may not be visible on a borrower's "Notices" tab.&lt;br&gt;&lt;br&gt;The long-term fix for this problem is to update the CSS and HTML in all sent notices so that they will no longer conflict with the "Notices" tab. &lt;/p&gt;
          &lt;/div&gt;

          &lt;div id="notes_2" class="report_section report_hidden"&gt;
            &lt;h4&gt; NOTE_TWO_TITLE &lt;/h4&gt;
            &lt;p&gt; NOTE_TWO_CONTENT &lt;/p&gt;
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


              &lt;div id="training_handout" class="col-md-3 report_hidden" &gt;
                &lt;p&gt;&lt;a href=" TRAINING_HANDOUT_URL " target="_blank" class="training_btn"&gt;Training handout&lt;/a&gt;&lt;/p&gt;
              &lt;/div&gt;


              &lt;div id="training_handout" class="col-md-3 report_hidden" &gt;
                &lt;p&gt;&lt;a href=" TRAINING_VIDEO_URL " target="_blank" class="training_btn"&gt;Video training&lt;/a&gt;&lt;/p&gt;
              &lt;/div&gt;

            &lt;/div&gt;
          &lt;/div&gt;
        &lt;/div&gt;
      &lt;/div&gt;

    &lt;/div&gt;

  &lt;/div&gt;

&lt;!-- Direct download section --&gt;
  &lt;div class="next_report_direct_download report_hidden"&gt;
    &lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=1907" class="direct_download_btn"&gt;Download directly to a CSV file&lt;/a&gt;&lt;/p&gt;
  &lt;/div&gt;



&lt;!-- Hashtag section --&gt;
  &lt;div class="next_report_hashtags" style="display: none;"&gt;
    &lt;p&gt;#notices&lt;/p&gt;
    &lt;p&gt;#confidential&lt;/p&gt;
    &lt;p&gt;#borrower&lt;/p&gt;
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



Select 
  Concat_Ws( 
    '', 
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
  borrowers.cardnumber Like &lt;&gt; 
Group By 
  message_queue.time_queued, 
  message_queue.updated_on, 
  message_queue.subject, 
  message_queue.message_id 
Order By 
  message_queue.message_id Desc 

























