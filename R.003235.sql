/*
R.003235

----------

Name: GHW - Patrons at a specific library with a specific attribute
Created by: George Williams

----------

Group: Borrowers
     Patron attributes

Created on: 2019-07-24 14:19:18
Modified on: 2024-01-17 12:08:34
Date last run: 2025-04-14 16:53:50

----------

Public: 0
Expiry: 300

----------

 
Lists all patrons at your library with the extended attribute category and attribute you specify
Lists current patrons with the attribute information you specify
at the library you specify
grouped and sorted by patron home library, patron attribute category, and patron attribute
links to the patron's account

Notes:

Designed to work in conjunction with report 3234.

Patrons can have multiple extended attributes on their accounts.  Similarly, patrons may not have any extended attributes on their accounts.  If this report is configured to report on multiple attributes at one time, it is possible that some patrons will show up on this list multiple times.

For more detailed information than this report provides use the following reports:

3086 - GHW - Patron attributes - Newsletter permissions 
3087 - GHW - Patron attributes - Movie permissions 
3088 - GHW - Patron attributes - Internet permissions
3089 - GHW - Patron attributes - Special locations 
3090 - GHW - Patron attributes - Holds contact
3091 - GHW - Patron attributes - Account expired
3092 - GHW - Patron attributes - Collection agency
3093 - GHW - Patron attributes - Other attributes 1 / Other attributes 2 / Registration library


Click here to run in a new window


----------
*/



SELECT
  Concat('Go to patron account') AS LINK,
  borrowers.branchcode,
  borrowers.cardnumber,
  Concat_Ws('', borrowers.surname, ' / ', borrowers.firstname, If(borrowers.othernames = '', '', Concat_Ws('', ' (', borrowers.othernames, ')'))) AS NAME,
  categories.description AS PATRON_CATEGORY,
  borrower_attribute_types.description AS ATTRIBUTE_TYPE,
  If(authorised_values.lib IS NULL, borrower_attributes.attribute, authorised_values.lib) AS ATTRIBUTE_TEXT,
  borrower_attributes.attribute
FROM
  borrower_attributes
  JOIN borrowers
    ON borrower_attributes.borrowernumber = borrowers.borrowernumber
  JOIN borrower_attribute_types
    ON borrower_attributes.code = borrower_attribute_types.code
  LEFT JOIN authorised_values
    ON authorised_values.category = borrower_attribute_types.authorised_value_category AND
      authorised_values.authorised_value = borrower_attributes.attribute
  JOIN categories
    ON borrowers.categorycode = categories.categorycode
WHERE
  borrowers.branchcode LIKE &lt;&gt; AND
  borrower_attributes.code LIKE &lt;&gt; AND
  borrower_attributes.attribute LIKE &lt;&gt;
ORDER BY
  borrowers.branchcode,
  NAME,
  borrowers.cardnumber

























