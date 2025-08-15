/*
R.003398

----------

Name: GHW - Borrower count by age
Created by: George Williams

----------

Group: Borrowers
     Patron attributes

Created on: 2021-01-11 16:32:52
Modified on: 2024-01-17 12:02:43
Date last run: 2024-10-02 13:49:57

----------

Public: 0
Expiry: 300

----------

 
Counts borrowers at a library by age (in years) and gender indicator
Counts current borrowers
where the borrowers home library matches the library you specify
grouped and sorted by borrowers home branch and age

Notes:

Counts in the "BLANK_OR_BAD_CODE" column represent borrowers where the gender radio button on their account is either not set, or is set to a data code that is no longer in use.


Partly replaces report 1081.
Click here to run in a new window
Click here to download as a csv file
borrower count


----------
*/



SELECT
  branches.branchname,
  ages.BORROWER_AGE AS BORROWER_AGE,
  Coalesce(ages.COUNT_OF_BORROWERS, '-') AS TOTAL_BORROWERS,
  Coalesce(FEMALE.COUNT_OF_BORROWERS, '-') AS FEMALE,
  Coalesce(MALE.COUNT_OF_BORROWERS, '-') AS MALE,
  Coalesce(NAS.COUNT_OF_BORROWERS, '-') AS NOT_SPECIFIED,
  Coalesce(BLANK_OR_UNKNOWN.COUNT_OF_BORROWERS, '-') AS BLANK_OR_BAD_CODE
FROM
  branches JOIN
  (SELECT
      borrowers.branchcode,
      Coalesce(floor(DateDiff(CurDate(), borrowers.dateofbirth) / 365.25), '-') AS BORROWER_AGE,
      Count(borrowers.borrowernumber) AS COUNT_OF_BORROWERS
    FROM
      borrowers
    GROUP BY
      borrowers.branchcode,
      Coalesce(floor(DateDiff(CurDate(), borrowers.dateofbirth) / 365.25),
      '-')) ages ON ages.branchcode = branches.branchcode LEFT JOIN
  (SELECT
      borrowers.branchcode,
      Coalesce(floor(DateDiff(CurDate(), borrowers.dateofbirth) / 365.25), '-') AS BORROWER_AGE,
      Count(borrowers.borrowernumber) AS COUNT_OF_BORROWERS
    FROM
      borrowers
    WHERE
      borrowers.sex LIKE 'N'
    GROUP BY
      borrowers.branchcode,
      Coalesce(floor(DateDiff(CurDate(), borrowers.dateofbirth) / 365.25), '-')) NAS 
      ON NAS.branchcode = branches.branchcode AND
      NAS.BORROWER_AGE = ages.BORROWER_AGE LEFT JOIN
  (SELECT
      borrowers.branchcode,
      Coalesce(floor(DateDiff(CurDate(), borrowers.dateofbirth) / 365.25), '-') AS BORROWER_AGE,
      Count(borrowers.borrowernumber) AS COUNT_OF_BORROWERS
    FROM
      borrowers
    WHERE
      borrowers.sex LIKE 'F'
    GROUP BY
      borrowers.branchcode,
      Coalesce(floor(DateDiff(CurDate(), borrowers.dateofbirth) / 365.25), '-')) FEMALE 
      ON FEMALE.branchcode = branches.branchcode AND
      FEMALE.BORROWER_AGE = ages.BORROWER_AGE LEFT JOIN
  (SELECT
      borrowers.branchcode,
      Coalesce(floor(DateDiff(CurDate(), borrowers.dateofbirth) / 365.25), '-') AS BORROWER_AGE,
      Count(borrowers.borrowernumber) AS COUNT_OF_BORROWERS
    FROM
      borrowers
    WHERE
      borrowers.sex LIKE 'M'
    GROUP BY
      borrowers.branchcode,
      Coalesce(floor(DateDiff(CurDate(), borrowers.dateofbirth) / 365.25), '-')) MALE 
      ON MALE.branchcode = branches.branchcode AND
      MALE.BORROWER_AGE = ages.BORROWER_AGE LEFT JOIN
  (SELECT
      borrowers.branchcode,
      Coalesce(floor(DateDiff(CurDate(), borrowers.dateofbirth) / 365.25), '-') AS BORROWER_AGE,
      Count(borrowers.borrowernumber) AS COUNT_OF_BORROWERS
    FROM
      borrowers
    WHERE
      (borrowers.sex IS NULL) OR
      (borrowers.sex &lt;&gt; 'N' AND
          borrowers.sex &lt;&gt; 'F' AND
          borrowers.sex &lt;&gt; 'M')
    GROUP BY
      borrowers.branchcode,
      Coalesce(floor(DateDiff(CurDate(), borrowers.dateofbirth) / 365.25), '-')) BLANK_OR_UNKNOWN 
      ON BLANK_OR_UNKNOWN.branchcode =
      branches.branchcode AND
      BLANK_OR_UNKNOWN.BORROWER_AGE = ages.BORROWER_AGE
WHERE
  branches.branchcode LIKE &lt;&gt;
GROUP BY
  branches.branchname,
  ages.BORROWER_AGE
ORDER BY
  branches.branchcode,
  LPad(ages.BORROWER_AGE, 4, 0)

























