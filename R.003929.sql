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
Date last run: 2025-11-24 11:56:39

----------

Public: 0
Expiry: 300

----------

&lt;div class="next_report_info next_noprint"&gt;

  &lt;style&gt;

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

  &lt;/style&gt;



&lt;!-- Overview --&gt;
  &lt;div class="next_report_summary"&gt;
    &lt;br&gt;

    &lt;p id="report_id"&gt;&lt;strong&gt;Report number:&lt;/strong&gt; 3929&lt;/p&gt;

    &lt;p id="report_name"&gt;&lt;strong&gt;Report name:&lt;/strong&gt; Borrower count by expired attribute&lt;/p&gt;

    &lt;span style="display: none;"&gt;
      &lt;p id="report_author"&gt;&lt;strong&gt;Report author/source:&lt;/strong&gt; - &lt;/p&gt;
    &lt;/span&gt;

    &lt;p id="report_summary"&gt;&lt;strong&gt;Report summary:&lt;/strong&gt; Produces a count of borrowers based on their account expired attribute.&lt;/p&gt;

  &lt;/div&gt;

  &lt;div class="accordion accordion-flush"&gt;



&lt;!-- Function section --&gt;
    &lt;div id="accordion_3929-1" class="accordion-item next_report_function"&gt;

      &lt;h2 class="accordion-header" id="panelsStay_3929Open-headingOne" &gt;

        &lt;button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3929Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3929Open-collapseOne"&gt;

          Function:

        &lt;/button&gt;

      &lt;/h2&gt;

      &lt;div id="panelsStay_3929Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3929Open-headingOne"&gt;
        &lt;div class="accordion-body"&gt;

          &lt;div id="function_section" class="report_section"&gt;


            &lt;p&gt;This report produces a count of borrowers&lt;/p&gt;
            &lt;ul&gt;

              &lt;li&gt;Counts borrowers currently in the system&lt;/li&gt;

              &lt;li&gt;At the library you specify&lt;/li&gt;

              &lt;li&gt;Grouped by borrower's home branch and category code&lt;/li&gt;

              &lt;li&gt;Sorted by borrower's home branch and category code&lt;/li&gt;

              &lt;li&gt;Contains links to report 3000 - Borrower list by expired attribute&lt;/li&gt;
            &lt;/ul&gt;


            &lt;span style="display: none;"&gt;
            &lt;p&gt; - &lt;/p&gt;
            &lt;/span&gt;

          &lt;/div&gt;

        &lt;/div&gt;
      &lt;/div&gt;

    &lt;/div&gt;



&lt;!-- Notes section --&gt;
    &lt;div id="accordion_REPORTID-2" class="accordion-item next_report_notes report_hidden"&gt;

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

          &lt;div id="notes_1" class="report_section report_hidden"&gt;
            &lt;h4&gt; NOTE_ONE_TITLE &lt;/h4&gt;
            &lt;p&gt; NOTE_ONE_CONTENT &lt;/p&gt;
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
    &lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=3929" class="direct_download_btn"&gt;Download directly to a CSV file&lt;/a&gt;&lt;/p&gt;
  &lt;/div&gt;



&lt;!-- Hashtag section --&gt;
  &lt;div class="next_report_hashtags" style="display: none;"&gt;
    &lt;p&gt;#borrower count&lt;/p&gt;
    &lt;p&gt;#&lt;/p&gt;
    &lt;p&gt;#&lt;/p&gt;
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
  branches.branchname,
  categories.description,
  Coalesce(expired_account.lib, '-- Active borrowers --') As 'Expiration attribute',
  Count(borrowers.cardnumber) As 'Number of users',
  Concat( 
      'Attribute report' 
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
  borrowers.branchcode Like &lt;&gt;
Group By
  borrowers.branchcode,
  borrowers.categorycode,
  Coalesce(expired_account.lib, '')

























