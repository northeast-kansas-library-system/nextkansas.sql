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

&lt;div class="next_report_info next_noprint"&gt;

  &lt;div id="next_report_introduction-3867" class=""&gt;
    &lt;p class=""&gt;Shows fields and words that you cannot use in Koha SQL reports&lt;/p&gt;
    &lt;p class=""&gt;&lt;strong&gt;Report created by: &lt;/strong&gt;GHW&lt;/p&gt;
  &lt;/div&gt;

  &lt;div id="next_report_accordion-3867" class="accordion accordion-flush"&gt;

    &lt;div id="next_report_function" class="accordion-item "&gt;
      &lt;h2 class="accordion-header" id="headingOne"&gt;
        &lt;button class="accordion-button next_report_function" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne-3867" aria-expanded="true" aria-controls="collapseOne"&gt;
            Report function:
        &lt;/button&gt;
      &lt;/h2&gt;

      &lt;div id="collapseOne-3867" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#next_report_accordion-3867"&gt;
        &lt;div class="accordion-body"&gt;
          &lt;ul&gt;
            &lt;li&gt;Shows fields that include "forbidden" words as well as a list of "forbidden" words as defined in Report.pm&lt;/li&gt;
            &lt;li&gt;in your  Koha database&lt;/li&gt;

            &lt;li&gt;table name, column name, and forbidden words in the order they appear in Report.pm&lt;/li&gt;

          &lt;/ul&gt;



        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;div id="next_report_notes" class="accordion-item "&gt;
      &lt;h2 class="accordion-header" id="headingTwo"&gt;
        &lt;button class="accordion-button collapsed next_report_notes" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo-3867" aria-expanded="false" aria-controls="collapseTwo"&gt;
          Report notes:
        &lt;/button&gt;
      &lt;/h2&gt;
      &lt;div id="collapseTwo-3867" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#next_report_accordion-3867"&gt;
        &lt;div class="accordion-body"&gt;

          &lt;div id="next_report_notes-1" class="next_report_section "&gt;
            &lt;h3&gt;Forbidden fields&lt;/h3&gt;
            &lt;p&gt;In order to protect password and authentication token data, trying to include some fields in a Koha SQL report will trigger an error message rather than allow that SQL to run.  Even though the data in most of the forbidden fields is usually encrypted, blocking these fields in SQL reports helps maintain the security of that data.  These field names are not case sensitive.&lt;/p&gt;
          &lt;/div&gt;

          &lt;div id="next_report_notes-2" class="next_report_section "&gt;
            &lt;h3&gt;Forbidden words&lt;/h3&gt;
            &lt;p&gt;SQL includes keywords that can trigger SQL functions that cause changes to the database.  Words like "DELETE" and "UPDATE," for example.  In order to prevent staff from accidentally modifying the Koha database structure (which would break Koha) some words cannot be used in Koha SQL reports.  These words are not case sensitive.&lt;/p&gt;
          &lt;/div&gt;

          &lt;div id="next_report_notes-3" class="next_report_section next_hidden"&gt;

            &lt;p&gt;&lt;/p&gt;
          &lt;/div&gt;

          &lt;div id="next_report_notes-4" class="next_report_section next_hidden"&gt;

            &lt;p&gt;&lt;/p&gt;
          &lt;/div&gt;

          &lt;div id="next_report_notes-5" class="next_report_section next_hidden"&gt;

            &lt;p&gt;&lt;/p&gt;
          &lt;/div&gt;

        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;div id="next_report_instruction" class="accordion-item next_hidden"&gt;
      &lt;h2 class="accordion-header" id="headingThree"&gt;
        &lt;button class="accordion-button collapsed next_report_instruction" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree-3867" aria-expanded="false" aria-controls="collapseThree"&gt;
          Report instructions:
        &lt;/button&gt;
      &lt;/h2&gt;
      &lt;div id="collapseThree-3867" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#next_report_accordion-3867"&gt;
        &lt;div class="accordion-body"&gt;

          &lt;div class="next_report_section next_hidden"&gt;
            &lt;h3&gt;~heading 1~&lt;/h3&gt;
            &lt;p id="next_report_instruction-1"&gt;
              Instructions go here
            &lt;/p&gt;
          &lt;/div&gt;

          &lt;div class="next_report_section next_hidden"&gt;
            &lt;h3&gt;~heading 2~&lt;/h3&gt;
            &lt;p id="next_report_instruction-2"&gt;
              Instructions go here
            &lt;/p&gt;
          &lt;/div&gt;

          &lt;div class="next_report_section next_hidden"&gt;
            &lt;h3&gt;~heading 3~&lt;/h3&gt;
            &lt;p id="next_report_instruction-3"&gt;
              Instructions go here
            &lt;/p&gt;
          &lt;/div&gt;

          &lt;div class="next_report_section next_hidden"&gt;
            &lt;h3&gt;~heading 4~&lt;/h3&gt;
            &lt;p id="next_report_instruction-4"&gt;
              Instructions go here
            &lt;/p&gt;
          &lt;/div&gt;

          &lt;div class="next_report_section "&gt;
            &lt;h3&gt;~heading 5~&lt;/h3&gt;
            &lt;p id="next_report_instruction-5"&gt;
              Instructions go here
            &lt;/p&gt;
          &lt;/div&gt;

        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;div id="next_report_resources" class="accordion-item next_hidden"&gt;
      &lt;h2 class="accordion-header" id="headingFour"&gt;
        &lt;button class="accordion-button collapsed next_report_resources" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour-3867" aria-expanded="false" aria-controls="collapseFour"&gt;
          Report external resources:
        &lt;/button&gt;
      &lt;/h2&gt;

      &lt;div id="collapseFour-3867" class="accordion-collapse collapse" aria-labelledby="headingFour" data-bs-parent="#next_report_accordion-3867"&gt;
        &lt;div class="accordion-body"&gt;

          &lt;ul style="list-style-type: none;"&gt;

            &lt;li class="next_hidden"&gt;&lt;/li&gt;
              ~Link 1 description~&lt;br&gt;
              &lt;a href="/cgi-bin/koha/mainpage.pl" target="_blank" class="next_btn next_violet next_embiggen2"&gt;~Link 1~&lt;/a&gt;&lt;br&gt;
            &lt;/li&gt;

            &lt;li class="next_hidden"&gt;&lt;/li&gt;
              ~Link 2 description~&lt;br&gt;
              &lt;a href="/cgi-bin/koha/mainpage.pl" target="_blank" class="next_btn next_violet next_embiggen2"&gt;~Link 2~&lt;/a&gt;&lt;br&gt;
            &lt;/li&gt;

            &lt;li class="next_hidden"&gt;&lt;/li&gt;
              ~Link 3 description~&lt;br&gt;
              &lt;a href="/cgi-bin/koha/mainpage.pl" target="_blank" class="next_btn next_violet next_embiggen2"&gt;~Link 3~&lt;/a&gt;&lt;br&gt;
            &lt;/li&gt;

            &lt;li class="next_hidden"&gt;&lt;/li&gt;
              ~Link 4 description~&lt;br&gt;
              &lt;a href="/cgi-bin/koha/mainpage.pl" target="_blank" class="next_btn next_violet next_embiggen2"&gt;~Link 4~&lt;/a&gt;&lt;br&gt;
            &lt;/li&gt;

            &lt;li class="next_hidden"&gt;&lt;/li&gt;
              ~Link 5 description~&lt;br&gt;
              &lt;a href="/cgi-bin/koha/mainpage.pl" target="_blank" class="next_btn next_violet next_embiggen2"&gt;~Link 5~&lt;/a&gt;&lt;br&gt;
            &lt;/li&gt;

          &lt;/ul&gt;

        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;

  &lt;/div&gt;

  &lt;div id="next_report_tags" class="next_hidden"&gt;
    &lt;p&gt;
      #Koha: 
      #database: 
      #forbidden: 







    &lt;/p&gt;
  &lt;/div&gt;

  &lt;div id="next_report_training" class="next_report_training next_hidden"&gt;
    &lt;br&gt;&lt;br&gt;
    &lt;a class="next_btn next_indigo next_embiggen2" href="/cgi-bin/koha/mainpage.pl" target="_blank"&gt;Training page for report 3867 &lt;i class="bi bi-arrow-up-right-square"&gt;&lt;/i&gt;&lt;/a&gt;
    &lt;br&gt;
    &lt;a class="next_btn next_indigo next_embiggen2" href="/cgi-bin/koha/mainpage.pl" target="_blank"&gt;Printable instructions for report 3867 &lt;i class="bi bi-download"&gt;&lt;/i&gt;&lt;/a&gt;
    &lt;br&gt;
    &lt;a class="next_btn next_indigo next_embiggen2" href="/cgi-bin/koha/mainpage.pl" target="_blank"&gt;Training video for report 3867 &lt;i class="bi bi-play-btn-fill"&gt;&lt;/i&gt;&lt;/a&gt;
  &lt;/div&gt;

  &lt;div id="next_direct_download" class="next_direct_download "&gt;
    &lt;br&gt;&lt;br&gt;
    &lt;a class="next_btn next_indigo next_embiggen2" href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=3867" target="_blank"&gt;Download this report as a csv file &lt;i class="bi bi-download"&gt;&lt;/i&gt;&lt;/a&gt;
    &lt;br&gt;
  &lt;/div&gt;

  &lt;div class="next_report_note_collapse next_hidden"&gt;
    &lt;br&gt;&lt;br&gt;
    &lt;button type="button" id="next_report_notes_hide" class="next_btn next_indigo next_report_notes_close"&gt;Collapse report notes&lt;/button&gt;
    &lt;br&gt;
  &lt;/div&gt;

&lt;/div&gt;


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

























