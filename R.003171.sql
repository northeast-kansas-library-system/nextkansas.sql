/*
R.003171

----------

Name: GHW - Report for library closures
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-02-15 11:10:48
Modified on: 2019-06-21 11:41:45
Date last run: 2019-06-21 11:41:58

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
  <li>Copy the numbers from the itemnumber column into a text file - only copy the item numbers into the text file</li><br />
  <li>Open a support request with ByWater Solutions and attach the text file to the support request</li><br />
  <li>Ask ByWater to change the due dates on all of the itemnumbers included in the text file to the date that the library will re-open (this usually takes ByWater an hour or two)</li><br />
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
  issues.itemnumber AS ITEM_NUMBER,
  issues.date_due
FROM
  issues
WHERE
  issues.branchcode LIKE <<Select library|ZBRAN>> AND
  issues.date_due BETWEEN <<Between the start of the day on date1|date>>  AND (<<the end of the day on date2|date>> + interval 1 day)
GROUP BY
  issues.branchcode,
  issues.itemnumber
ORDER BY
  issues.branchcode,
  issues.date_due



