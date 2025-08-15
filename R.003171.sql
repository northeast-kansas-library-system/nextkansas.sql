/*
R.003171

----------

Name: GHW - Closure report 1 - items checked out at a library with due dates during a specified date range
Created by: George Williams

----------

Group: -
     -

Created on: 2019-02-15 11:10:48
Modified on: 2024-01-17 11:55:09
Date last run: 2023-02-04 11:32:29

----------

Public: 0
Expiry: 300

----------

 
Report to get items.itemnumber data for items due in the date range specified
Shows itemnumbers for items due on the dates you specify
at the library you specify
grouped by branchcode and itemnumber
sorted by branchcode and date due

Notes:

Procedure for NEKLS staff when a library contacts us about an unplanned closure:

  Run this report for the library that's closing unexpectedly and select the date range that they will be closed
  Download the report as a CSV file
  Open a support request with ByWater Solutions and attach the csv file to the support request
  Ask ByWater to change the due dates on all of the itemnumbers included in the text file to the date the library will re-open (or a day or two after they reopen)
  Let the library know that you have asked ByWater to update the due dates on the items that are due during their closure
  Follow up with the library and with ByWater if there are any problems or issues


Click here to run in a new window


----------
*/



SELECT
  issues.branchcode,
  issues.itemnumber,
  issues.date_due
FROM
  issues
WHERE
  issues.date_due BETWEEN &lt;&gt;  AND (&lt;&gt; + interval 1 day) AND
  issues.branchcode LIKE &lt;&gt;
GROUP BY
  issues.branchcode,
  issues.itemnumber
ORDER BY
  issues.branchcode,
  issues.date_due

























