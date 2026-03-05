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

<div class="next_report_info next_noprint">

  <style>
    
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

  <div class="next_report_summary">
    <br>
    <label for="report_name">Report name:</label>
    <p id="report_name">REPORT_NAME</p>
    <label for="report_author">Report author/source:</label>
    <p id="report_author">REPORT_AUTHOR</p>
    <label for="report_summary">Report summary:</label>
    <p id="report_summary">REPORT_SUMMARY</p>
  </div>

  <div class="accordion accordion-flush">

    <div id="accordion_REPORTID-1" class="accordion-item next_report_function">
  
      <h2 class="accordion-header" id="panelsStay_REPORTIDOpen-headingOne" >
  
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_REPORTIDOpen-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_REPORTIDOpen-collapseOne">
  
          Function:
  
        </button>
  
      </h2>
  
      <div id="panelsStay_REPORTIDOpen-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_REPORTIDOpen-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">
  
            <h3>Report function:</h3>

            <p>FUNCTION_SUMMARY</p>
            <ul>
              <li>WHEN</li>
              <li>WHOSE_STUFF</li>
              <li>GROUPED_BY</li>
              <li>SORTED_BY</li>
              <li>LINKS</li>
            </ul>

            <p>OPTIONAL_SUMMARY_NOTES</p>

          </div>
  
        </div>
      </div>
  
    </div>
  
    <div id="accordion_REPORTID-2" class="accordion-item next_report_notes" style="">
  
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
  
          <h3>Notes about this report:</h3>

          <div id="notes_1" class="report_section">

            <h4>NOTE_1_TITLE</h4>

            <p>NOTE_1_CONTENT</p>

          </div>

          <div id="notes_2" class="report_section">

            <h4>NOTE_2_TITLE</h4>

            <p>NOTE_2_CONTENT</p>

          </div>

          <div id="notes_3" class="report_section">

            <h4>NOTE_3_TITLE</h4>

            <p>NOTE_3_CONTENT</p>

          </div>

          <div id="notes_4" class="report_section">

            <h4>NOTE_4_TITLE</h4>

            <p>NOTE_4_CONTENT</p>

          </div>

          <div id="notes_5" class="report_section">

            <h4>NOTE_5_TITLE</h4>

            <p>NOTE_5_CONTENT</p>

          </div>

        </div>
      </div>
  
    </div>
  
    <div id="accordion_REPORTID-3" class="accordion-item next_report_instructions" style="">
  
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
  
          <h3>Instructions:</h3>

          <div id="instructions_1" class="report_section">

            <h4>INSTRUCTION_1_TITLE</h4>

            <p>INSTRUCTION_1_CONTENT</p>

          </div>

          <div id="instructions_2" class="report_section">

            <h4>INSTRUCTION_2_TITLE</h4>

            <p>INSTRUCTION_2_CONTENT</p>

          </div>

          <div id="instructions_3" class="report_section">

            <h4>INSTRUCTION_3_TITLE</h4>

            <p>INSTRUCTION_3_CONTENT</p>

          </div>

          <div id="instructions_4" class="report_section">

            <h4>INSTRUCTION_4_TITLE</h4>

            <p>INSTRUCTION_4_CONTENT</p>

          </div>

          <div id="instructions_5" class="report_section">

            <h4>INSTRUCTION_5_TITLE</h4>

            <p>INSTRUCTION_5_CONTENT</p>

          </div>
  
        </div>
      </div>
  
    </div>

    <div id="accordion_REPORTID-4" class="accordion-item next_report_resources" style="">
  
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
  
          <h3>Resources</h3>

          <div id="resources_1" class="report_section">

            <p><a href="RESOURCE_URL_1" target="_blank" class="resources_btn">RESOURCE_TITLE_1</a></p>

            <p>RESOURCE_NOTE_1</p>

          </div>

          <div id="resources_2" class="report_section">

            <p><a href="RESOURCE_URL_2" target="_blank" class="resources_btn">RESOURCE_TITLE_2</a></p>

            <p>RESOURCE_NOTE_2</p>

          </div>

          <div id="resources_3" class="report_section">

            <p><a href="RESOURCE_URL_3" target="_blank" class="resources_btn">RESOURCE_TITLE_3</a></p>

            <p>RESOURCE_NOTE_3</p>

          </div>

          <div id="resources_4" class="report_section">

            <p><a href="RESOURCE_URL_4" target="_blank" class="resources_btn">RESOURCE_TITLE_4</a></p>

            <p>RESOURCE_NOTE_4</p>

          </div>

          <div id="resources_5" class="report_section">

            <p><a href="RESOURCE_URL_5" target="_blank" class="resources_btn">RESOURCE_TITLE_5</a></p>

            <p>RESOURCE_NOTE_5</p>

          </div>
  
        </div>
      </div>
  
    </div>

    <div id="accordion_REPORTID-5" class="accordion-item next_report_training">
  
      <h2 class="accordion-header" id="panelsStay_REPORTIDOpen-headingFive">
  
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_REPORTIDOpen-collapseFive" aria-expanded="false"
          aria-controls="panelsStay_REPORTIDOpen-collapseFive">
  
          Training
  
        </button>
  
      </h2>
  
      <div id="panelsStay_REPORTIDOpen-collapseFive" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_REPORTIDOpen-headingFive" style="color: white !important;">
        <div class="accordion-body">
  
          <h3>Training</h3>

          <div id="training_link" class="report_section">

            <p><a href="TRAINING_LINK_URL" target="_blank" class="training_btn">TRAINING_LINK_TITLE</a></p>

            <p>TRAINING_LINK_NOTES</p>

          </div>

          <div id="training_handout" class="report_section" >

            <p><a href="TRAINING_HANDOUT_URL" target="_blank" class="training_btn">TRAINING_HANDOUT_TITLE</a></p>

            <p>TRAINING_HANDOUT_NOTES</p>

          </div>

          <div id="training_video" class="report_section">

            <p><a href="TRAINING_VIDEO_URL" target="_blank" class="training_btn">TRAINING_VIDEO_TITLE</a></p>

            <p>TRAINING_VIDEO_NOTES</p>

          </div>
  
        </div>
      </div>
  
    </div>

  </div>

  <div class="next_report_direct_download" class="report_section">
    <p><a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=REPORTID" class="direct_download_btn">Download directly to a CSV file</a></p>
  </div>

  <div class="next_report_hashtags" style="display: none;">
    <p>HASHTAG_01</p>
    <p>HASHTAG_02</p>
    <p>HASHTAG_03</p>
    <p>HASHTAG_04</p>
    <p>HASHTAG_05</p>
    <p>HASHTAG_06</p>
    <p>HASHTAG_07</p>
    <p>HASHTAG_08</p>
    <p>HASHTAG_09</p>
    <p>HASHTAG_10</p>
  </div>

</div>


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

























