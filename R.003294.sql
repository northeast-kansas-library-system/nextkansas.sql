/*
R.003294

----------

Name: GHW - Spreadsheet builder - Item type
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-12-31 15:05:33
Modified on: 2023-02-01 14:45:20
Date last run: 2023-02-01 14:45:47

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  rnums.row_number,
  itypecnt.code_number,
  CONCAT(If(rnums.row_number % 2 <> 0, "Odd", "Even"), If(Right(itypecnt.code_number, 1) % 2 <> 0, "Odd", "Even")) As EO,
  rnums.branchname AS `Library Name`,
  itemtypes.description AS `Item Type`,
  Concat("") AS `CKO + Renewal`,
  Concat("") AS `CKO + Renewal Adult`,
  Concat("") AS `CKO + Renewal Childrens`,
  Concat("") AS `CKO + Renewal Young Adult`,
  Concat("") AS `CKO + Renewal Other`
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
        Concat("Y Doniphan County Library -- All") As branchname
      From
        branches
      UNION
      Select
        Concat("PHZ") As branchcode,
        Concat("Z Prairie Hills Schools -- All") As branchname
      From
        branches) branchesx
   Order By
     branchesx.branchname) rnums,
  (
    SELECT
      @code_number := @code_number + 1 AS code_number,
      itemtypes.itemtype,
      itemtypes.description
    FROM
      (
        SELECT
          @code_number := 0
      ) AS t,
      itemtypes
    Group By
      itemtypes.description
    ORDER BY
      itemtypes.description
  ) itypecnt
  JOIN itemtypes
    ON itypecnt.itemtype = itemtypes.itemtype
ORDER BY
  `Library Name`,
  `Item Type`,
  rnums.branchcode
LIMIT 10000

























