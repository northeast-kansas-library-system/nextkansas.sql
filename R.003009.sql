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
Date last run: 2026-01-27 11:54:01

----------

Public: 0
Expiry: 300

----------

&lt;div class="next_report_info next_noprint"&gt;

  &lt;div class="accordion accordion-flush"&gt;

    &lt;div id="report-function" class="accordion-item"&gt;

      &lt;h2 class="accordion-header" id="panelsStayOpen-headingOne"&gt;

        &lt;button class="accordion-button next_report_function" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne"&gt;

            Report function:

        &lt;/button&gt;

      &lt;/h2&gt;

      &lt;div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne"&gt;
        &lt;div class="accordion-body"&gt;

          &lt;p&gt;
            Shows accountline information for a particular item if the item's barcode number has been stored in the accountlines description or accountlines note fields
          &lt;/p&gt;

          &lt;ul&gt;
            &lt;li&gt;
              Shows all accountlines related to the item barcode number specified
            &lt;/li&gt;
            &lt;li&gt;
              Shows accountlines related to that item regardless as to which item owns the item or is owed the fee
            &lt;/li&gt;
            &lt;li&gt;
              grouped and sorted by patron barcode number and accountline id
            &lt;/li&gt;
            &lt;li&gt;
              links to the patron's fine history
            &lt;/li&gt;
          &lt;/ul&gt; 

        &lt;/div&gt;
      &lt;/div&gt;

    &lt;/div&gt;

    &lt;div id="report-notes" class="accordion-item"&gt;

      &lt;h2 class="accordion-header" id="panelsStayOpen-headingTwo"&gt;

        &lt;button class="accordion-button collapsed next_report_notes" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="false" aria-controls="panelsStayOpen-collapseTwo"&gt;

          Report notes:

        &lt;/button&gt;

      &lt;/h2&gt;

      &lt;div id="panelsStayOpen-collapseTwo" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingTwo"&gt;
        &lt;div class="accordion-body"&gt;
          
          &lt;div class="next_report_section"&gt;

            &lt;p&gt;
              This report was fully updated on January 21, 2022 to make it do a better job of search both the accountlines description and accountline notes at the same time.
            &lt;/p&gt;
            &lt;p style="text-decoration: underline;"&gt;
              This report can only show the fee history on an item if the barcode number of the item was recorded in the description or note fields of the fee record. Currently Koha no longer stores this information automatically in the description or note fields.
            &lt;/p&gt;
            &lt;p&gt;
              This report can only show the fines history on an item if the fee is unpaid or was paid less than 25 months ago.
            &lt;/p&gt;
            &lt;p&gt;
              In some older version of Koha, the item barcode number was not always stored in the description field. If the item's barcode number was not stored in the description or note fields at the time the fee was created, this report cannot recover the data about the fee history.
            &lt;/p&gt;
            &lt;p&gt;
              This report will show any entries in the patron's fee history - fees, credits, notes, writeoffs, etc. The only requirement is that the fee description or note contains the item barcode number you are searching for.
            &lt;/p&gt;

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

      #fees 
      #fines 
      #deleted items

    &lt;/p&gt;
    
  &lt;/div&gt;
  
&lt;/div&gt;

----------
*/



SELECT
  Concat(
    'Borrower transactions'
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
  ) LIKE CONCAT("%", &lt;&gt;, "%")
GROUP BY
  borrowers.cardnumber,
  accountlines.accountlines_id
ORDER BY
  accountlines.date DESC

























