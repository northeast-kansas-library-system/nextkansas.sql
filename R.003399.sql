/*
R.003399

----------

Name: GHW - Borrower count by age and borrower category
Created by: George H Williams

----------

Group: Borrowers
     Patron Statistics

Created on: 2021-01-11 17:05:34
Modified on: 2021-05-21 16:57:42
Date last run: 2021-06-08 13:53:37

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Counts borrowers at a library by age (in years)</p>
<ul><li>Counts current borrowers</li>
<li>where the borrowers home library matches the library you specify and the borrower category matches the category you select</li>
<li>grouped and sorted by borrowers home branch, borrowers category, and age</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Counts in the "BLANK_OR_BAD_CODE" column represent borrowers where the gender radio button on their account is either not set, or is set to a data code that is no longer in use.</p>
<p></p>
<p></p>
<p>Replaces report 1081 and 2443</p>
<p class= "notetags" style="display: none;">borrower count age</p>
</div>

----------
*/

SELECT
  branchescategories.branchname,
  branchescategories.description,
  ages.BORROWER_AGE AS BORROWER_AGE,
  Coalesce(ages.COUNT_OF_BORROWERS, '-') AS TOTAL_BORROWERS,
  FEMALE.COUNT_OF_BORROWERS AS FEMALE,
  MALE.COUNT_OF_BORROWERS AS MALE,
  NAS.COUNT_OF_BORROWERS AS NOT_SPECIFIED,
  BLANK_OR_UNKNOWN.COUNT_OF_BORROWERS AS BLANK_OR_BAD_CODE
FROM
  (SELECT
      borrowers.branchcode,
      Coalesce(floor(DateDiff(CurDate(), borrowers.dateofbirth) / 365.25),
      '-') AS BORROWER_AGE,
      Count(borrowers.borrowernumber) AS COUNT_OF_BORROWERS,
      borrowers.categorycode
    FROM
      borrowers
    GROUP BY
      borrowers.branchcode,
      Coalesce(floor(DateDiff(CurDate(), borrowers.dateofbirth) / 365.25), '-'),
      borrowers.categorycode) ages INNER JOIN
  (SELECT
      branches.branchname,
      branches.branchcode,
      categories.categorycode,
      categories.description
    FROM
      branches,
      categories) branchescategories ON
      ages.branchcode = branchescategories.branchcode AND
      ages.categorycode = branchescategories.categorycode LEFT JOIN
  (SELECT
      borrowers.branchcode,
      Coalesce(floor(DateDiff(CurDate(), borrowers.dateofbirth) / 365.25),
      '-') AS BORROWER_AGE,
      Count(borrowers.borrowernumber) AS COUNT_OF_BORROWERS,
      borrowers.categorycode
    FROM
      borrowers
    WHERE
      borrowers.sex = 'F'
    GROUP BY
      borrowers.branchcode,
      Coalesce(floor(DateDiff(CurDate(), borrowers.dateofbirth) / 365.25), '-'),
      borrowers.categorycode) FEMALE ON
      FEMALE.branchcode = branchescategories.branchcode AND
      FEMALE.categorycode = branchescategories.categorycode AND
      FEMALE.BORROWER_AGE = ages.BORROWER_AGE LEFT JOIN
  (SELECT
      borrowers.branchcode,
      Coalesce(floor(DateDiff(CurDate(), borrowers.dateofbirth) / 365.25),
      '-') AS BORROWER_AGE,
      Count(borrowers.borrowernumber) AS COUNT_OF_BORROWERS,
      borrowers.categorycode
    FROM
      borrowers
    WHERE
      borrowers.sex = 'M'
    GROUP BY
      borrowers.branchcode,
      Coalesce(floor(DateDiff(CurDate(), borrowers.dateofbirth) / 365.25), '-'),
      borrowers.categorycode) MALE ON
      MALE.branchcode = branchescategories.branchcode AND
      MALE.categorycode = branchescategories.categorycode AND
      MALE.BORROWER_AGE = ages.BORROWER_AGE LEFT JOIN
  (SELECT
      borrowers.branchcode,
      Coalesce(floor(DateDiff(CurDate(), borrowers.dateofbirth) / 365.25),
      '-') AS BORROWER_AGE,
      Count(borrowers.borrowernumber) AS COUNT_OF_BORROWERS,
      borrowers.categorycode
    FROM
      borrowers
    WHERE
      borrowers.sex = 'N'
    GROUP BY
      borrowers.branchcode,
      Coalesce(floor(DateDiff(CurDate(), borrowers.dateofbirth) / 365.25), '-'),
      borrowers.categorycode) NAS ON
      NAS.branchcode = branchescategories.branchcode AND
      NAS.categorycode = branchescategories.categorycode AND
      NAS.BORROWER_AGE = ages.BORROWER_AGE LEFT JOIN
  (SELECT
      borrowers.branchcode,
      Coalesce(floor(DateDiff(CurDate(), borrowers.dateofbirth) / 365.25),
      '-') AS BORROWER_AGE,
      Count(borrowers.borrowernumber) AS COUNT_OF_BORROWERS,
      borrowers.categorycode
    FROM
      borrowers
    WHERE
      (borrowers.sex IS NULL) OR
      (borrowers.sex <> 'N' AND
          borrowers.sex <> 'F' AND
          borrowers.sex <> 'M')
    GROUP BY
      borrowers.branchcode,
      Coalesce(floor(DateDiff(CurDate(), borrowers.dateofbirth) / 365.25), '-'),
      borrowers.categorycode) BLANK_OR_UNKNOWN ON BLANK_OR_UNKNOWN.branchcode =
      branchescategories.branchcode AND
      BLANK_OR_UNKNOWN.categorycode = branchescategories.categorycode AND
      BLANK_OR_UNKNOWN.BORROWER_AGE = ages.BORROWER_AGE
WHERE
  branchescategories.branchcode LIKE <<Choose your library|ZBRAN>> AND
  branchescategories.categorycode LIKE <<Choose a borrower category|LBORROWERCAT>>
GROUP BY
  branchescategories.branchname,
  branchescategories.description,
  ages.BORROWER_AGE,
  FEMALE.COUNT_OF_BORROWERS,
  MALE.COUNT_OF_BORROWERS,
  NAS.COUNT_OF_BORROWERS,
  BLANK_OR_UNKNOWN.COUNT_OF_BORROWERS
ORDER BY
  branchescategories.branchname,
  branchescategories.description,
  LPad(ages.BORROWER_AGE, 4, 0)



