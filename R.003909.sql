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

&lt;div class="next_report_info next_noprint"&gt;

  &lt;style&gt;
    .accordion .accordion-button{font-size: 1.1em !important; color: white !important; font-weight: 900;}
    .next_report_function .accordion-header * {background-color: #DF6320 !important; color: #ffffff !important;}
    .next_report_notes .accordion-header * {background-color: #DFC220 !important; color: #000000 !important;}
    .next_report_instructions .accordion-header * {background-color: #3DDF20 !important; color: #000000 !important;}
    .next_report_resources .accordion-header * {background-color: #1f9bde !important; color: #ffffff !important;}
    .next_report_training .accordion-header * {background-color: #6320DF !important; color: #ffffff !important;}
    .accordion-collapse.collapse * {background-color: #e6e6e6 !important; color: #000000 !important;}
  &lt;/style&gt;

  &lt;div class="next_report_summary"&gt;
    &lt;p&gt;Report summary&lt;/p&gt;
  &lt;/div&gt;





  &lt;div class="accordion accordion-flush"&gt;

    &lt;div id="accordion-1" class="accordion-item next_report_function"&gt;
  
      &lt;h2 class="accordion-header" id="panelsStayOpen-headingOne" &gt;
  
        &lt;button class="accordion-button" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true"
          aria-controls="panelsStayOpen-collapseOne"&gt;
  
          Function:
  
        &lt;/button&gt;
  
      &lt;/h2&gt;
  
      &lt;div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show"
        aria-labelledby="panelsStayOpen-headingOne"&gt;
        &lt;div class="accordion-body"&gt;
  
          &lt;h1&gt;Accordion content 1&lt;/h1&gt;
  
        &lt;/div&gt;
      &lt;/div&gt;
  
    &lt;/div&gt;
  
    &lt;div id="accordion-2" class="accordion-item next_report_notes" style=""&gt;
  
      &lt;h2 class="accordion-header" id="panelsStayOpen-headingTwo"&gt;
  
        &lt;button class="accordion-button collapsed next_report_notes" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="false"
          aria-controls="panelsStayOpen-collapseTwo"&gt;
  
          Notes:
  
        &lt;/button&gt;
  
      &lt;/h2&gt;
  
      &lt;div id="panelsStayOpen-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStayOpen-headingTwo"&gt;
        &lt;div class="accordion-body"&gt;
  
          &lt;h1&gt;Accordion content 2&lt;/h1&gt;
  
        &lt;/div&gt;
      &lt;/div&gt;
  
    &lt;/div&gt;
  
    &lt;div id="accordion-3" class="accordion-item next_report_instructions" style=""&gt;
  
      &lt;h2 class="accordion-header" id="panelsStayOpen-headingThree"&gt;
  
        &lt;button class="accordion-button collapsed next_report_notes" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="false"
          aria-controls="panelsStayOpen-collapseThree"&gt;
  
          Instructions:
  
        &lt;/button&gt;
  
      &lt;/h2&gt;
  
      &lt;div id="panelsStayOpen-collapseThree" class="accordion-collapse collapse"
        aria-labelledby="panelsStayOpen-headingThree"&gt;
        &lt;div class="accordion-body"&gt;
  
          &lt;h1&gt;Accordion content 3&lt;/h1&gt;
  
        &lt;/div&gt;
      &lt;/div&gt;
  
    &lt;/div&gt;

    &lt;div id="accordion-4" class="accordion-item next_report_resources" style=""&gt;
  
      &lt;h2 class="accordion-header" id="panelsStayOpen-headingFour"&gt;
  
        &lt;button class="accordion-button collapsed next_report_notes" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStayOpen-collapseFour" aria-expanded="false"
          aria-controls="panelsStayOpen-collapseFour"&gt;
  
          Resources:
  
        &lt;/button&gt;
  
      &lt;/h2&gt;
  
      &lt;div id="panelsStayOpen-collapseFour" class="accordion-collapse collapse"
        aria-labelledby="panelsStayOpen-headingFour"&gt;
        &lt;div class="accordion-body"&gt;
  
          &lt;h1&gt;Accordion content 4&lt;/h1&gt;
  
        &lt;/div&gt;
      &lt;/div&gt;
  
    &lt;/div&gt;

    &lt;div id="accordion-5" class="accordion-item next_report_training"&gt;
  
      &lt;h2 class="accordion-header" id="panelsStayOpen-headingFive"&gt;
  
        &lt;button class="accordion-button collapsed next_report_notes" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStayOpen-collapseFive" aria-expanded="false"
          aria-controls="panelsStayOpen-collapseFive"&gt;
  
          Training
  
        &lt;/button&gt;
  
      &lt;/h2&gt;
  
      &lt;div id="panelsStayOpen-collapseFive" class="accordion-collapse collapse"
        aria-labelledby="panelsStayOpen-headingFive" style="color: white !important;"&gt;
        &lt;div class="accordion-body"&gt;
  
          &lt;h1&gt;Training&lt;/h1&gt;
  
        &lt;/div&gt;
      &lt;/div&gt;
  
    &lt;/div&gt;

  &lt;/div&gt;

  &lt;div class="next_report_direct_download"&gt;
    &lt;p&gt;direct download&lt;/p&gt;
  &lt;/div&gt;

  &lt;div class="next_report_hashtags"&gt;
    &lt;p&gt;hashtags&lt;/p&gt;
  &lt;/div&gt;







&lt;/div&gt;

----------
*/



Select
  Concat( 
    'Go to title',
    '', 
    'Edit item' 
  ) AS LINKS,
  If(coalesce(items.dateaccessioned, '1900-01-01') &lt; '2000-01-01', '2000-01-01', DATE_FORMAT(items.dateaccessioned, '%Y-%m-%d')) AS DATE_ADDED,
  Count(items.itemnumber) As Count_itemnumber
From
  items
Group By
  If(coalesce(items.dateaccessioned, '1900-01-01') &lt; '2000-01-01', '2000-01-01', DATE_FORMAT(items.dateaccessioned, '%Y-%m-%d'))
Order By
  If(coalesce(items.dateaccessioned, '1900-01-01') &lt; '2000-01-01', '2000-01-01', DATE_FORMAT(items.dateaccessioned, '%Y-%m-%d')) ASC

























