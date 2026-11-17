/*
R.003186

----------

Name: GHW - generates 1 patron name based on the patron's ID number
Created by: George Williams

----------

Group: -
     -

Created on: 2019-03-20 17:44:30
Modified on: 2026-11-03 12:21:37
Date last run: 2026-11-16 19:52:23

----------

Public: 0
Expiry: 1

----------

<div> 
<p>Returns 1 patron name based based on the specified borrowernumber</p>
<ul><li>Shows a current patron name</li>
<li>based on the borrowernumber you enter</li>
<li>grouped and sorted by the borrower's name</li>
</ul><br />
<p>Notes:</p>
<p></p>
<p>The purpose of this report is to provide JSON output in order to put the patron's name on the "Hold filled" checkin message pop-up.</p>
<p></p>
</div>

----------
*/



SELECT
  Group_Concat('<li class="nsc_borrower_name">', borrowers.surname, ', ', borrowers.firstname, '</li>') AS BORROWER_NAME
FROM
  borrowers
WHERE
  borrowers.borrowernumber = <<borrowernumber>>

























