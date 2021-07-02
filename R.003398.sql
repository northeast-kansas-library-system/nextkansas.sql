/*
R.003398

----------

Name: GHW - Borrower count by age
Created by: George H Williams

----------

Group: Borrowers
     Patron attributes

Created on: 2021-01-11 16:32:52
Modified on: 2021-01-11 16:38:28
Date last run: 2021-06-09 18:57:20

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Counts borrowers at a library by age (in years) and gender indicator</p>
<ul><li>Counts current borrowers</li>
<li>where the borrowers home library matches the library you specify</li>
<li>grouped and sorted by borrowers home branch and age</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Counts in the "BLANK_OR_BAD_CODE" column represent borrowers where the gender radio button on their account is either not set, or is set to a data code that is no longer in use.</p>
<p></p>
<p></p>
<p>Partly replaces report 1081.</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3398&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3398">Click here to download as a csv file</a></p>
<p class= "notetags" style="display: none;">borrower count</p>
</div>

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
      (borrowers.sex <> 'N' AND
          borrowers.sex <> 'F' AND
          borrowers.sex <> 'M')
    GROUP BY
      borrowers.branchcode,
      Coalesce(floor(DateDiff(CurDate(), borrowers.dateofbirth) / 365.25), '-')) BLANK_OR_UNKNOWN 
      ON BLANK_OR_UNKNOWN.branchcode =
      branches.branchcode AND
      BLANK_OR_UNKNOWN.BORROWER_AGE = ages.BORROWER_AGE
WHERE
  branches.branchcode LIKE <<Choose your library|ZBRAN>>
GROUP BY
  branches.branchname,
  ages.BORROWER_AGE
ORDER BY
  branches.branchcode,
  LPad(ages.BORROWER_AGE, 4, 0)



