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

&lt;div class="reportinfo noprint"&gt; 
  &lt;p&gt;Simple list of all current shelving locations&lt;/p&gt;
  &lt;ul&gt;
    &lt;li&gt;Shows current locations&lt;/li&gt;
    &lt;li&gt;system-wide&lt;/li&gt;
    &lt;li&gt;grouped by code&lt;/li&gt;
    &lt;li&gt;sorted by location&lt;/li&gt;
    &lt;li&gt;links&lt;/li&gt;
  &lt;/ul&gt;&lt;br /&gt;
  &lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
  &lt;p&gt;&lt;/p&gt;
  &lt;p&gt;&lt;/p&gt;
  &lt;p class= "notetags" style="display: none;"&gt;#neststeps #locations&lt;/p&gt;
  &lt;!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt;
&lt;/div&gt;

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

























