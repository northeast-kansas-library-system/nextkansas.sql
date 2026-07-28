/*
R.003009

----------

Name: GHW - Accountlines by item barcode number (or description or note keyword)
Created by: George Williams

----------

Group: Fines/Fees
     -

Created on: 2017-10-23 09:30:01
Modified on: 2025-04-02 16:32:14
Date last run: 2026-07-27 11:38:17

----------

Public: 0
Expiry: 300

----------

<div class="next_report_info next_noprint">

  <div class="accordion accordion-flush">

    <div id="report-function" class="accordion-item">

      <h2 class="accordion-header" id="panelsStayOpen-headingOne">

        <button class="accordion-button next_report_function" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">

            Report function:

        </button>

      </h2>

      <div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne">
        <div class="accordion-body">

          <p>
            Shows accountline information for a particular item if the item's barcode number has been stored in the accountlines description or accountlines note fields
          </p>

          <ul>
            <li>
              Shows all accountlines related to the item barcode number specified
            </li>
            <li>
              Shows accountlines related to that item regardless as to which item owns the item or is owed the fee
            </li>
            <li>
              grouped and sorted by patron barcode number and accountline id
            </li>
            <li>
              links to the patron's fine history
            </li>
          </ul> 

        </div>
      </div>

    </div>

    <div id="report-notes" class="accordion-item">

      <h2 class="accordion-header" id="panelsStayOpen-headingTwo">

        <button class="accordion-button collapsed next_report_notes" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="false" aria-controls="panelsStayOpen-collapseTwo">

          Report notes:

        </button>

      </h2>

      <div id="panelsStayOpen-collapseTwo" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingTwo">
        <div class="accordion-body">
          
          <div class="next_report_section">

            <p>
              This report was fully updated on January 21, 2022 to make it do a better job of search both the accountlines description and accountline notes at the same time.
            </p>
            <p style="text-decoration: underline;">
              This report can only show the fee history on an item if the barcode number of the item was recorded in the description or note fields of the fee record. Currently Koha no longer stores this information automatically in the description or note fields.
            </p>
            <p>
              This report can only show the fines history on an item if the fee is unpaid or was paid less than 25 months ago.
            </p>
            <p>
              In some older version of Koha, the item barcode number was not always stored in the description field. If the item's barcode number was not stored in the description or note fields at the time the fee was created, this report cannot recover the data about the fee history.
            </p>
            <p>
              This report will show any entries in the patron's fee history - fees, credits, notes, writeoffs, etc. The only requirement is that the fee description or note contains the item barcode number you are searching for.
            </p>

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

      #fees 
      #fines 
      #deleted items

    </p>
    
  </div>
  
</div>

----------
*/



SELECT
  Concat(
    '<a class="btn btn-info noprint" href=\"/cgi-bin/koha/members/boraccount.pl?borrowernumber=', 
    borrowers.borrowernumber, 
    '\" target="_blank">Borrower transactions</a>'
  ) AS LINK,
  borrowers.cardnumber as BORROWER_CARDNUMBER,
  CONCAT_WS(
    ' // ', 
    accountlines.description, 
    accountlines.note
  ) as DESCRIP_NOTES,
  accountlines.date,
  Format(accountlines.amount, 2) AS amount
FROM
  accountlines
  JOIN borrowers ON accountlines.borrowernumber = borrowers.borrowernumber
WHERE
  CONCAT_WS(
    ', ', 
    accountlines.description, 
    accountlines.note
  ) LIKE CONCAT("%", <<Enter item barcode number or other search terms>>, "%")
GROUP BY
  borrowers.cardnumber,
  accountlines.accountlines_id
ORDER BY
  accountlines.date DESC

























