/*
R.003186

----------

Name: GHW - generates 1 patron name based on the patron's ID number
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-03-20 17:44:30
Modified on: 2019-03-27 16:45:48
Date last run: 2021-08-17 10:53:44

----------

Public: 1
Expiry: 1

----------

<div id=reportinfo>
<p>Returns 1 patron name based based on the specified borrowernumber</p>
<ul><li>Shows a current patron name</li>
<li>based on the borrowernumber you enter</li>
<li>grouped and sorted by the borrower's name</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>The purpose of this report is to provide JSON output in order to put the patron's name on the "Hold filled" checkin message pop-up.</p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3186&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  Group_Concat(borrowers.surname, ", ", borrowers.firstname, " - ") AS BORROWER_NAME
FROM
  borrowers
WHERE
  borrowers.borrowernumber = <<borrowernumber>>



