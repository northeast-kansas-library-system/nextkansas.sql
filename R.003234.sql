/*
R.003234

----------

Name: GHW - Patron count by extended attribute
Created by: George H Williams

----------

Group: Borrowers
     Patron attributes

Created on: 2019-07-24 13:40:33
Modified on: 2019-07-25 08:30:25
Date last run: 2021-09-10 12:59:24

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Generates a count of patrons with extended attributes at your library</p>
<ul><li>Counts current patrons with attributes</li>
<li>at the library you specify</li>
<li>allows you to specify a minimum patron count for displaying an attribute count (i.e. only show attributes assigned to at least X patrons)</li>
<li>grouped and sorted by patron home branch, attribute category, and attribute</li>
<li>contains links to report 3235 which will list all of the patrons at your library with the attribute specified</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Patrons can have multiple extended attributes on their accounts.  Similarly, patrons may not have any extended attributes on their accounts.  A total count of patrons from all of the rows of this report will not indicate an accurate count of total patrons at your library.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3234&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  columncreator.branchcode AS LIBRARY,
  Concat_Ws(' // ', columncreator.CAT_DESC, columncreator.AV_DESC) AS EXTENDED_ATTRIBUTE,
  Count(borrowerss.borrowernumber) AS PATRON_COUNT,
  Concat('<a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3235&phase=Run+this+report&param_name=Choose+your+library%7CLBRANCH&sql_params=', columncreator.branchcode, '&param_name=Choose+attribute+type%7CQ_BORROWER_ATTRIBUTES_A&sql_params=', columncreator.CAT_CODE, '&param_name=Enter+attribute+value+or+a+%25+symbol&sql_params=', IF(columncreator.AV_CODE = 'X', '%', columncreator.AV_CODE), ' " target="_blank">Go to detailed report</a>') AS LINK_TO_DETAILED_REPORT
FROM
  (
    SELECT
      branches.branchcode,
      attributess.CAT_DESC,
      attributess.CAT_CODE,
      attributess.AV_DESC,
      attributess.AV_CODE
    FROM
      branches,
      (
        SELECT
          borrower_attribute_types.code AS CAT_CODE,
          borrower_attribute_types.description AS CAT_DESC,
          If(authorised_values.authorised_value IS NULL, 'X', authorised_values.authorised_value) AS AV_CODE,
          authorised_values.lib AS AV_DESC
        FROM
          borrower_attribute_types
          LEFT JOIN authorised_values
            ON authorised_values.category = borrower_attribute_types.authorised_value_category
      ) attributess
    ORDER BY
      branches.branchcode
  ) columncreator
  LEFT JOIN (
    SELECT
      borrowers.branchcode,
      borrower_attributes.code,
      borrower_attributes.borrowernumber,
      If(borrower_attribute_types.authorised_value_category = '', 'X', borrower_attributes.attribute) AS attribute,
      borrower_attribute_types.authorised_value_category
    FROM
      borrowers
      INNER JOIN borrower_attributes
        ON borrower_attributes.borrowernumber = borrowers.borrowernumber
      LEFT JOIN borrower_attribute_types
        ON borrower_attributes.code = borrower_attribute_types.code
    ORDER BY
      borrowers.branchcode,
      borrower_attributes.code,
      borrower_attributes.attribute,
      borrower_attributes.borrowernumber
  ) borrowerss
    ON borrowerss.branchcode = columncreator.branchcode AND
      borrowerss.code = columncreator.CAT_CODE AND
      borrowerss.attribute = columncreator.AV_CODE
WHERE
  columncreator.branchcode LIKE <<Choose your library|ZBRAN>> AND
  columncreator.CAT_CODE LIKE <<Extended attribute category|Q_BORROWER_ATTRIBUTES_A>>
GROUP BY
  columncreator.branchcode,
  columncreator.CAT_CODE,
  columncreator.AV_CODE
HAVING
  PATRON_COUNT >= <<View rows with at least X patrons|YNUMBER>>
ORDER BY
  LIBRARY,
  EXTENDED_ATTRIBUTE



