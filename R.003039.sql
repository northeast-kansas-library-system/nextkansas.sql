/*
R.003039

----------

Name: GHW - Flexible requests history report
Created by: George Williams

----------

Group: Holds-Reserves
     -

Created on: 2018-01-16 15:28:12
Modified on: 2025-10-29 09:58:36
Date last run: 2026-07-29 16:28:31

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
    <p id="report_name">Flexible requests history</p>
    <label for="report_author">Report author/source:</label>
    <p id="report_author">GHW</p>
    <label for="report_summary">Report summary:</label>
    <p id="report_summary">Generates a screen readable report of current and past request information based on very flexible parameters</p>
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

            <p>Shows the history of any active, filled, and cancelled requests in Next Search Catalog</p>
            <ul>
              <li>Shows data currently in the reserves or oldreserves tables from the previous 25 months</li>
              <li>at all pickup libraries or at the pickup library you specify</li>
              <li>with the request status and progress that you specify</li>
              <li>with the hold suspension status you specify</li>
              <li>and with the library card, biblionumber, or item barcode number you specify</li>
              <li>grouped by reserve ID number</li>
              <li>sorted by the last time the request was updated</li>
              <li>contains links to the action logs, the patron record, the bibliographic record, and the item's in transit history</li>
            </ul>

            <p class="report_hidden">OPTIONAL_SUMMARY_NOTES</p>

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

            <h4>Links to other reports</h4>

            <p>
              Contains active links to other reports:
              <ul>
                <li>3040</li>
                <li>2784</li>
              </ul>
             </p>

          </div>

          <div id="notes_2" class="report_section">

            <h4>Dependencies</h4>

            <p>
              This report relies on specialized authorized values tables:
              <ul>
                <li>LHOLDACT</li>
                <li>LHOLDPROG</li>
                <li>LHOLDSUS</li>
              </ul>
            </p>

          </div>

          <div id="notes_3" class="report_section report_hidden">

            <h4>NOTE_3_TITLE</h4>

            <p>NOTE_3_CONTENT</p>

          </div>

          <div id="notes_4" class="report_section report_hidden">

            <h4>NOTE_4_TITLE</h4>

            <p>NOTE_4_CONTENT</p>

          </div>

          <div id="notes_5" class="report_section report_hidden">

            <h4>NOTE_5_TITLE</h4>

            <p>NOTE_5_CONTENT</p>

          </div>

        </div>
      </div>
  
    </div>
  
    <div id="accordion_REPORTID-3" class="accordion-item next_report_instructions report_hidden" style="">
  
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

    <div id="accordion_REPORTID-4" class="accordion-item next_report_resources report_hidden" style="">
  
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

    <div id="accordion_REPORTID-5" class="accordion-item next_report_training report_hidden">
  
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

  <div class="next_report_direct_download report_section report_hidden">
    <p><a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=3039" class="direct_download_btn">Download directly to a CSV file</a></p>
  </div>

  <div class="next_report_hashtags" style="display: none;">
    <p>#flexible</p>
    <p>#requests</p>
    <p>#confidential</p>
    <p>#history</p>
    <p>#holds</p>
    <p></p>
    <p></p>
    <p></p>
    <p></p>
    <p></p>
  </div>

</div>


----------
*/



SELECT 
  requests.reserve_id, 
  Concat( 
    'Status: ', 
    requests.statuss, 
    '<br /> Progress: ', 
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
  Concat('Patron BC: ', borrowers.cardnumber, '<br />', 'Pickup at: ', requests.branchcode) AS PATRON_INFO, 
  Concat_Ws('<br />', 
    Concat('Requested on: ', requests.reservedate), Concat('Waiting since: ', requests.waitingdate), 
    Concat('Expires on: ', requests.expirationdate), Concat('Cancelled on: ', requests.cancellationdate), 
    Concat('Updated on: ', requests.timestamp)) AS DATES, 
  Concat_Ws( 
    '<br />', 
    If(requests.suspend <> 0, 'Suspended', '-'), 
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
  Concat_Ws('<br />', 
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
  CONCAT_WS('<br />', 
    Concat( 
      'Action logs: ', 
      Concat( 
        '<a href="/cgi-bin/koha/reports/guided_reports.pl?id=', 
        '3040', 
        '&param_name=Enter+request+ID+number&sql_params=', 
        requests.reserve_id, 
        '&op=run', 
        '" target="_blank">see last 60 days of activity</a>' 
      ) 
    ), 
    Concat( 
      'Link to patron: ', 
      Concat('<a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=', 
      requests.borrowernumber, 
      '" target="_blank">go to the borrower"s record</a>' 
      ) 
    ), 
    Concat( 
      'Link to title: ', 
      Concat('<a href="/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
      requests.biblionumber, 
      '" target="_blank">go to the bibliographic record</a>' 
      ) 
    ), 
    Concat( 
      'Link to item: ', 
      Concat('<a href="/cgi-bin/koha/catalogue/moredetail.pl?itemnumber=', 
      items.itemnumber, 
      '&biblionumber=', 
      biblio.biblionumber, 
      '" target="_blank">go to the item record</a>' 
      ) 
    ), 
    Concat( 
      'Item in transit history: ', 
      Concat('<a href="/cgi-bin/koha/reports/guided_reports.pl?id=', 
        '2784', 
        '&param_name=Enter+item+barcode+number&sql_params=', 
        items.barcode, 
        '&op=run', 
        '" target="_blank">see item transit history</a>' 
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
  requests.branchcode LIKE <<Choose pickup library|branches:all>> AND 
  requests.statuss LIKE <<Choose request status|LHOLDACT>> AND 
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
  ) LIKE <<Choose request progress|LHOLDPROG>> AND 
  If(requests.suspend <> 0, 'Suspended', '-') LIKE <<Choose suspended status|LHOLDSUS>> AND 
  borrowers.cardnumber LIKE Concat('%', <<Enter library card number or a % symbol>>, '%') AND 
  requests.biblionumber LIKE Concat('%', <<Enter title biblio number or a % symbol>>, '%') AND 
  Coalesce( 
    Coalesce(items.barcode, '-'), Coalesce(deleteditems.barcode, '-') 
  ) LIKE Concat('%', <<Enter item barcode number or a % symbol>>, '%') 
GROUP BY 
  requests.reserve_id 
ORDER BY 
  requests.timestamp DESC 

























