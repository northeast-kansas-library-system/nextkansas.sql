/*
R.003786

----------

Name: GHW - Basic shelving locations list
Created by: George Williams

----------

Group: -
     -

Created on: 2023-11-20 18:03:06
Modified on: 2024-04-11 15:29:46
Date last run: 2024-04-11 15:29:52

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
  <p>Simple list of all current shelving locations</p>
  <ul>
    <li>Shows current locations</li>
    <li>system-wide</li>
    <li>grouped by code</li>
    <li>sorted by location</li>
    <li>links</li>
  </ul><br />
  <p><ins>Notes:</ins></p>
  <p></p>
  <p></p>
  <p class= "notetags" style="display: none;">#neststeps #locations</p>
  <!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes -->
</div>

----------
*/



SELECT
  authorised_values.lib AS SHELVING_LOCATION,
  authorised_values.authorised_value AS LOCATION_CODE
FROM
  authorised_values
WHERE
  authorised_values.category = 'LOC'
GROUP BY
  authorised_values.authorised_value
ORDER BY
  SHELVING_LOCATION

























