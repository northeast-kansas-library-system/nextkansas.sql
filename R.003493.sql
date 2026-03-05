/*
R.003493

----------

Name: GHW - Export authorised_values table
Created by: George Williams

----------

Group: -
     -

Created on: 2021-04-13 15:14:34
Modified on: 2025-08-15 14:03:06
Date last run: 2025-11-07 12:18:10

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Outputs a backup of the authorised_values table to store on Github&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows the authorised_values at the time the report is run&lt;/li&gt;
&lt;li&gt;Shows all authorised values system wide&lt;/li&gt;
&lt;li&gt;sorted by category and value&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Run monthly and output data to Next SQL wiki&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p id="rquickdown"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=3493"&gt;Click here to download as a csv file&lt;/a&gt;&lt;/p&gt;
&lt;p class= "notetags" style="display: none;"&gt;authorised_values backup github&lt;/p&gt;
&lt;/div&gt;

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

























