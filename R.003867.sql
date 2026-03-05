/*
R.003867

----------

Name: GHW - Forbidden database fields
Created by: George Williams

----------

Group: -
     -

Created on: 2024-10-28 11:21:02
Modified on: 2025-05-19 11:40:46
Date last run: 2026-01-06 09:27:10

----------

Public: 0
Expiry: 300

----------

<div class="next_report_info next_noprint">

  <div id="next_report_introduction-3867" class="">
    <p class="">Shows fields and words that you cannot use in Koha SQL reports</p>
    <p class=""><strong>Report created by: </strong>GHW</p>
  </div>

  <div id="next_report_accordion-3867" class="accordion accordion-flush">

    <div id="next_report_function" class="accordion-item ">
      <h2 class="accordion-header" id="headingOne">
        <button class="accordion-button next_report_function" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne-3867" aria-expanded="true" aria-controls="collapseOne">
            Report function:
        </button>
      </h2>

      <div id="collapseOne-3867" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#next_report_accordion-3867">
        <div class="accordion-body">
          <ul>
            <li>Shows fields that include "forbidden" words as well as a list of "forbidden" words as defined in Report.pm</li>
            <li>in your  Koha database</li>

            <li>table name, column name, and forbidden words in the order they appear in Report.pm</li>

          </ul>



        </div>
      </div>
    </div>

    <div id="next_report_notes" class="accordion-item ">
      <h2 class="accordion-header" id="headingTwo">
        <button class="accordion-button collapsed next_report_notes" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo-3867" aria-expanded="false" aria-controls="collapseTwo">
          Report notes:
        </button>
      </h2>
      <div id="collapseTwo-3867" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#next_report_accordion-3867">
        <div class="accordion-body">

          <div id="next_report_notes-1" class="next_report_section ">
            <h3>Forbidden fields</h3>
            <p>In order to protect password and authentication token data, trying to include some fields in a Koha SQL report will trigger an error message rather than allow that SQL to run.  Even though the data in most of the forbidden fields is usually encrypted, blocking these fields in SQL reports helps maintain the security of that data.  These field names are not case sensitive.</p>
          </div>

          <div id="next_report_notes-2" class="next_report_section ">
            <h3>Forbidden words</h3>
            <p>SQL includes keywords that can trigger SQL functions that cause changes to the database.  Words like "DELETE" and "UPDATE," for example.  In order to prevent staff from accidentally modifying the Koha database structure (which would break Koha) some words cannot be used in Koha SQL reports.  These words are not case sensitive.</p>
          </div>

          <div id="next_report_notes-3" class="next_report_section next_hidden">

            <p></p>
          </div>

          <div id="next_report_notes-4" class="next_report_section next_hidden">

            <p></p>
          </div>

          <div id="next_report_notes-5" class="next_report_section next_hidden">

            <p></p>
          </div>

        </div>
      </div>
    </div>

    <div id="next_report_instruction" class="accordion-item next_hidden">
      <h2 class="accordion-header" id="headingThree">
        <button class="accordion-button collapsed next_report_instruction" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree-3867" aria-expanded="false" aria-controls="collapseThree">
          Report instructions:
        </button>
      </h2>
      <div id="collapseThree-3867" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#next_report_accordion-3867">
        <div class="accordion-body">

          <div class="next_report_section next_hidden">
            <h3>~heading 1~</h3>
            <p id="next_report_instruction-1">
              Instructions go here
            </p>
          </div>

          <div class="next_report_section next_hidden">
            <h3>~heading 2~</h3>
            <p id="next_report_instruction-2">
              Instructions go here
            </p>
          </div>

          <div class="next_report_section next_hidden">
            <h3>~heading 3~</h3>
            <p id="next_report_instruction-3">
              Instructions go here
            </p>
          </div>

          <div class="next_report_section next_hidden">
            <h3>~heading 4~</h3>
            <p id="next_report_instruction-4">
              Instructions go here
            </p>
          </div>

          <div class="next_report_section ">
            <h3>~heading 5~</h3>
            <p id="next_report_instruction-5">
              Instructions go here
            </p>
          </div>

        </div>
      </div>
    </div>

    <div id="next_report_resources" class="accordion-item next_hidden">
      <h2 class="accordion-header" id="headingFour">
        <button class="accordion-button collapsed next_report_resources" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour-3867" aria-expanded="false" aria-controls="collapseFour">
          Report external resources:
        </button>
      </h2>

      <div id="collapseFour-3867" class="accordion-collapse collapse" aria-labelledby="headingFour" data-bs-parent="#next_report_accordion-3867">
        <div class="accordion-body">

          <ul style="list-style-type: none;">

            <li class="next_hidden"></li>
              ~Link 1 description~<br>
              <a href="/cgi-bin/koha/mainpage.pl" target="_blank" class="next_btn next_violet next_embiggen2">~Link 1~</a><br>
            </li>

            <li class="next_hidden"></li>
              ~Link 2 description~<br>
              <a href="/cgi-bin/koha/mainpage.pl" target="_blank" class="next_btn next_violet next_embiggen2">~Link 2~</a><br>
            </li>

            <li class="next_hidden"></li>
              ~Link 3 description~<br>
              <a href="/cgi-bin/koha/mainpage.pl" target="_blank" class="next_btn next_violet next_embiggen2">~Link 3~</a><br>
            </li>

            <li class="next_hidden"></li>
              ~Link 4 description~<br>
              <a href="/cgi-bin/koha/mainpage.pl" target="_blank" class="next_btn next_violet next_embiggen2">~Link 4~</a><br>
            </li>

            <li class="next_hidden"></li>
              ~Link 5 description~<br>
              <a href="/cgi-bin/koha/mainpage.pl" target="_blank" class="next_btn next_violet next_embiggen2">~Link 5~</a><br>
            </li>

          </ul>

        </div>
      </div>
    </div>

  </div>

  <div id="next_report_tags" class="next_hidden">
    <p>
      #Koha: 
      #database: 
      #forbidden: 







    </p>
  </div>

  <div id="next_report_training" class="next_report_training next_hidden">
    <br><br>
    <a class="next_btn next_indigo next_embiggen2" href="/cgi-bin/koha/mainpage.pl" target="_blank">Training page for report 3867 <i class="bi bi-arrow-up-right-square"></i></a>
    <br>
    <a class="next_btn next_indigo next_embiggen2" href="/cgi-bin/koha/mainpage.pl" target="_blank">Printable instructions for report 3867 <i class="bi bi-download"></i></a>
    <br>
    <a class="next_btn next_indigo next_embiggen2" href="/cgi-bin/koha/mainpage.pl" target="_blank">Training video for report 3867 <i class="bi bi-play-btn-fill"></i></a>
  </div>

  <div id="next_direct_download" class="next_direct_download ">
    <br><br>
    <a class="next_btn next_indigo next_embiggen2" href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=3867" target="_blank">Download this report as a csv file <i class="bi bi-download"></i></a>
    <br>
  </div>

  <div class="next_report_note_collapse next_hidden">
    <br><br>
    <button type="button" id="next_report_notes_hide" class="next_btn next_indigo next_report_notes_close">Collapse report notes</button>
    <br>
  </div>

</div>


----------
*/



SELECT 
  Concat( 
    '## Forbidden database fields in Koha SQL: Version ', 
    Format(systempreferences.value, 2) 
  ) AS `# FORBIDDEN_SQL_TERMS_IN_KOHA` 
FROM 
  systempreferences 
WHERE 
  systempreferences.variable = 'Version' 
UNION 
( 
  SELECT 
    Concat_Ws('.', Concat('- ', information_schema.COLUMNS.TABLE_NAME), 
    information_schema.COLUMNS.COLUMN_NAME) AS 
    'FIELDS_FORBIDDEN_IN_KOHA_REPORTS_MODULE' 
  FROM 
    information_schema.COLUMNS 
  WHERE 
    ( 
      information_schema.COLUMNS.COLUMN_NAME LIKE Concat('%pass', 'word%') OR 
      information_schema.COLUMNS.COLUMN_NAME LIKE Concat('%tok', 'en%') OR 
      information_schema.COLUMNS.COLUMN_NAME LIKE Concat('%uu', 'id%') OR 
      information_schema.COLUMNS.COLUMN_NAME LIKE Concat('%secr', 'et%') 
    ) AND 
    information_schema.COLUMNS.COLUMN_NAME NOT LIKE '%password_expiration_date%' AND 
    information_schema.COLUMNS.COLUMN_NAME NOT LIKE '%password_expiry_days%' AND 
    information_schema.COLUMNS.COLUMN_NAME NOT LIKE '%reset_password%' AND 
    information_schema.COLUMNS.COLUMN_NAME NOT LIKE '%change_password%' AND 
    information_schema.COLUMNS.COLUMN_NAME NOT LIKE '%min_password_length%' AND 
    information_schema.COLUMNS.COLUMN_NAME NOT LIKE '%require_strong_password%' AND 
    information_schema.COLUMNS.COLUMN_NAME NOT LIKE '%password_expiration_date%' 
  GROUP BY 
    Concat_Ws('.', 
      Concat('- ', information_schema.COLUMNS.TABLE_NAME), 
      information_schema.COLUMNS.COLUMN_NAME 
    ) 
) 
UNION 
SELECT 
  '## Forbidden words in Koha SQL reports' 
UNION 
SELECT 
  Concat('- U', 'PDATE') 
UNION 
SELECT 
  Concat('- D', 'ELETE') 
UNION 
SELECT 
  Concat('- D', 'ROP') 
UNION 
SELECT 
  Concat('- I', 'NSERT') 
UNION 
SELECT 
  Concat('- S', 'HOW') 
UNION 
SELECT 
  Concat('- C', 'REATE') 
LIMIT 500 

























