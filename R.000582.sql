/*
R.000582

----------

Name: OUTSTANDING Fines by patron home library
Created by:  Tongie Book Club

----------

Group: Circulation
     Charges

Created on: 2009-06-12 16:22:06
Modified on: 2025-06-02 14:09:26
Date last run: 2026-01-16 11:50:19

----------

Public: 0
Expiry: 0

----------

&lt;div class="next_report_info next_noprint"&gt;

  &lt;div id="next_report_introduction-1234" class=""&gt;
    &lt;p class=""&gt;Generates a list of all patrons with fees on their account&lt;/p&gt;
    &lt;p class="next_hidden"&gt;&lt;strong&gt;Report created by: &lt;/strong&gt;~Author variable~&lt;/p&gt;
  &lt;/div&gt;

  &lt;div id="next_report_accordion-1234" class="accordion accordion-flush"&gt;

    &lt;div id="next_report_function" class="accordion-item "&gt;
      &lt;h2 class="accordion-header" id="headingOne"&gt;
        &lt;button class="accordion-button next_report_function" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne-1234" aria-expanded="true" aria-controls="collapseOne"&gt;
            Report function:
        &lt;/button&gt;
      &lt;/h2&gt;

      &lt;div id="collapseOne-1234" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#next_report_accordion-1234"&gt;
        &lt;div class="accordion-body"&gt;
          &lt;ul&gt;
            &lt;li&gt;Lists patrons that currently have an account balance due greater than $0.01&lt;/li&gt;
            &lt;li&gt;ists patrons whose home library is the branchcode you specify - regardless of where the fees were generated.&lt;/li&gt;
            &lt;li&gt;grouped by the borrower's card number&lt;/li&gt;
            &lt;li&gt;sorted by the borrowers last name&lt;/li&gt;
            &lt;li&gt;~links to~&lt;/li&gt;
          &lt;/ul&gt;

          &lt;p&gt;~Function notes~&lt;/p&gt;

        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;




































































































































  &lt;div id="next_report_tags" class="next_hidden"&gt;
    &lt;p&gt;
      #fines: 
      #fees: 








    &lt;/p&gt;
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
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.firstname,
  Format(Sum(accountlines.amountoutstanding), 2) AS AMT_DUE
FROM
  borrowers
  LEFT JOIN accountlines ON borrowers.borrowernumber = accountlines.borrowernumber
WHERE
  borrowers.branchcode LIKE &lt;&gt;
GROUP BY
  borrowers.cardnumber
HAVING
  AMT_DUE &gt; 0
ORDER BY
  borrowers.surname

























