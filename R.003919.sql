/*
R.003919

----------

Name: GHW
Created by: George Williams

----------

Group: -
     -

Created on: 2025-09-16 13:45:52
Modified on: 2025-10-15 23:03:35
Date last run: 2025-10-15 23:03:36

----------

Public: 0
Expiry: 300

----------

<div class="next_report_info next_noprint">

  <p class="next_embiggen3">1234567890</p>

  <p class="next_embiggen3">0987654321</p>

  <p class="next_embiggen1">0987654321</p>

  <div id="next_report_accordion-1234567890" class="accordion accordion-flush">

    <div id="next_report_training" class="accordion-item ">

      <h2 class="accordion-header" id="headingSix">
        <button class="accordion-button collapsed next_report_training" type="button" data-bs-toggle="collapse" data-bs-target="#collapseSix" aria-expanded="false" aria-controls="collapseSix">Report training:</button>
      </h2>

      <div id="collapseSix" class="accordion-collapse collapse" aria-labelledby="headingSix" data-bs-parent="#next_report_accordion-1234567890">
        <div class="accordion-body">

          <div class="next_report_section">

            <div id="next_training_link" class="next_training_link">
              <h3>Go to a training page:</h3>
              <a class="next_btn next_red next_embiggen1" href="1234567890" target="blank">1234567890 <i class="bi bi-box-arrow-up-right"></i></a>

              <p>1234567890</p>

            </div>

          </div>

          <div class="next_report_section">

            <div id="next_training_link" class="next_training_link">
              <h3>Print a training page:</h3>
              <a class="next_btn next_red next_embiggen1" href="1234567890" target="blank">1234567890 <i class="bi bi-printer-fill"></i></a>

              <p>1234567890</p>

            </div>

          </div>

          <div class="next_report_section">

            <div id="next_training_link" class="next_training_link">
              <h3>View a training video:</h3>
              <a class="next_btn next_red next_embiggen1" href="1234567890" target="blank">1234567890 <i class="bi bi-play-btn-fill"></i></a>

              <p>1234567890</p>

            </div>

          </div>

        </div>
      </div>
    </div>

  </div>

  <div id="next_report_tags" style="display: none;">
    <p>
      #1234567890 : 
      #1234567890 : 
      #1234567890 : 
      #1234567890 : 
      #1234567890 : 
      #1234567890 : 
      #1234567890 : 
      #1234567890 : 
      #1234567890 : 
      #1234567890
    </p>
  </div>

  <div class="next_report_note_collapse next_hiddens">

    <button type="button" class="next_btn next_indigo next_report_notes_close">Collapse report notes</button>

  </div>

</div>

----------
*/



SELECT
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.firstname,
  borrowers.branchcode,
  borrowers.categorycode,
  '' AS password_expiration_date,
  borrowers.login_attempts
FROM
  borrowers LEFT JOIN
  (SELECT
      accountlines.borrowernumber,
      Format(Sum(accountlines.amountoutstanding), 2) AS DUE_SUM
    FROM
      accountlines
    GROUP BY
      accountlines.borrowernumber) accountlinesx ON borrowers.borrowernumber =
      accountlinesx.borrowernumber LEFT JOIN
  (SELECT
      issues.borrowernumber,
      Count(issues.issue_id) AS ICOUNT
    FROM
      issues
    GROUP BY
      issues.borrowernumber) issuesx ON borrowers.borrowernumber =
      issuesx.borrowernumber LEFT JOIN
  (SELECT
      reserves.borrowernumber,
      Count(reserves.reserve_id) AS Count_reserve_id
    FROM
      reserves
    GROUP BY
      reserves.borrowernumber) requestsx ON borrowers.borrowernumber =
      requestsx.borrowernumber LEFT JOIN
  (SELECT
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute,
      authorised_values.lib,
      authorised_values.category
    FROM
      borrower_attributes JOIN
      authorised_values ON borrower_attributes.attribute =
          authorised_values.authorised_value
    WHERE
      borrower_attributes.code = 'expired' AND
      authorised_values.category = 'expired') expired_attribute ON
      borrowers.borrowernumber = expired_attribute.borrowernumber LEFT JOIN
  (SELECT
      borrower_relationships.guarantor_id,
      Count(borrower_relationships.guarantee_id) AS GCOUNT
    FROM
      borrower_relationships
    GROUP BY
      borrower_relationships.guarantor_id) guaranteesx ON
      guaranteesx.guarantor_id = borrowers.borrowernumber
WHERE
  borrowers.branchcode LIKE 'HIGH_CC' AND
  Coalesce(borrowers.othernames, "0") NOT LIKE "%SIP%" AND
  borrowers.categorycode <> 'STAFF' AND
  borrowers.categorycode <> 'ILL' AND
  borrowers.categorycode <> 'HOOPLA' AND
  borrowers.password_expiration_date <> ''
GROUP BY
  borrowers.borrowernumber
ORDER BY
  borrowers.borrowernumber

























