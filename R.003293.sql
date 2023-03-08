/*
R.003293

----------

Name: GHW - Spreadsheet builder - Branches and collection codes
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-12-31 14:13:24
Modified on: 2023-02-01 16:17:40
Date last run: 2023-02-01 16:26:40

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  rnums.row_number,
  ccodess.code_number,
  CONCAT(If(rnums.row_number % 2 <> 0, "Odd", "Even"), If(Right(ccodess.code_number, 1) % 2 <> 0, "Odd", "Even")) As EO,
  rnums.branchname As `Library Name`,
  authorised_values.lib As `Collection Code`,
  Concat("") As `CKO + Renewal`,
  Concat("") As `CKO + Renewal Adult`,
  Concat("") As `CKO + Renewal Childrens`,
  Concat("") As `CKO + Renewal Young Adult`,
  Concat("") As `CKO + Renewal Other`
From
  (Select
     @row_number := @row_number + 1 As row_number,
     branchesx.branchcode,
     branchesx.branchname
   From
     (Select
        @row_number := 0) As t,
     (Select
        branches.branchcode,
        branches.branchname
      From
        branches
      UNION
      Select
        Concat("DONIZ") As branchcode,
        Concat("YY Doniphan County Library -- Combined") As branchname
      From
        branches
      UNION
      Select
        Concat("PHZ") As branchcode,
        Concat("ZZ Prairie Hills Schools -- Combined") As branchname
      From
        branches) branchesx
   Order By
     branchesx.branchname) rnums,
  authorised_values Inner Join
  (Select
     @code_number := @code_number + 1 As code_number,
     authorised_values.category,
     authorised_values.authorised_value,
     authorised_values.lib
   From
     (Select
        @code_number := 0) As t,
     authorised_values
   Where
     authorised_values.category = 'ccode'
   Group By
     authorised_values.lib
   Order By
     authorised_values.lib,
     authorised_values.authorised_value) ccodess On ccodess.authorised_value = authorised_values.authorised_value
Where
  authorised_values.category = 'CCODE'
Order By
  `Library Name`,
  `Collection Code`,
  rnums.branchcode
Limit 10000

























