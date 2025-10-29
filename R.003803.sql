/*
R.003803

----------

Name: GHW - USPS Mailing list
Created by: George Williams

----------

Group: -
     -

Created on: 2024-02-29 16:17:05
Modified on: 2024-02-29 16:52:53
Date last run: 2024-03-01 10:39:45

----------

Public: 0
Expiry: 300

----------

<div class="reportInfo noprint"> 
 
  <div class="reportInfoContent"> 
 
    <p>Generates a USPS mailing list for borrowers with the "Email Newsletter Permission" flag set to "Yes"</p> 
 
    <ul> 
      <li>Shows borrowers that currently have the flag set</li> 
      <li>at the library you specify</li> 
      <li>grouped by borrowernumber</li> 
      <li>sorted by surname, first name, middle name</li> 
    </ul> 
 
  </div> 
 
  <div class="reportInfoNotes"> 
 
  </div> 
 
  <div id="reportInfoTags"> 
 
    <p style="display: none;"> 
      #newsletter #borrower attribute 
    </p> 
 
  </div>

----------
*/



SELECT
  borrowers.firstname,
  borrowers.middle_name,
  borrowers.surname,
  borrowers.address,
  borrowers.address2,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  borrowers.dateexpiry,
  categories.description,
  newsletter_permission.attribute AS NEWSLETTER_PERMISSION
FROM
  borrowers LEFT JOIN
  (
    SELECT
      borrower_attributes.borrowernumber,
      authorised_values.lib,
      borrower_attributes.attribute
    FROM
      borrower_attributes JOIN
      authorised_values ON borrower_attributes.attribute =
          authorised_values.authorised_value
    WHERE
      borrower_attributes.code = 'NEWSLETTER' AND
      authorised_values.category = 'EmailNews'
    GROUP BY
      borrower_attributes.borrowernumber,
      borrower_attributes.attribute
  ) newsletter_permission 
    ON borrowers.borrowernumber = newsletter_permission.borrowernumber 
  LEFT JOIN categories 
    ON borrowers.categorycode = categories.categorycode
WHERE
  borrowers.branchcode LIKE &lt;&gt; AND
  Coalesce(newsletter_permission.attribute, "~") LIKE 'Yes'
GROUP BY
  borrowers.borrowernumber
ORDER BY
  borrowers.surname,
  borrowers.firstname,
  borrowers.middle_name

























