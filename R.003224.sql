/*
R.003224

----------

Name: GHW - List / virtualshelf report 001 - Display public lists by title
Created by: George Williams

----------

Group: Lists Module
     -

Created on: 2019-07-17 09:09:08
Modified on: 2024-01-17 12:07:50
Date last run: 2022-11-17 11:28:27

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Generates a list of public lists then allows you to run further reports on the results&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Displays current public lists.&lt;/li&gt;
&lt;li&gt;displays all public lists with search terms you specify (enter a % to display all lists)&lt;/li&gt;
&lt;li&gt;grouped by date created, list name, list number&lt;/li&gt;
&lt;li&gt;sorted by list name&lt;/li&gt;
&lt;li&gt;links to the Staff client and OPAC pages for the list; links to reports:
&lt;ul&gt;
&lt;li&gt;3228 (Display list titles with links to bibliographic records)&lt;/li&gt;
&lt;li&gt;3227 (Display list titles with call numbers at a specific library)&lt;/li&gt;
&lt;li&gt;3226 (Display author/title information for a list - for printing)&lt;/li&gt;
&lt;li&gt;3279 (Export list to spreadsheet()&lt;/li&gt;
&lt;/ul&gt;
&lt;/li&gt;&lt;br /&gt;
&lt;/ul&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;This report is the master report for public lists.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Replaces the following reports:&lt;/p&gt;
&lt;ul&gt;
&lt;li&gt;2810 - GHW - Public lists with items&lt;/li&gt;
&lt;li&gt;2811 - GHW - List of lists&lt;/li&gt;
&lt;li&gt;3020 - GHW - List of lists&lt;/li&gt;
&lt;/ul&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3224&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  Concat_Ws('',
    Concat(
      'Staff'),
    Concat(
      'OPAC')
  ) AS LINKS,
  Concat_Ws('',
    Concat('List name: ', virtualshelves.shelfname),
    Concat('List ID#: ', virtualshelves.shelfnumber),
    Concat('Title count: ', Count(virtualshelfcontents.biblionumber))
  ) AS LIST_INFO,
  virtualshelves.created_on,
    Concat(
      'Run report 3228Display list titles with links to bibliographic records'
    ) AS LINKS_TO_TITLES,
    Concat(
      'Run report 3227Display list titles with call numbers at a specific library'
    ) AS CALL_NUMBER_REPORT,
    Concat(
      'Run report 3226Display author/title information for a list - for printing'
    ) AS REPORT_TO_PRINT,
    Concat(
      'Download report 3279Export list to spreadsheet'
    ) AS EXPORT_TO_SPREADSHEET
FROM
  virtualshelves
  JOIN virtualshelfcontents
    ON virtualshelfcontents.shelfnumber = virtualshelves.shelfnumber
WHERE
  virtualshelves.category = '2'AND
  virtualshelves.shelfname LIKE Concat("%", &lt;&gt;, "%")
GROUP BY
  virtualshelves.created_on,
  virtualshelves.shelfname,
  virtualshelves.shelfnumber
ORDER BY
  virtualshelves.shelfname

























