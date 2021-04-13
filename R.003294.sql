/*
R.003294

----------

Name: GHW - Spreadsheet builder - Item type
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-12-31 15:05:33
Modified on: 2020-02-05 16:59:32
Date last run: 2021-02-04 22:50:55

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  rnums.row_number,
  If(rnums.row_number % 2 <> 0, "Odd", "Even") AS OE,
  itypecnt.code_number,
  If(Right(itypecnt.code_number, 1) % 2 <> 0, "Odd", "Even") AS EO,
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
        Concat("Doniphan County Library -- Combined") As branchname
      From
        branches
      UNION
      Select
        Concat("PHZ") As branchcode,
        Concat("Prairie Hills Schools -- Combined") As branchname
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
    ORDER BY
      itemtypes.description
  ) itypecnt
  INNER JOIN itemtypes
    ON itypecnt.itemtype = itemtypes.itemtype
ORDER BY
  `Library Name`,
  `Item Type`,
  rnums.branchcode
LIMIT 10000



