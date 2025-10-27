/*
R.003039

----------

Name: GHW - Flexible requests history report
Created by: George Williams

----------

Group: Holds-Reserves
     -

Created on: 2018-01-16 15:28:12
Modified on: 2025-10-27 10:29:51
Date last run: 2025-10-27 10:28:16

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
    &lt;p id="report_name"&gt;Flexible requests history&lt;/p&gt;
    &lt;label for="report_author"&gt;Report author/source:&lt;/label&gt;
    &lt;p id="report_author"&gt;GHW&lt;/p&gt;
    &lt;label for="report_summary"&gt;Report summary:&lt;/label&gt;
    &lt;p id="report_summary"&gt;Generates a screen readable report of current and past request information based on very flexible parameters&lt;/p&gt;
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

            &lt;p&gt;Shows the history of any active, filled, and cancelled requests in Next Search Catalog&lt;/p&gt;
            &lt;ul&gt;
              &lt;li&gt;Shows data currently in the reserves or oldreserves tables from the previous 25 months&lt;/li&gt;
              &lt;li&gt;at all pickup libraries or at the pickup library you specify&lt;/li&gt;
              &lt;li&gt;with the request status and progress that you specify&lt;/li&gt;
              &lt;li&gt;with the hold suspension status you specify&lt;/li&gt;
              &lt;li&gt;and with the library card, biblionumber, or item barcode number you specify&lt;/li&gt;
              &lt;li&gt;grouped by reserve ID number&lt;/li&gt;
              &lt;li&gt;sorted by the last time the request was updated&lt;/li&gt;
              &lt;li&gt;contains links to the action logs, the patron record, the bibliographic record, and the item's in transit history&lt;/li&gt;
            &lt;/ul&gt;

            &lt;p class="report_hidden"&gt;OPTIONAL_SUMMARY_NOTES&lt;/p&gt;

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

            &lt;h4&gt;Links to other reports&lt;/h4&gt;

            &lt;p&gt;
              Contains active links to other reports:
              &lt;ul&gt;
                &lt;li&gt;3040&lt;/li&gt;
                &lt;li&gt;2784&lt;/li&gt;
              &lt;/ul&gt;
             &lt;/p&gt;

          &lt;/div&gt;

          &lt;div id="notes_2" class="report_section"&gt;

            &lt;h4&gt;Dependencies&lt;/h4&gt;

            &lt;p&gt;
              This report relies on specialized authorized values tables:
              &lt;ul&gt;
                &lt;li&gt;LHOLDACT&lt;/li&gt;
                &lt;li&gt;LHOLDPROG&lt;/li&gt;
                &lt;li&gt;LHOLDSUS&lt;/li&gt;
              &lt;/ul&gt;
            &lt;/p&gt;

          &lt;/div&gt;

          &lt;div id="notes_3" class="report_section report_hidden"&gt;

            &lt;h4&gt;NOTE_3_TITLE&lt;/h4&gt;

            &lt;p&gt;NOTE_3_CONTENT&lt;/p&gt;

          &lt;/div&gt;

          &lt;div id="notes_4" class="report_section report_hidden"&gt;

            &lt;h4&gt;NOTE_4_TITLE&lt;/h4&gt;

            &lt;p&gt;NOTE_4_CONTENT&lt;/p&gt;

          &lt;/div&gt;

          &lt;div id="notes_5" class="report_section report_hidden"&gt;

            &lt;h4&gt;NOTE_5_TITLE&lt;/h4&gt;

            &lt;p&gt;NOTE_5_CONTENT&lt;/p&gt;

          &lt;/div&gt;

        &lt;/div&gt;
      &lt;/div&gt;
  
    &lt;/div&gt;
  
    &lt;div id="accordion_REPORTID-3" class="accordion-item next_report_instructions report_hidden" style=""&gt;
  
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

    &lt;div id="accordion_REPORTID-4" class="accordion-item next_report_resources report_hidden" style=""&gt;
  
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

    &lt;div id="accordion_REPORTID-5" class="accordion-item next_report_training report_hidden"&gt;
  
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

  &lt;div class="next_report_direct_download report_section report_hidden"&gt;
    &lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=3039" class="direct_download_btn"&gt;Download directly to a CSV file&lt;/a&gt;&lt;/p&gt;
  &lt;/div&gt;

  &lt;div class="next_report_hashtags" style="display: none;"&gt;
    &lt;p&gt;#flexible&lt;/p&gt;
    &lt;p&gt;#requests&lt;/p&gt;
    &lt;p&gt;#confidential&lt;/p&gt;
    &lt;p&gt;#history&lt;/p&gt;
    &lt;p&gt;#holds&lt;/p&gt;
    &lt;p&gt;&lt;/p&gt;
    &lt;p&gt;&lt;/p&gt;
    &lt;p&gt;&lt;/p&gt;
    &lt;p&gt;&lt;/p&gt;
    &lt;p&gt;&lt;/p&gt;
  &lt;/div&gt;

&lt;/div&gt;


----------
*/



SELECT 
  requests.reserve_id, 
  Concat( 
    'Status: ', 
    requests.statuss, 
    ' Progress: ', 
    If( 
      requests.cancellationdate IS NOT NULL, 
      'Cancelled', 
      If( 
        requests.found = 'T', 
        'In transit', 
        If( 
          requests.found = 'F', 
          'Finished / Filled', 
          If( 
            requests.found = 'W', 
            'Waiting for pickup', 
            'Still active' 
          ) 
        ) 
      ) 
    ) 
  ) AS STATUS, 
  Concat('Patron BC: ', borrowers.cardnumber, '', 'Pickup at: ', requests.branchcode) AS PATRON_INFO, 
  Concat_Ws('', 
    Concat('Requested on: ', requests.reservedate), Concat('Waiting since: ', requests.waitingdate), 
    Concat('Expires on: ', requests.expirationdate), Concat('Cancelled on: ', requests.cancellationdate), 
    Concat('Updated on: ', requests.timestamp)) AS DATES, 
  Concat_Ws( 
    '', 
    If(requests.suspend &lt;&gt; 0, 'Suspended', '-'), 
    If( 
      requests.suspend = 0, 
      '-', 
      If( 
        requests.suspend_until IS NOT NULL, 
        Concat('until ', Date_Format(requests.suspend_until, '%Y.%m.%d')), 
        'indefinitely' 
      ) 
    ) 
  ) AS SUSPENDED, 
  requests.biblionumber AS BIBLIO_NUMBER, 
  Concat_Ws('', 
    Concat( 
      'BC: ', 
      Coalesce(Coalesce(items.barcode, '-'), Coalesce(deleteditems.barcode, '-')) 
    ), 
    Concat( 
      'Home: ', 
      Coalesce(Coalesce(items.homebranch, '-'), Coalesce(deleteditems.homebranch, '-')) 
    ), 
    Concat( 
      'Location: ', 
      Coalesce(Coalesce(items.location, '-'), Coalesce(deleteditems.location, '-')) 
    ), 
    Concat( 
      'Type: ', 
      Coalesce(Coalesce(items.itype, '-'), Coalesce(deleteditems.itype, '-')) 
    ), 
    Concat( 
      'Collection: ', 
      Coalesce(Coalesce(items.ccode, '-'), Coalesce(deleteditems.ccode, '-')) 
    ), 
    Concat( 
      'Call#: ', 
      Coalesce(Coalesce(items.itemcallnumber, '-'), Coalesce(deleteditems.itemcallnumber, '-')) 
    ), 
    Concat( 
      'Author: ', 
      Coalesce(Coalesce(biblio.author, '-'), Coalesce(deletedbiblio.author, '-')) 
    ), 
    Concat( 
      'Title: ', 
      Coalesce(Coalesce(biblio.title, '-'), Coalesce(deletedbiblio.title, '-')) 
      ) 
  ) AS ITEM_INFO, 
  CONCAT_WS('', 
    Concat( 
      'Action logs: ', 
      Concat( 
        'see last 60 days of activity' 
      ) 
    ), 
    Concat( 
      'Link to patron: ', 
      Concat('go to the borrower"s record' 
      ) 
    ), 
    Concat( 
      'Link to title: ', 
      Concat('go to the bibliographic record' 
      ) 
    ), 
    Concat( 
      'Link to item: ', 
      Concat('go to the item record' 
      ) 
    ), 
    Concat( 
      'Item in transit history: ', 
      Concat('see item transit history' 
      ) 
    ) 
) AS LINKS 
FROM 
  borrowers 
  JOIN (SELECT 
        reserves.reserve_id, 
        reserves.borrowernumber, 
        reserves.reservedate, 
        reserves.biblionumber, 
        reserves.branchcode, 
        reserves.notificationdate, 
        reserves.reminderdate, 
        reserves.cancellationdate, 
        reserves.reservenotes, 
        reserves.priority, 
        reserves.found, 
        reserves.timestamp, 
        reserves.itemnumber, 
        reserves.waitingdate, 
        reserves.expirationdate, 
        reserves.lowestPriority, 
        reserves.suspend, 
        reserves.suspend_until, 
        reserves.itemtype, 
        If(reserves.reserve_id IS NOT NULL, 'Active', '-') AS statuss 
      FROM 
        reserves 
      UNION 
      SELECT 
        old_reserves.reserve_id, 
        old_reserves.borrowernumber, 
        old_reserves.reservedate, 
        old_reserves.biblionumber, 
        old_reserves.branchcode, 
        old_reserves.notificationdate, 
        old_reserves.reminderdate, 
        old_reserves.cancellationdate, 
        old_reserves.reservenotes, 
        old_reserves.priority, 
        old_reserves.found, 
        old_reserves.timestamp, 
        old_reserves.itemnumber, 
        old_reserves.waitingdate, 
        old_reserves.expirationdate, 
        old_reserves.lowestPriority, 
        old_reserves.suspend, 
        old_reserves.suspend_until, 
        old_reserves.itemtype, 
        If(old_reserves.cancellationdate IS NOT NULL, 'Cancelled', 'Finished / Filled') AS statuss 
      FROM 
        old_reserves) requests ON borrowers.borrowernumber = requests.borrowernumber 
  LEFT JOIN items ON requests.itemnumber = items.itemnumber 
  LEFT JOIN deleteditems ON requests.itemnumber = deleteditems.itemnumber 
  LEFT JOIN biblio ON requests.biblionumber = biblio.biblionumber 
  LEFT JOIN deletedbiblio ON requests.biblionumber = deletedbiblio.biblionumber 
WHERE 
  requests.branchcode LIKE &lt;&gt; AND 
  requests.statuss LIKE &lt;&gt; AND 
  If( 
    requests.cancellationdate IS NOT NULL, 
    'Cancelled', 
    If( 
      requests.found = 'T', 'In transit', 
      If( 
        requests.found = 'F', 'Finished', 
        If( 
          requests.found = 'W', 
          'Waiting for pickup', 
          'Still active' 
        ) 
      ) 
    ) 
  ) LIKE &lt;&gt; AND 
  If(requests.suspend &lt;&gt; 0, 'Suspended', '-') LIKE &lt;&gt; AND 
  borrowers.cardnumber LIKE Concat('%', &lt;&gt;, '%') AND 
  requests.biblionumber LIKE Concat('%', &lt;&gt;, '%') AND 
  Coalesce( 
    Coalesce(items.barcode, '-'), Coalesce(deleteditems.barcode, '-') 
  ) LIKE Concat('%', &lt;&gt;, '%') 
GROUP BY 
  requests.reserve_id 
ORDER BY 
  requests.timestamp DESC 

























