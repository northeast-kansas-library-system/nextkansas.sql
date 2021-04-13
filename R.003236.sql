/*
R.003236

----------

Name: GHW - Attribute test 3
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-07-24 23:39:59
Modified on: 2019-07-25 00:52:31
Date last run: 2019-07-27 11:06:22

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  columncreator.branchcode AS LIBRARY,
  columncreator.description,
  Concat_Ws(' // ', columncreator.CAT_DESC, columncreator.AV_DESC) AS EXTENDED_ATTRIBUTE,
  Count(borrowerss.borrowernumber) AS PATRON_COUNT,
  Concat('<a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3235&phase=Run+this+report&param_name=Choose+your+library%7CLBRANCH&sql_params=', columncreator.branchcode, '&param_name=Choose+attribute+type%7CQ_BORROWER_ATTRIBUTES_A&sql_params=', columncreator.CAT_CODE, '&param_name=Enter+attribute+value+or+a+%25+symbol&sql_params=', If(columncreator.AV_CODE = 'X', '%', columncreator.AV_CODE), ' " target="_blank">Go to detailed report</a>') AS LINK_TO_DETAILED_REPORT
FROM
  (
    SELECT
      branches.branchcode,
      attributess.CAT_DESC,
      attributess.CAT_CODE,
      attributess.AV_DESC,
      attributess.AV_CODE,
      categories.categorycode,
      categories.description
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
      ) attributess,
      categories
    ORDER BY
      branches.branchcode
  ) columncreator
  LEFT JOIN (
    SELECT
      borrowers.branchcode,
      borrower_attributes.code,
      borrower_attributes.borrowernumber,
      If(borrower_attribute_types.authorised_value_category = '', 'X', borrower_attributes.attribute) AS attribute,
      borrower_attribute_types.authorised_value_category,
      borrowers.categorycode
    FROM
      borrowers
      JOIN borrower_attributes
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
      borrowerss.attribute = columncreator.AV_CODE AND
      borrowerss.categorycode = columncreator.categorycode
WHERE
  columncreator.branchcode LIKE <<Choose your library|ZBRAN>> AND
  columncreator.CAT_CODE LIKE <<Extended attribute category|Q_BORROWER_ATTRIBUTES_A>> AND
  columncreator.AV_CODE LIKE <<Select special locations attribute|LSPECLOC>>
GROUP BY
  columncreator.branchcode,
  columncreator.description,
  columncreator.CAT_CODE,
  columncreator.AV_CODE
HAVING
  PATRON_COUNT >= <<View rows with at least X patrons|YNUMBER>>
ORDER BY
  LIBRARY,
  columncreator.description,
  EXTENDED_ATTRIBUTE



