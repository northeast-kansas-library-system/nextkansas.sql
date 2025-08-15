/*
R.003780

----------

Name: GHW - Borrower count by county sub-division
Created by: George Williams

----------

Group:  BONNERSPGS
     -

Created on: 2023-10-26 16:04:58
Modified on: 2023-10-27 12:33:47
Date last run: 2023-10-30 10:54:59

----------

Public: 0
Expiry: 300

----------

Data is not set for the following conditions:

borrower category code = STAFF, ILL, or INHOUSE

Borrower's address lies outside of Wyandotte, Johnson, or Leavenworth county - i.e. borrowers with addresses in Lawrence, Atchison, Eudora, etc.

The borrower's address can not be mapped in Policy Map.  This can be for addresses where address line 1 and/or address line 2 is not a valid mapped address in Policy map; it can be where the city, state, and zip code do not match a valid combination of address, city, state, and zip code (i.e. 4317 W 6th St, Bonner Springs, KS, 66047; or Bonner Springs, MO, 66012; or Banerspring, KS 66012; will probably not map correctly).

Data points that could not be geocoded by Policy Map were mapped, when possible, by George's best guess - i.e. if the borrower had an un-map-able Bonner Springs address, they were mapped to "Wyandotte : Bonner Springs - City"; if the borrower had an un-map-able Edwardsville address, they were mapped to "Wyandotte : Edwardsville - City."  The most common addresses that could not be mapped properly were in Lake of the Forest - a private, gated community in the southeast corner of Bonner Springs.

Borrowers who have been added after the last time the data was mapped to Policy Map (Policy Map data for BONNERSPGS was last updated on 2023-10-24).

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
    WHERE authorised_values.category = 'CNTY_SUB' 
      AND branches.branchcode LIKE 'BONNERSPGS' 
    GROUP BY branches.branchname, 
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
        WHERE borrower_attribute_types.code = 'CNTY_SUB' 
      ) usd_attributes 
      RIGHT JOIN borrowers ON borrowers.borrowernumber = usd_attributes.borrowernumber 
    GROUP BY borrowers.branchcode, 
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

























