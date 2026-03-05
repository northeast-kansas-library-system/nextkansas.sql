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
Date last run: 2026-01-08 11:47:20

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportInfo noprint"&gt; 
 
  &lt;div class="reportInfoContent"&gt; 
 
    &lt;p&gt;Generates a USPS mailing list for borrowers with the "Email Newsletter Permission" flag set to "Yes"&lt;/p&gt; 
 
    &lt;ul&gt; 
      &lt;li&gt;Shows borrowers that currently have the flag set&lt;/li&gt; 
      &lt;li&gt;at the library you specify&lt;/li&gt; 
      &lt;li&gt;grouped by borrowernumber&lt;/li&gt; 
      &lt;li&gt;sorted by surname, first name, middle name&lt;/li&gt; 
    &lt;/ul&gt; 
 
  &lt;/div&gt; 
 
  &lt;div class="reportInfoNotes"&gt; 
 
  &lt;/div&gt; 
 
  &lt;div id="reportInfoTags"&gt; 
 
    &lt;p style="display: none;"&gt; 
      #newsletter #borrower attribute 
    &lt;/p&gt; 
 
  &lt;/div&gt;

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

























