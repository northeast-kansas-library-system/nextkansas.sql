/*
R.003779

----------

Name: GHW - borrower count by school district
Created by: George Williams

----------

Group:  BONNERSPGS
     -

Created on: 2023-10-26 14:34:29
Modified on: 2023-10-27 12:33:24
Date last run: 2023-10-30 10:52:14

----------

Public: 0
Expiry: 300

----------

School district names, numbers, and home county data comes from state of Kansas department of revenue site - https://www.ksrevenue.gov/pdf/SchoolDistricts.pdf

Borrowers are mapped via policymap.com

----------
*/



SELECT 
  branches_usd.branchname AS BORROWER_HOME_LIBRARY, 
  branches_usd.lib AS BORROWER_RESIDES_IN, 
  Coalesce(borrower_counts.borrower_count, 0) AS BORROWER_COUNT 
FROM ( 
    SELECT 
      branches.branchname, 
      authorised_values.lib, 
      branches.branchcode, 
      authorised_values.authorised_value 
    FROM branches, 
      authorised_values 
    WHERE authorised_values.category = 'USD' 
      AND branches.branchcode LIKE 'BONNERSPGS' 
    GROUP BY 
      branches.branchname, 
      authorised_values.lib, 
      branches.branchcode, 
      authorised_values.authorised_value 
  ) branches_usd 
  LEFT JOIN ( 
    SELECT 
      borrowers.branchcode, 
      usd_attributes.description, 
      If( 
        usd_attributes.authorised_value IS NULL, 
        '-', 
        usd_attributes.authorised_value 
      ) AS authorised_value, 
      usd_attributes.lib, 
      Count(DISTINCT borrowers.borrowernumber) AS borrower_count 
    FROM ( 
        SELECT 
          borrower_attribute_types.code, 
          borrower_attribute_types.description, 
          authorised_values.authorised_value, 
          authorised_values.lib, 
          borrower_attributes.borrowernumber 
        FROM borrower_attribute_types 
          JOIN authorised_values ON authorised_values.category = borrower_attribute_types.authorised_value_category 
          LEFT JOIN borrower_attributes ON borrower_attributes.attribute = authorised_values.authorised_value 
          AND borrower_attributes.code = borrower_attribute_types.code 
        WHERE borrower_attribute_types.code = 'USD' 
      ) usd_attributes 
      RIGHT JOIN borrowers ON borrowers.borrowernumber = usd_attributes.borrowernumber 
    GROUP BY 
      borrowers.branchcode, 
      usd_attributes.description, 
      If( 
        usd_attributes.authorised_value IS NULL, 
        '-', 
        usd_attributes.authorised_value 
      ), 
      usd_attributes.lib 
  ) borrower_counts 
    ON borrower_counts.branchcode = branches_usd.branchcode 
    AND borrower_counts.authorised_value = branches_usd.authorised_value

























