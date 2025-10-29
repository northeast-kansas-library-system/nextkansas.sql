/*
R.003909

----------

Name: Accordion testing
Created by: George Williams

----------

Group: -
     -

Created on: 2025-08-22 23:30:11
Modified on: 2025-10-16 00:43:37
Date last run: 2025-10-16 00:43:37

----------

Public: 0
Expiry: 300

----------

<div class="next_report_info next_noprint">

  <style>
    .accordion .accordion-button{font-size: 1.1em !important; color: white !important; font-weight: 900;}
    .next_report_function .accordion-header * {background-color: #DF6320 !important; color: #ffffff !important;}
    .next_report_notes .accordion-header * {background-color: #DFC220 !important; color: #000000 !important;}
    .next_report_instructions .accordion-header * {background-color: #3DDF20 !important; color: #000000 !important;}
    .next_report_resources .accordion-header * {background-color: #1f9bde !important; color: #ffffff !important;}
    .next_report_training .accordion-header * {background-color: #6320DF !important; color: #ffffff !important;}
    .accordion-collapse.collapse * {background-color: #e6e6e6 !important; color: #000000 !important;}
  </style>

  <div class="next_report_summary">
    <p>Report summary</p>
  </div>





  <div class="accordion accordion-flush">

    <div id="accordion-1" class="accordion-item next_report_function">
  
      <h2 class="accordion-header" id="panelsStayOpen-headingOne" >
  
        <button class="accordion-button" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true"
          aria-controls="panelsStayOpen-collapseOne">
  
          Function:
  
        </button>
  
      </h2>
  
      <div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show"
        aria-labelledby="panelsStayOpen-headingOne">
        <div class="accordion-body">
  
          <h1>Accordion content 1</h1>
  
        </div>
      </div>
  
    </div>
  
    <div id="accordion-2" class="accordion-item next_report_notes" style="">
  
      <h2 class="accordion-header" id="panelsStayOpen-headingTwo">
  
        <button class="accordion-button collapsed next_report_notes" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="false"
          aria-controls="panelsStayOpen-collapseTwo">
  
          Notes:
  
        </button>
  
      </h2>
  
      <div id="panelsStayOpen-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStayOpen-headingTwo">
        <div class="accordion-body">
  
          <h1>Accordion content 2</h1>
  
        </div>
      </div>
  
    </div>
  
    <div id="accordion-3" class="accordion-item next_report_instructions" style="">
  
      <h2 class="accordion-header" id="panelsStayOpen-headingThree">
  
        <button class="accordion-button collapsed next_report_notes" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="false"
          aria-controls="panelsStayOpen-collapseThree">
  
          Instructions:
  
        </button>
  
      </h2>
  
      <div id="panelsStayOpen-collapseThree" class="accordion-collapse collapse"
        aria-labelledby="panelsStayOpen-headingThree">
        <div class="accordion-body">
  
          <h1>Accordion content 3</h1>
  
        </div>
      </div>
  
    </div>

    <div id="accordion-4" class="accordion-item next_report_resources" style="">
  
      <h2 class="accordion-header" id="panelsStayOpen-headingFour">
  
        <button class="accordion-button collapsed next_report_notes" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStayOpen-collapseFour" aria-expanded="false"
          aria-controls="panelsStayOpen-collapseFour">
  
          Resources:
  
        </button>
  
      </h2>
  
      <div id="panelsStayOpen-collapseFour" class="accordion-collapse collapse"
        aria-labelledby="panelsStayOpen-headingFour">
        <div class="accordion-body">
  
          <h1>Accordion content 4</h1>
  
        </div>
      </div>
  
    </div>

    <div id="accordion-5" class="accordion-item next_report_training">
  
      <h2 class="accordion-header" id="panelsStayOpen-headingFive">
  
        <button class="accordion-button collapsed next_report_notes" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStayOpen-collapseFive" aria-expanded="false"
          aria-controls="panelsStayOpen-collapseFive">
  
          Training
  
        </button>
  
      </h2>
  
      <div id="panelsStayOpen-collapseFive" class="accordion-collapse collapse"
        aria-labelledby="panelsStayOpen-headingFive" style="color: white !important;">
        <div class="accordion-body">
  
          <h1>Training</h1>
  
        </div>
      </div>
  
    </div>

  </div>

  <div class="next_report_direct_download">
    <p>direct download</p>
  </div>

  <div class="next_report_hashtags">
    <p>hashtags</p>
  </div>







</div>

----------
*/



Select
  Concat( 
    'Go to title',
    '', 
    'Edit item' 
  ) AS LINKS,
  If(coalesce(items.dateaccessioned, '1900-01-01') < '2000-01-01', '2000-01-01', DATE_FORMAT(items.dateaccessioned, '%Y-%m-%d')) AS DATE_ADDED,
  Count(items.itemnumber) As Count_itemnumber
From
  items
Group By
  If(coalesce(items.dateaccessioned, '1900-01-01') < '2000-01-01', '2000-01-01', DATE_FORMAT(items.dateaccessioned, '%Y-%m-%d'))
Order By
  If(coalesce(items.dateaccessioned, '1900-01-01') < '2000-01-01', '2000-01-01', DATE_FORMAT(items.dateaccessioned, '%Y-%m-%d')) ASC

























