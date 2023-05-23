/*
R.003493

----------

Name: GHW - Export authorised_values table
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-04-13 15:14:34
Modified on: 2021-04-13 15:41:33
Date last run: 2023-03-08 14:57:34

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Outputs a backup of the authorised_values table to store on Github</p>
<ul><li>Shows the authorised_values at the time the report is run</li>
<li>Shows all authorised values system wide</li>
<li>sorted by category and value</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Run monthly and output data to Next SQL wiki</p>
<p></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3493">Click here to download as a csv file</a></p>
<p class= "notetags" style="display: none;">authorised_values backup github</p>
</div>

----------
*/



SELECT
  authorised_values.id,
  authorised_values.category,
  authorised_values.authorised_value,
  authorised_values.lib,
  authorised_values.imageurl,
  authorised_values.lib_opac
FROM
  authorised_values
ORDER BY
  authorised_values.category,
  authorised_values.authorised_value

























