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
Date last run: 2025-09-29 09:10:56

----------

Public: 0
Expiry: 300

----------

<div class="next_report_info next_noprint">

  <p>Basic information about an item that has been deleted</p>

  <div class="accordion accordion-flush">

    <div id="report-function" class="accordion-item">

      <h2 class="accordion-header" id="panelsStayOpen-headingOne">

        <button class="accordion-button next_report_function" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">

            Report function:

        </button>

      </h2>

      <div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne">
        <div class="accordion-body">

        <ul>
          <li>
            Shows items that are currently in the deleteditems table.  Item data is stored in the deleteditems table for 13 months after an item is deleted.
          </li>
          <li>
            Shows items with the barcode numbers you specify
          </li>
          <li>
            Grouped by itemnumber
          </li>
          <li>
            sorted by homebranch, item type, collection code, call number, author, and title
          </li>
          <li>
            Contains links to the items bibliographic record (if the bibliographic record has not been deleted) and links to a fines/fees report that can search by item barcode
          </li>
        </ul> 

        </div>
      </div>

    </div>

    <div id="report-notes" class="accordion-item next_hidden">

      <h2 class="accordion-header" id="panelsStayOpen-headingTwo">

        <button class="accordion-button collapsed next_report_notes" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="false" aria-controls="panelsStayOpen-collapseTwo">

          Report notes:

        </button>

      </h2>

      <div id="panelsStayOpen-collapseTwo" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingTwo">
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

    <div id="report-instructions" class="accordion-item next_hidden">

      <h2 class="accordion-header" id="panelsStayOpen-headingThree">

        <button class="accordion-button collapsed next_report_instructions" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="false" aria-controls="panelsStayOpen-collapseThree">
          
          Report instructions:

        </button>
      </h2>

      <div id="panelsStayOpen-collapseThree" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingThree">
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

    <div id="report-resources" class="accordion-item next_hidden">

      <h2 class="accordion-header" id="panelsStayOpen-headingFour">

        <button class="accordion-button collapsed next_report_resources" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseFour" aria-expanded="false" aria-controls="panelsStayOpen-collapseFour">

          Report external resources:

        </button>

      </h2>

      <div id="panelsStayOpen-collapseFour" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingFour">
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

  <div id="report-download" class="next_direct_download next_hidden">

    <a class="next_btn next_indigo next_embiggen1" href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=INSERT_REPORT_NUMBER_HERE">Download this report as a csv file <i class="bi bi-download"></i></a>

  </div>

  <div id="report-tags" class="next_hidden">

    <p>

      #deleted items

    </p>
    
  </div>
  
</div>

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

























