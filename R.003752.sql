/*
R.003752

----------

Name: GHW - Sex report
Created by: George Williams

----------

Group: -
     -

Created on: 2023-08-18 16:37:26
Modified on: 2024-01-17 11:13:53
Date last run: 2025-01-24 08:30:07

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
 
  <div class="reportInfoContent"> 
 
    <p>Counts borrowers based on the sex listed in their account</p> 
 
    <ul> 
      <li>Shows current data in Next Search Catalog</li> 
      <li>at the library you specify</li> 
      <li>grouped and sorted by library and sex</li> 
    </ul> 
 
  </div>

  <div class="reportInfoNotes">
 
    <p> 
 
    </p> 

    <p> 
      Sex data will be deleted from Next Search Catalog on September 15, 2023.
    </p> 
 
    <p> 
 
    </p> 
   
  </div> 

----------
*/



SELECT 
  branches_counts.branchname,
  If(
    Coalesce(borrowers.sex, '') = '', 
    '_BLANK_', 
    borrowers.sex
  ) AS sex, 
  Count(DISTINCT borrowers.borrowernumber) AS BORROWER_COUNT,
  format(
    100 *(
      Count(DISTINCT borrowers.borrowernumber) / branches_counts.Count_borrowernumber
    ),
    2
  ) AS PERCENTAGE
FROM 
  (
    SELECT branches.branchname,
      branches.branchcode,
      Count(borrowers.borrowernumber) AS Count_borrowernumber
    FROM borrowers
      RIGHT JOIN branches ON borrowers.branchcode = branches.branchcode
    GROUP BY branches.branchname,
      branches.branchcode
  ) branches_counts
  LEFT JOIN borrowers ON borrowers.branchcode = branches_counts.branchcode
WHERE
  branches_counts.branchcode LIKE <<Choose your library|LBRANCH>>
GROUP BY 
  branches_counts.branchname,
  Coalesce(borrowers.sex, '')
ORDER BY 
  branches_counts.branchname,
  sex

























