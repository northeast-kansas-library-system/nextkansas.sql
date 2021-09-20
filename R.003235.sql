/*
R.003235

----------

Name: GHW - Patrons at a specific library with a specific attribute
Created by: George H Williams

----------

Group: Borrowers
     Patron attributes

Created on: 2019-07-24 14:19:18
Modified on: 2019-07-25 10:43:22
Date last run: 2021-09-16 16:12:38

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Lists all patrons at your library with the extended attribute category and attribute you specify</p>
<ul><li>Lists current patrons with the attribute information you specify</li>
<li>at the library you specify</li>
<li>grouped and sorted by patron home library, patron attribute category, and patron attribute</li>
<li>links to the patron's account</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Designed to work in conjunction with report 3234.</p>
<p></p>
<p>Patrons can have multiple extended attributes on their accounts.  Similarly, patrons may not have any extended attributes on their accounts.  If this report is configured to report on multiple attributes at one time, it is possible that some patrons will show up on this list multiple times.</p>
<p></p>
<p>For more detailed information than this report provides use the following reports:</p>
<ul>
<li>3086 - GHW - Patron attributes - Newsletter permissions </li>
<li>3087 - GHW - Patron attributes - Movie permissions </li>
<li>3088 - GHW - Patron attributes - Internet permissions</li>
<li>3089 - GHW - Patron attributes - Special locations </li>
<li>3090 - GHW - Patron attributes - Holds contact</li>
<li>3091 - GHW - Patron attributes - Account expired</li>
<li>3092 - GHW - Patron attributes - Collection agency</li>
<li>3093 - GHW - Patron attributes - Other attributes 1 / Other attributes 2 / Registration library</li>
</ul>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3235&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  Concat('<a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=', borrowers.borrowernumber, '" target="_blank">Go to patron account</a>') AS LINK,
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
  borrowers.branchcode LIKE <<Choose your library|LBRANCH>> AND
  borrower_attributes.code LIKE <<Choose attribute type|Q_BORROWER_ATTRIBUTES_A>> AND
  borrower_attributes.attribute LIKE <<Enter attribute value or a % symbol>>
ORDER BY
  borrowers.branchcode,
  NAME,
  borrowers.cardnumber



