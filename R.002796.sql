/*
R.002796

----------

Name: GHW - Duplicate holds on a bibliographic record
Created by: George H Williams

----------

Group: Holds-Reserves
     Duplicate request problems

Created on: 2016-10-10 08:59:30
Modified on: 2018-04-16 11:02:22
Date last run: 2019-02-05 21:53:57

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Searches for duplicate patron holds on a bibliographic record</p>
<ul><li>Searches for current requests</li>
<li>on a specified biblionumber (text input accepts wildcards)</li>
<li>grouped by biblionumber and borrowernumber</li>
<li>sorted by biblionumber and borrowernumber</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p>Helpful for identifying duplicate requests caused by merging records.</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2796&phase=Run%20this%20report"  target="_blank">Click here to run this report in a new window.</a></p>
</div>


----------
*/



SELECT
  reserves.biblionumber,
  reserves.borrowernumber,
  borrowers.surname,
  COUNT(reserves.borrowernumber) AS COUNT_OF_REQUESTS
FROM reserves JOIN borrowers ON reserves.borrowernumber = borrowers.borrowernumber
WHERE (reserves.biblionumber LIKE <<Enter biblionumber>>)
GROUP BY reserves.biblionumber, reserves.borrowernumber
HAVING COUNT_OF_REQUESTS > 1

























