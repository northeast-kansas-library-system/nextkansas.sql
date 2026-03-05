/*
R.003113

----------

Name: GHW - Deleted item dashboard
Created by: George Williams

----------

Group: -
     -

Created on: 2018-08-13 15:03:41
Modified on: 2025-04-02 16:24:45
Date last run: 2026-01-27 10:39:34

----------

Public: 0
Expiry: 300

----------

&lt;div class="next_report_info next_noprint"&gt;

  &lt;p&gt;Basic information about an item that has been deleted&lt;/p&gt;

  &lt;div class="accordion accordion-flush"&gt;

    &lt;div id="report-function" class="accordion-item"&gt;

      &lt;h2 class="accordion-header" id="panelsStayOpen-headingOne"&gt;

        &lt;button class="accordion-button next_report_function" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne"&gt;

            Report function:

        &lt;/button&gt;

      &lt;/h2&gt;

      &lt;div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne"&gt;
        &lt;div class="accordion-body"&gt;

        &lt;ul&gt;
          &lt;li&gt;
            Shows items that are currently in the deleteditems table.  Item data is stored in the deleteditems table for 13 months after an item is deleted.
          &lt;/li&gt;
          &lt;li&gt;
            Shows items with the barcode numbers you specify
          &lt;/li&gt;
          &lt;li&gt;
            Grouped by itemnumber
          &lt;/li&gt;
          &lt;li&gt;
            sorted by homebranch, item type, collection code, call number, author, and title
          &lt;/li&gt;
          &lt;li&gt;
            Contains links to the items bibliographic record (if the bibliographic record has not been deleted) and links to a fines/fees report that can search by item barcode
          &lt;/li&gt;
        &lt;/ul&gt; 

        &lt;/div&gt;
      &lt;/div&gt;

    &lt;/div&gt;

    &lt;div id="report-notes" class="accordion-item next_hidden"&gt;

      &lt;h2 class="accordion-header" id="panelsStayOpen-headingTwo"&gt;

        &lt;button class="accordion-button collapsed next_report_notes" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="false" aria-controls="panelsStayOpen-collapseTwo"&gt;

          Report notes:

        &lt;/button&gt;

      &lt;/h2&gt;

      &lt;div id="panelsStayOpen-collapseTwo" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingTwo"&gt;
        &lt;div class="accordion-body"&gt;
          
          &lt;div class="next_report_section"&gt;

            &lt;p&gt;Notes go here&lt;/p&gt;

          &lt;/div&gt;

          &lt;div class="next_report_section"&gt;

            &lt;p&gt;More notes go here&lt;/p&gt;

          &lt;/div&gt;

        &lt;/div&gt;
      &lt;/div&gt;

    &lt;/div&gt;

    &lt;div id="report-instructions" class="accordion-item next_hidden"&gt;

      &lt;h2 class="accordion-header" id="panelsStayOpen-headingThree"&gt;

        &lt;button class="accordion-button collapsed next_report_instructions" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="false" aria-controls="panelsStayOpen-collapseThree"&gt;
          
          Report instructions:

        &lt;/button&gt;
      &lt;/h2&gt;

      &lt;div id="panelsStayOpen-collapseThree" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingThree"&gt;
        &lt;div class="accordion-body"&gt;

          &lt;div class="next_report_section"&gt;

            &lt;p&gt;
              Instructions go here
            &lt;/p&gt;

          &lt;/div&gt;

          &lt;div class="next_report_section"&gt;

            &lt;p&gt;
              More instructions go here
            &lt;/p&gt;

          &lt;/div&gt;

        &lt;/div&gt;
      &lt;/div&gt;

    &lt;/div&gt;

    &lt;div id="report-resources" class="accordion-item next_hidden"&gt;

      &lt;h2 class="accordion-header" id="panelsStayOpen-headingFour"&gt;

        &lt;button class="accordion-button collapsed next_report_resources" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseFour" aria-expanded="false" aria-controls="panelsStayOpen-collapseFour"&gt;

          Report external resources:

        &lt;/button&gt;

      &lt;/h2&gt;

      &lt;div id="panelsStayOpen-collapseFour" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingFour"&gt;
        &lt;div class="accordion-body"&gt;

          &lt;ul style="list-style-type: none;"&gt;
            &lt;li&gt;

              Explanation of resource if necessary&lt;br&gt;

              &lt;a href="/cgi-bin/koha/mainpage.pl" target="_blank" class="next_btn next_violet next_embiggen1"&gt;External resource 1&lt;/a&gt;

            &lt;/li&gt;
            &lt;li&gt;

              Explanation of resource if necessary&lt;br&gt;

              &lt;a href="/cgi-bin/koha/mainpage.pl" target="_blank" class="next_btn next_violet next_embiggen1"&gt;External resource 2&lt;/a&gt;

            &lt;/li&gt;
          &lt;/ul&gt;

        &lt;/div&gt;
      &lt;/div&gt;

    &lt;/div&gt;
    
  &lt;/div&gt;

  &lt;div id="report-download" class="next_direct_download next_hidden"&gt;

    &lt;a class="next_btn next_indigo next_embiggen1" href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=INSERT_REPORT_NUMBER_HERE"&gt;Download this report as a csv file &lt;i class="bi bi-download"&gt;&lt;/i&gt;&lt;/a&gt;

  &lt;/div&gt;

  &lt;div id="report-tags" class="next_hidden"&gt;

    &lt;p&gt;

      #deleted items

    &lt;/p&gt;
    
  &lt;/div&gt;
  
&lt;/div&gt;

----------
*/



SELECT
  Concat_Ws(
    '',
    Concat('At the time of its deletion on:  ', deleteditems.timestamp, " this item's information was as follows:"),
    Concat('Item homebranch: ', deleteditems.homebranch),
    Concat('Current branch: ', deleteditems.holdingbranch),
    Concat('Shelving location: ', deleteditems.location),
    Concat('Item type: ', deleteditems.itype),
    Concat('Collection code: ', ccodes.lib),
    Concat('Call#: ', deleteditems.itemcallnumber),
    Concat('Author: ', Coalesce(biblio.author, deletedbiblio.author)),
    Concat('Title: ', Coalesce(biblio.title, deletedbiblio.title)),
    Concat('Item barcode: ', deleteditems.barcode),
    Concat('Item id number: ', deleteditems.itemnumber),
    Concat("Damaged status: ",
      If(
        deleteditems.damaged = 0,
        "-",
        If(
          deleteditems.damaged IS NULL,
          "-",
          damagedi.lib
        )
      )
    ),
    Concat("Lost status: ",
      If(
        deleteditems.itemlost = 0,
        "-",
        If(
          deleteditems.itemlost IS NULL,
          "-",
          Concat(losti.lib, " on ", deleteditems.itemlost_on)
        )
      )
    ),
    Concat("Withdrawn status: ",
      If(
        deleteditems.withdrawn = 0,
        "-",
        If(
          deleteditems.withdrawn IS NULL,
          "- ",
          Concat(deletedwithdrawni.lib, " on ", deleteditems.withdrawn_on)
        )
      )
    ),
    If(biblio.biblionumber IS NULL,
      "-- Bibliographic record has been deleted --",
      Concat(
        "Bibliographic record"
      )
    ),
    Concat(
      "See fee history for this item barcode number"
    )
  ) AS INFO
FROM
  deleteditems
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE'
    GROUP BY
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
  ) ccodes
    ON deleteditems.ccode = ccodes.authorised_value
  LEFT JOIN biblio
    ON deleteditems.biblionumber = biblio.biblionumber
  LEFT JOIN deletedbiblio
    ON deleteditems.biblionumber = deletedbiblio.biblionumber
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'DAMAGED'
  ) damagedi
    ON damagedi.authorised_value = deleteditems.damaged
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOST'
  ) losti
    ON losti.authorised_value = deleteditems.itemlost
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'WITHDRAWN'
  ) deletedwithdrawni
    ON deletedwithdrawni.authorised_value = deleteditems.withdrawn
WHERE
  deleteditems.barcode LIKE Concat("%", Trim(&lt;&gt;), "%")
GROUP BY
  deleteditems.itemnumber
ORDER BY
  deleteditems.homebranch,
  deleteditems.itype,
  ccodes.lib,
  deleteditems.itemcallnumber,
  Coalesce(biblio.author, deletedbiblio.author),
  Coalesce(biblio.title, deletedbiblio.title) 

























