/*
R.003171

----------

Name: GHW - Closure report 1 - items checked out at a library with due dates during a specified date range
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-02-15 11:10:48
Modified on: 2020-03-04 13:51:17
Date last run: 2020-06-16 12:18:16

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Report to get items.itemnumber data for items due in the date range specified</p>
<ul><li>Shows itemnumbers for items due on the dates you specify</li>
<li>at the library you specify</li>
<li>grouped by branchcode and itemnumber</li>
<li>sorted by branchcode and date due</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Procedure for NEKLS staff when a library contacts us about an unplanned closure:<br /></p>
<ol>
  <li>Run this report for the library that's closing unexpectedly and select the date range that they will be closed</li><br />
  <li>Download the report as a CSV file</li><br />
  <li>Open a support request with ByWater Solutions and attach the csv file to the support request</li><br />
  <li>Ask ByWater to change the due dates on all of the itemnumbers included in the text file to the date the library will re-open (or a day or two after they reopen)</li><br />
  <li>Let the library know that you have asked ByWater to update the due dates on the items that are due during their closure</li><br />
  <li>Follow up with the library and with ByWater if there are any problems or issues</li><br />
</ol>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3171&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  issues.branchcode,
  issues.itemnumber,
  issues.date_due
FROM
  issues
WHERE
  issues.date_due BETWEEN <<Between the start of the day on date1|date>>  AND (<<the end of the day on date2|date>> + interval 1 day) AND
  issues.branchcode LIKE <<Select library|ZBRAN>>
GROUP BY
  issues.branchcode,
  issues.itemnumber
ORDER BY
  issues.branchcode,
  issues.date_due

























