/*
R.000214

----------

Name: GHW - Items with important fields that are blank or have problematic values
Created by: -

----------

Group: -
     -

Created on: 2009-01-26 12:07:07
Modified on: 2025-10-24 17:09:23
Date last run: 2025-10-24 17:09:26

----------

Public: 0
Expiry: 500

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

    &lt;p id="report_id"&gt;&lt;strong&gt;Report number:&lt;/strong&gt; 214&lt;/p&gt;

    &lt;p id="report_name"&gt;&lt;strong&gt;Report name:&lt;/strong&gt; Items with important fields that are blank or have problematic values&lt;/p&gt;

    &lt;p id="report_author"&gt;&lt;strong&gt;Report author:&lt;/strong&gt;  GHW&lt;/p&gt;

    &lt;p id="report_summary"&gt;&lt;strong&gt;Report summary:&lt;/strong&gt; Shows item records with important fields that are blank or may be problematic&lt;/p&gt;

  &lt;/div&gt;

  &lt;div class="accordion accordion-flush"&gt;



&lt;!-- Function section --&gt;
    &lt;div id="accordion_214-1" class="accordion-item next_report_function"&gt;

      &lt;h2 class="accordion-header" id="panelsStay_214Open-headingOne" &gt;

        &lt;button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_214Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_214Open-collapseOne"&gt;

          Function:

        &lt;/button&gt;

      &lt;/h2&gt;

      &lt;div id="panelsStay_214Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_214Open-headingOne"&gt;
        &lt;div class="accordion-body"&gt;

          &lt;div id="function_section" class="report_section"&gt;


            &lt;p&gt;Shows items in the catalog with the following fields left blank or having problematic data in the following fields&lt;/p&gt;
            &lt;ul&gt;
            
              &lt;li&gt;shows items currently in the catalog&lt;/li&gt;
            
              &lt;li&gt;shows items at the library you specify&lt;/li&gt;
            
              &lt;li&gt;grouped by biblio number and item number&lt;/li&gt;
            
              &lt;li&gt;sorted by item home branch, location, item type, collection code, call number, author, and title &lt;/li&gt;
            
              &lt;li&gt;Shows items fields left blank or having problematic data in them:
                &lt;ul&gt;
                  &lt;li&gt;
                    barcode (blank)
                  &lt;/li&gt;
                  &lt;li&gt;
                    item added dates in the future
                  &lt;/li&gt;
                  &lt;li&gt;
                    permanent shelving location (blank or cataloging, processing, or recently returned)
                  &lt;/li&gt;
                  &lt;li&gt;
                    item type (blank or unclassified)
                  &lt;/li&gt;
                  &lt;li&gt;
                    collection code (blank or unclassified)
                  &lt;/li&gt;
                  &lt;li&gt;
                    call number (blank)
                  &lt;/li&gt;
                  &lt;li&gt;
                    replacement price (blank)
                  &lt;/li&gt;
                &lt;/ul&gt;
              &lt;/li&gt;
            &lt;/ul&gt;

            &lt;span style="display: none;"&gt;
              &lt;li&gt;&lt;/li&gt;            &lt;/span&gt;
            &lt;/ul&gt;


            &lt;span style="display: none;"&gt;
            &lt;p&gt; - &lt;/p&gt;
            &lt;/span&gt;

          &lt;/div&gt;

        &lt;/div&gt;
      &lt;/div&gt;

    &lt;/div&gt;



&lt;!-- Notes section --&gt;
    &lt;div id="accordion_REPORTID-2" class="accordion-item next_report_notes "&gt;

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

          &lt;div id="notes_1" class="report_section"&gt;
            &lt;h4&gt;Replaces reports: &lt;/h4&gt;
            &lt;p&gt;
            &lt;ul&gt; &lt;br&gt;
              &lt;li&gt;214 - Null Report - Missing Item Type report for all libraries (previous version) &lt;/li&gt; &lt;br&gt;
              &lt;li&gt;1285 - Null Report - Missing Collection Codes all &lt;/li&gt; &lt;br&gt;
              &lt;li&gt;1398 - Collection Codes to Fix &lt;/li&gt; &lt;br&gt;
              &lt;li&gt;1401 - Item Types to Fix &lt;/li&gt; &lt;br&gt;
              &lt;li&gt;1402 - Missing Replacement Prices &lt;/li&gt; &lt;br&gt;
              &lt;li&gt;1404 - Shelving Locations to fix &lt;/li&gt; &lt;br&gt;
              &lt;li&gt;1405 - Missing Call Number &lt;/li&gt; &lt;br&gt;
              &lt;li&gt;1782 - Home or Current Branch is Null &lt;/li&gt; &lt;br&gt;
              &lt;li&gt;1912 - Null report -- Missing Shelving Location all &lt;/li&gt; &lt;br&gt;
              &lt;li&gt;3057 - GHW - Empty LOCATION/ITYPE/CCODES &lt;/li&gt; &lt;br&gt;
              &lt;li&gt;3362 - GHW - Items at a library without a replacement cost &lt;/li&gt; &lt;br&gt;
            &lt;/ul&gt;
            &lt;/p&gt;
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
    &lt;div id="accordion_REPORTID-5" class="accordion-item next_report_training "&gt;

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


              &lt;div id="training_link" class="col-md-3"&gt;
                &lt;p&gt;&lt;a href="https://northeast-kansas-library-system.github.io/nextsteps/reports_training/report_000214_training.html" target="_blank" class="training_btn"&gt;Online training&lt;/a&gt;&lt;/p&gt;
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
    &lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=214" class="direct_download_btn"&gt;Download directly to a CSV file&lt;/a&gt;&lt;/p&gt;
  &lt;/div&gt;



&lt;!-- Hashtag section --&gt;
  &lt;div class="next_report_hashtags" style="display: none;"&gt;
    &lt;p&gt;#item problems&lt;/p&gt;
    &lt;p&gt;#cataloging problems&lt;/p&gt;
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



SELECT 
  Concat_WS('', 
    Concat( 
      'Bibliographic record' 
    ),
    '',
    Concat( 
      'Item record'
    )
  ) AS LINKS,
    Concat_Ws("", 
    If(items.barcode IS NULL, "Barcode is blank / ", ""), 
    If(items.dateaccessioned &gt; CURDATE(), "Date added is in the future / ", ""),
    If(plocs.lib IS NULL, "Permanent location is blank / ", 
      If(plocs.lib LIKE "%Cataloging%", "Permanent location = cataloging / ", 
        If(plocs.lib LIKE "%Processing%", "Permanent location = processing / ", 
          If(plocs.lib LIKE "%Recently%", "Permanent location = recently returned / ", "") 
        ) 
      ) 
    ), 
    If(ccodes.lib IS NULL, "Collection code is blank / ", 
      If(ccodes.lib LIKE "%(UN%", "Collection code = (Unclassified) / ", "") 
    ), 
    If(itypes.description IS NULL, "Item type is blank ", 
      If(itypes.description LIKE "%(UN%", "Item type = (Unclassified) / ", "") 
    ), 
    If(items.itemcallnumber IS NULL, "Call number is blank / ", ""), 
    If(items.replacementprice IS NULL, "Replacement price is blank / ", 
      If(items.replacementprice = 0, "Replacement price = $0.00 / ", "") 
    ) 
  ) AS "Problem field",
  biblio.biblionumber AS BIBLIO_NUMBER, 
  items.itemnumber, 
  items.barcode, 
  items.homebranch, 
  items.holdingbranch, 
  plocs.lib AS "PERMANENT LOCATION", 
  locs.lib AS LOCATION, 
  itypes.description AS ITYPE, 
  ccodes.lib AS CCODE, 
  items.itemcallnumber AS "Call number", 
  items.copynumber, 
  biblio.author, 
  Concat_Ws(" ", biblio.title, biblio.subtitle, biblioitems.number, 
  biblio.part_name) AS "Full title", 
  items.replacementprice AS "Replacement price", 
  items.dateaccessioned AS "Date added"  
FROM 
  items JOIN 
  biblio ON items.biblionumber = biblio.biblionumber JOIN 
  biblioitems ON biblioitems.biblionumber = biblio.biblionumber AND 
      items.biblioitemnumber = biblioitems.biblioitemnumber LEFT JOIN 
  ( 
    SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib 
    FROM 
      authorised_values 
    WHERE 
      authorised_values.category = 'LOC' 
  ) 
  plocs ON plocs.authorised_value = items.permanent_location LEFT JOIN 
  ( 
    SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib 
    FROM 
      authorised_values 
    WHERE 
      authorised_values.category = 'LOC' 
  ) 
  locs ON locs.authorised_value = items.location LEFT JOIN 
  ( 
    SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib 
    FROM 
      authorised_values 
    WHERE 
      authorised_values.category = 'ccode' 
  ) 
  ccodes ON ccodes.authorised_value = items.ccode LEFT JOIN 
  ( 
    SELECT 
      itemtypes.itemtype, 
      itemtypes.description 
    FROM 
      itemtypes 
  ) 
  itypes ON itypes.itemtype = items.itype 
WHERE 
  items.homebranch LIKE &lt;&gt; AND 
  (
    (items.barcode IS NULL) OR 
    (items.dateaccessioned &gt; CURDATE()) OR
    (plocs.lib IS NULL) OR 
    (plocs.lib LIKE "%Cataloging%") OR 
    (plocs.lib LIKE "%Processing%") OR 
    (plocs.lib LIKE "%Recently%") OR 
    (ccodes.lib IS NULL) OR 
    (ccodes.lib LIKE "%(UN%") OR 
    (itypes.description IS NULL) OR 
    (itypes.description LIKE "%(UN%") OR 
    (items.itemcallnumber IS NULL) OR 
    (items.replacementprice IS NULL)
  ) AND 
  Concat( 
    If(items.barcode IS NULL, "BE", ""), 
    If(items.dateaccessioned &gt; CURDATE(), "FD", ""), 
    If(plocs.lib IS NULL, "LE3", 
      If(plocs.lib LIKE "%Cataloging%", "LG3", 
        If(plocs.lib LIKE "%Processing%", "LG3", 
          If(plocs.lib LIKE "%Recently%", "LG3", "") 
        ) 
      ) 
    ), 
    If(ccodes.lib IS NULL, "CE3", 
      If(ccodes.lib LIKE "%(UN%", "CG3", "") 
    ), 
    If(itypes.description IS NULL, "IE3", 
      If(itypes.description LIKE "%(UN%", "IG3", "") 
    ), 
    If(items.itemcallnumber IS NULL, "NE", ""), 
    If(items.replacementprice IS NULL, "PE", 
      If(items.replacementprice = 0, "PE", "") 
    ) 
  ) LIKE Concat("%", &lt;&gt;, "%") 
GROUP BY 
  biblio.biblionumber, 
  items.itemnumber 
ORDER BY 
  items.homebranch, 
  PERMANENT_LOCATION, 
  ITYPE, 
  CCODE, 
  items.itemcallnumber, 
  items.copynumber, 
  biblio.author, 
  "Full title"

























