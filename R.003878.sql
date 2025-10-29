/*
R.003878

----------

Name: Repair work
Created by: George Williams

----------

Group: -
     -

Created on: 2025-03-11 16:16:33
Modified on: 2025-05-15 14:30:44
Date last run: 2025-08-22 17:18:48

----------

Public: 0
Expiry: 300

----------

<div class="next_report_info next_noprint">

  <p class="next_hiddenss">Title/introduction/etc.</p>

  <div id="next_report_accordion" class="accordion accordion-flush">

    <div id="next_report_function" class="accordion-item">

      <h2 class="accordion-header" id="headingOne">
        <button class="accordion-button next_report_function" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">

            Report function:

        </button>
      </h2>
      <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#next_report_accordion">
        <div class="accordion-body">

          <ul> 
            <li>
              When
            </li> 
            <li>
              Whose Stuff
            </li> 
            <li>
              grouped by
            </li> 
            <li>
              sorted by
            </li> 
            <li>
              links
            </li> 
          </ul> 

        </div>
      </div>
    </div>

    <div id="next_report_notes" class="accordion-item">
      <h2 class="accordion-header" id="headingTwo">
        <button class="accordion-button collapsed next_report_notes" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">

          Report notes:

        </button>
      </h2>
      <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#next_report_accordion">
        <div class="accordion-body">
          
          <div class="next_report_section">

            <p>Notes go here</p>

          </div>

          <div class="next_report_section">

            <p>More notes go here</p>

          </div>

        </div>
      </div>
    </div>

    <div id="next_report_instruction" class="accordion-item ">
      <h2 class="accordion-header" id="headingThree">
        <button class="accordion-button collapsed next_report_instruction" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
          
          Report instructions:

        </button>
      </h2>
      <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#next_report_accordion">
        <div class="accordion-body">

          <div class="next_report_section">

            <p>
              Instructions go here
            </p>

          </div>

          <div class="next_report_section">

            <p>
              More instructions go here
            </p>

          </div>

        </div>
      </div>
    </div>

    <div id="next_report_resources" class="accordion-item ">

      <h2 class="accordion-header" id="headingFour">
        <button class="accordion-button collapsed next_report_resources" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">

          Report external resources:

        </button>
      </h2>

      <div id="collapseFour" class="accordion-collapse collapse" aria-labelledby="headingFour" data-bs-parent="#next_report_accordion">
        <div class="accordion-body">

          <ul style="list-style-type: none;">
            <li>

              Explanation of resource if necessary<br>

              <a href="/cgi-bin/koha/mainpage.pl" target="_blank" class="next_btn next_violet next_embiggen1">External resource 1</a>

            </li>
            <li>

              Explanation of resource if necessary<br>

              <a href="/cgi-bin/koha/mainpage.pl" target="_blank" class="next_btn next_violet next_embiggen1">External resource 2</a>

            </li>
          </ul>

        </div>
      </div>
    </div>
    
  </div>

  <div id="next_direct_download" class="next_direct_download next_hiddenss">

    <a class="next_btn next_indigo next_embiggen1" href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=INSERT_REPORT_NUMBER_HERE">Download this report as a csv file <i class="bi bi-download"></i></a>

  </div>

  <div id="next_report_tags" class="next_hiddenss">

    <p>

      #tags_go_here

    </p>
    
  </div>

  <div class="next_report_training">

    <a class="next_btn next_indigo next_embiggen1" href="Go to instructions">Training page for this report <i class="bi bi-arrow-up-right-square"></i></a>

    <a class="next_btn next_indigo next_embiggen1" href="link to printable instruction sheet">Printable instructions for this report <i class="bi bi-download"></i></a>

  </div>

  <div class="next_report_note_collapse next_hiddenss">

    <button type="button" class="next_btn next_indigo next_report_notes_close">Collapse report notes</button>

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
  If(coalesce(items.dateaccessioned, '1900-01-01') &lt; '2000-01-01', '2000-01-01', DATE_FORMAT(items.dateaccessioned, '%Y-%m-%d')) AS DATE_ADDED,
  Count(items.itemnumber) As Count_itemnumber
From
  items
Group By
  If(coalesce(items.dateaccessioned, '1900-01-01') &lt; '2000-01-01', '2000-01-01', DATE_FORMAT(items.dateaccessioned, '%Y-%m-%d'))
Order By
  If(coalesce(items.dateaccessioned, '1900-01-01') &lt; '2000-01-01', '2000-01-01', DATE_FORMAT(items.dateaccessioned, '%Y-%m-%d')) ASC

























