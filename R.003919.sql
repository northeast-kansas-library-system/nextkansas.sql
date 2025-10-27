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

&lt;div class="next_report_info next_noprint"&gt;

  &lt;p class="next_embiggen3"&gt;1234567890&lt;/p&gt;

  &lt;p class="next_embiggen3"&gt;0987654321&lt;/p&gt;

  &lt;p class="next_embiggen1"&gt;0987654321&lt;/p&gt;

  &lt;div id="next_report_accordion-1234567890" class="accordion accordion-flush"&gt;

    &lt;div id="next_report_training" class="accordion-item "&gt;

      &lt;h2 class="accordion-header" id="headingSix"&gt;
        &lt;button class="accordion-button collapsed next_report_training" type="button" data-bs-toggle="collapse" data-bs-target="#collapseSix" aria-expanded="false" aria-controls="collapseSix"&gt;Report training:&lt;/button&gt;
      &lt;/h2&gt;

      &lt;div id="collapseSix" class="accordion-collapse collapse" aria-labelledby="headingSix" data-bs-parent="#next_report_accordion-1234567890"&gt;
        &lt;div class="accordion-body"&gt;

          &lt;div class="next_report_section"&gt;

            &lt;div id="next_training_link" class="next_training_link"&gt;
              &lt;h3&gt;Go to a training page:&lt;/h3&gt;
              &lt;a class="next_btn next_red next_embiggen1" href="1234567890" target="blank"&gt;1234567890 &lt;i class="bi bi-box-arrow-up-right"&gt;&lt;/i&gt;&lt;/a&gt;

              &lt;p&gt;1234567890&lt;/p&gt;

            &lt;/div&gt;

          &lt;/div&gt;

          &lt;div class="next_report_section"&gt;

            &lt;div id="next_training_link" class="next_training_link"&gt;
              &lt;h3&gt;Print a training page:&lt;/h3&gt;
              &lt;a class="next_btn next_red next_embiggen1" href="1234567890" target="blank"&gt;1234567890 &lt;i class="bi bi-printer-fill"&gt;&lt;/i&gt;&lt;/a&gt;

              &lt;p&gt;1234567890&lt;/p&gt;

            &lt;/div&gt;

          &lt;/div&gt;

          &lt;div class="next_report_section"&gt;

            &lt;div id="next_training_link" class="next_training_link"&gt;
              &lt;h3&gt;View a training video:&lt;/h3&gt;
              &lt;a class="next_btn next_red next_embiggen1" href="1234567890" target="blank"&gt;1234567890 &lt;i class="bi bi-play-btn-fill"&gt;&lt;/i&gt;&lt;/a&gt;

              &lt;p&gt;1234567890&lt;/p&gt;

            &lt;/div&gt;

          &lt;/div&gt;

        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;

  &lt;/div&gt;

  &lt;div id="next_report_tags" style="display: none;"&gt;
    &lt;p&gt;
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
    &lt;/p&gt;
  &lt;/div&gt;

  &lt;div class="next_report_note_collapse next_hiddens"&gt;

    &lt;button type="button" class="next_btn next_indigo next_report_notes_close"&gt;Collapse report notes&lt;/button&gt;

  &lt;/div&gt;

&lt;/div&gt;

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
  borrowers.categorycode &lt;&gt; 'STAFF' AND
  borrowers.categorycode &lt;&gt; 'ILL' AND
  borrowers.categorycode &lt;&gt; 'HOOPLA' AND
  borrowers.password_expiration_date &lt;&gt; ''
GROUP BY
  borrowers.borrowernumber
ORDER BY
  borrowers.borrowernumber

























