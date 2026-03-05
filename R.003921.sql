/*
R.003921

----------

Name: Accordion test 1
Created by: George Williams

----------

Group: -
     -

Created on: 2025-10-19 12:27:33
Modified on: 2025-10-22 10:04:41
Date last run: 2025-10-22 10:04:41

----------

Public: 0
Expiry: 300

----------

&lt;div class="next_report_info next_noprint"&gt;

  &lt;style&gt;
    
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

  &lt;div class="next_report_summary"&gt;
    &lt;br&gt;
    &lt;label for="report_name"&gt;Report name:&lt;/label&gt;
    &lt;p id="report_name"&gt;REPORT_NAME&lt;/p&gt;
    &lt;label for="report_author"&gt;Report author/source:&lt;/label&gt;
    &lt;p id="report_author"&gt;REPORT_AUTHOR&lt;/p&gt;
    &lt;label for="report_summary"&gt;Report summary:&lt;/label&gt;
    &lt;p id="report_summary"&gt;REPORT_SUMMARY&lt;/p&gt;
  &lt;/div&gt;

  &lt;div class="accordion accordion-flush"&gt;

    &lt;div id="accordion_REPORTID-1" class="accordion-item next_report_function"&gt;
  
      &lt;h2 class="accordion-header" id="panelsStay_REPORTIDOpen-headingOne" &gt;
  
        &lt;button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_REPORTIDOpen-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_REPORTIDOpen-collapseOne"&gt;
  
          Function:
  
        &lt;/button&gt;
  
      &lt;/h2&gt;
  
      &lt;div id="panelsStay_REPORTIDOpen-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_REPORTIDOpen-headingOne"&gt;
        &lt;div class="accordion-body"&gt;

          &lt;div id="function_section" class="report_section"&gt;
  
            &lt;h3&gt;Report function:&lt;/h3&gt;

            &lt;p&gt;FUNCTION_SUMMARY&lt;/p&gt;
            &lt;ul&gt;
              &lt;li&gt;WHEN&lt;/li&gt;
              &lt;li&gt;WHOSE_STUFF&lt;/li&gt;
              &lt;li&gt;GROUPED_BY&lt;/li&gt;
              &lt;li&gt;SORTED_BY&lt;/li&gt;
              &lt;li&gt;LINKS&lt;/li&gt;
            &lt;/ul&gt;

            &lt;p&gt;OPTIONAL_SUMMARY_NOTES&lt;/p&gt;

          &lt;/div&gt;
  
        &lt;/div&gt;
      &lt;/div&gt;
  
    &lt;/div&gt;
  
    &lt;div id="accordion_REPORTID-2" class="accordion-item next_report_notes" style=""&gt;
  
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
  
          &lt;h3&gt;Notes about this report:&lt;/h3&gt;

          &lt;div id="notes_1" class="report_section"&gt;

            &lt;h4&gt;NOTE_1_TITLE&lt;/h4&gt;

            &lt;p&gt;NOTE_1_CONTENT&lt;/p&gt;

          &lt;/div&gt;

          &lt;div id="notes_2" class="report_section"&gt;

            &lt;h4&gt;NOTE_2_TITLE&lt;/h4&gt;

            &lt;p&gt;NOTE_2_CONTENT&lt;/p&gt;

          &lt;/div&gt;

          &lt;div id="notes_3" class="report_section"&gt;

            &lt;h4&gt;NOTE_3_TITLE&lt;/h4&gt;

            &lt;p&gt;NOTE_3_CONTENT&lt;/p&gt;

          &lt;/div&gt;

          &lt;div id="notes_4" class="report_section"&gt;

            &lt;h4&gt;NOTE_4_TITLE&lt;/h4&gt;

            &lt;p&gt;NOTE_4_CONTENT&lt;/p&gt;

          &lt;/div&gt;

          &lt;div id="notes_5" class="report_section"&gt;

            &lt;h4&gt;NOTE_5_TITLE&lt;/h4&gt;

            &lt;p&gt;NOTE_5_CONTENT&lt;/p&gt;

          &lt;/div&gt;

        &lt;/div&gt;
      &lt;/div&gt;
  
    &lt;/div&gt;
  
    &lt;div id="accordion_REPORTID-3" class="accordion-item next_report_instructions" style=""&gt;
  
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
  
          &lt;h3&gt;Instructions:&lt;/h3&gt;

          &lt;div id="instructions_1" class="report_section"&gt;

            &lt;h4&gt;INSTRUCTION_1_TITLE&lt;/h4&gt;

            &lt;p&gt;INSTRUCTION_1_CONTENT&lt;/p&gt;

          &lt;/div&gt;

          &lt;div id="instructions_2" class="report_section"&gt;

            &lt;h4&gt;INSTRUCTION_2_TITLE&lt;/h4&gt;

            &lt;p&gt;INSTRUCTION_2_CONTENT&lt;/p&gt;

          &lt;/div&gt;

          &lt;div id="instructions_3" class="report_section"&gt;

            &lt;h4&gt;INSTRUCTION_3_TITLE&lt;/h4&gt;

            &lt;p&gt;INSTRUCTION_3_CONTENT&lt;/p&gt;

          &lt;/div&gt;

          &lt;div id="instructions_4" class="report_section"&gt;

            &lt;h4&gt;INSTRUCTION_4_TITLE&lt;/h4&gt;

            &lt;p&gt;INSTRUCTION_4_CONTENT&lt;/p&gt;

          &lt;/div&gt;

          &lt;div id="instructions_5" class="report_section"&gt;

            &lt;h4&gt;INSTRUCTION_5_TITLE&lt;/h4&gt;

            &lt;p&gt;INSTRUCTION_5_CONTENT&lt;/p&gt;

          &lt;/div&gt;
  
        &lt;/div&gt;
      &lt;/div&gt;
  
    &lt;/div&gt;

    &lt;div id="accordion_REPORTID-4" class="accordion-item next_report_resources" style=""&gt;
  
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
  
          &lt;h3&gt;Resources&lt;/h3&gt;

          &lt;div id="resources_1" class="report_section"&gt;

            &lt;p&gt;&lt;a href="RESOURCE_URL_1" target="_blank" class="resources_btn"&gt;RESOURCE_TITLE_1&lt;/a&gt;&lt;/p&gt;

            &lt;p&gt;RESOURCE_NOTE_1&lt;/p&gt;

          &lt;/div&gt;

          &lt;div id="resources_2" class="report_section"&gt;

            &lt;p&gt;&lt;a href="RESOURCE_URL_2" target="_blank" class="resources_btn"&gt;RESOURCE_TITLE_2&lt;/a&gt;&lt;/p&gt;

            &lt;p&gt;RESOURCE_NOTE_2&lt;/p&gt;

          &lt;/div&gt;

          &lt;div id="resources_3" class="report_section"&gt;

            &lt;p&gt;&lt;a href="RESOURCE_URL_3" target="_blank" class="resources_btn"&gt;RESOURCE_TITLE_3&lt;/a&gt;&lt;/p&gt;

            &lt;p&gt;RESOURCE_NOTE_3&lt;/p&gt;

          &lt;/div&gt;

          &lt;div id="resources_4" class="report_section"&gt;

            &lt;p&gt;&lt;a href="RESOURCE_URL_4" target="_blank" class="resources_btn"&gt;RESOURCE_TITLE_4&lt;/a&gt;&lt;/p&gt;

            &lt;p&gt;RESOURCE_NOTE_4&lt;/p&gt;

          &lt;/div&gt;

          &lt;div id="resources_5" class="report_section"&gt;

            &lt;p&gt;&lt;a href="RESOURCE_URL_5" target="_blank" class="resources_btn"&gt;RESOURCE_TITLE_5&lt;/a&gt;&lt;/p&gt;

            &lt;p&gt;RESOURCE_NOTE_5&lt;/p&gt;

          &lt;/div&gt;
  
        &lt;/div&gt;
      &lt;/div&gt;
  
    &lt;/div&gt;

    &lt;div id="accordion_REPORTID-5" class="accordion-item next_report_training"&gt;
  
      &lt;h2 class="accordion-header" id="panelsStay_REPORTIDOpen-headingFive"&gt;
  
        &lt;button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_REPORTIDOpen-collapseFive" aria-expanded="false"
          aria-controls="panelsStay_REPORTIDOpen-collapseFive"&gt;
  
          Training
  
        &lt;/button&gt;
  
      &lt;/h2&gt;
  
      &lt;div id="panelsStay_REPORTIDOpen-collapseFive" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_REPORTIDOpen-headingFive" style="color: white !important;"&gt;
        &lt;div class="accordion-body"&gt;
  
          &lt;h3&gt;Training&lt;/h3&gt;

          &lt;div id="training_link" class="report_section"&gt;

            &lt;p&gt;&lt;a href="TRAINING_LINK_URL" target="_blank" class="training_btn"&gt;TRAINING_LINK_TITLE&lt;/a&gt;&lt;/p&gt;

            &lt;p&gt;TRAINING_LINK_NOTES&lt;/p&gt;

          &lt;/div&gt;

          &lt;div id="training_handout" class="report_section" &gt;

            &lt;p&gt;&lt;a href="TRAINING_HANDOUT_URL" target="_blank" class="training_btn"&gt;TRAINING_HANDOUT_TITLE&lt;/a&gt;&lt;/p&gt;

            &lt;p&gt;TRAINING_HANDOUT_NOTES&lt;/p&gt;

          &lt;/div&gt;

          &lt;div id="training_video" class="report_section"&gt;

            &lt;p&gt;&lt;a href="TRAINING_VIDEO_URL" target="_blank" class="training_btn"&gt;TRAINING_VIDEO_TITLE&lt;/a&gt;&lt;/p&gt;

            &lt;p&gt;TRAINING_VIDEO_NOTES&lt;/p&gt;

          &lt;/div&gt;
  
        &lt;/div&gt;
      &lt;/div&gt;
  
    &lt;/div&gt;

  &lt;/div&gt;

  &lt;div class="next_report_direct_download" class="report_section"&gt;
    &lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=REPORTID" class="direct_download_btn"&gt;Download directly to a CSV file&lt;/a&gt;&lt;/p&gt;
  &lt;/div&gt;

  &lt;div class="next_report_hashtags" style="display: none;"&gt;
    &lt;p&gt;HASHTAG_01&lt;/p&gt;
    &lt;p&gt;HASHTAG_02&lt;/p&gt;
    &lt;p&gt;HASHTAG_03&lt;/p&gt;
    &lt;p&gt;HASHTAG_04&lt;/p&gt;
    &lt;p&gt;HASHTAG_05&lt;/p&gt;
    &lt;p&gt;HASHTAG_06&lt;/p&gt;
    &lt;p&gt;HASHTAG_07&lt;/p&gt;
    &lt;p&gt;HASHTAG_08&lt;/p&gt;
    &lt;p&gt;HASHTAG_09&lt;/p&gt;
    &lt;p&gt;HASHTAG_10&lt;/p&gt;
  &lt;/div&gt;

&lt;/div&gt;


----------
*/



Select
  action_logs.action_id,
  action_logs.timestamp,
  action_logs.user,
  action_logs.module,
  action_logs.action,
  action_logs.object,
  action_logs.info,
  action_logs.interface,
  action_logs.script,
  action_logs.trace,
  action_logs.diff
From
  action_logs
ORDER BY
  action_logs.action_id DESC
LIMIT 10

























