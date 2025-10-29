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
Date last run: 2025-10-17 09:47:03

----------

Public: 0
Expiry: 0

----------

<div class="next_report_info next_noprint">

  <div id="next_report_introduction-1234" class="">
    <p class="">Generates a list of all patrons with fees on their account</p>
    <p class="next_hidden"><strong>Report created by: </strong>~Author variable~</p>
  </div>

  <div id="next_report_accordion-1234" class="accordion accordion-flush">

    <div id="next_report_function" class="accordion-item ">
      <h2 class="accordion-header" id="headingOne">
        <button class="accordion-button next_report_function" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne-1234" aria-expanded="true" aria-controls="collapseOne">
            Report function:
        </button>
      </h2>

      <div id="collapseOne-1234" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#next_report_accordion-1234">
        <div class="accordion-body">
          <ul>
            <li>Lists patrons that currently have an account balance due greater than $0.01</li>
            <li>ists patrons whose home library is the branchcode you specify - regardless of where the fees were generated.</li>
            <li>grouped by the borrower's card number</li>
            <li>sorted by the borrowers last name</li>
            <li>~links to~</li>
          </ul>

          <p>~Function notes~</p>

        </div>
      </div>
    </div>




































































































































  <div id="next_report_tags" class="next_hidden">
    <p>
      #fines: 
      #fees: 








    </p>
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

























