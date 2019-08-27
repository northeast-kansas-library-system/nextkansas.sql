/*
R.003224

----------

Name: GHW - List report 001 - List public lists by title
Created by: George H Williams

----------

Group: Lists Module
     -

Created on: 2019-07-17 09:09:08
Modified on: 2019-07-23 17:34:56
Date last run: 2019-07-23 17:32:53

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Generates a list of public lists then allows you to run further reports on the results</p>
<ul><li>Shows current public lists.</li>
<li>shows all public lists with search terms you specify (enter a % to display all lists)</li>
<li>grouped by date created, list name, list number</li>
<li>sorted by list name</li>
<li>links to the Staff client and OPAC pages for the list; links to report 3228 (links to titles); links to report 3227 (call numbers at a branch); links to report 3226 (print title and author only)</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>This report is the master report for public lists.</p>
<p></p>
<p>Replaces the following reports:</p>
<ul>
<li>2810 - GHW - Public lists with items</li>
<li>2811 - GHW - List of lists</li>
<li>3020 - GHW - List of lists</li>
</ul>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3224&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  Concat_Ws('<br />',
    Concat(
      '<a href=\"/cgi-bin/koha/virtualshelves/shelves.pl?op=view&shelfnumber=',
      virtualshelves.shelfnumber,
      ' \" target="_blank">Staff</a><br />'),
    Concat(
      '<a href=\"https://nextkansas.org/cgi-bin/koha/opac-shelves.pl?op=view&shelfnumber=',
      virtualshelves.shelfnumber,
      ' \" target="_blank">OPAC</a>')
  ) AS LINKS,
  Concat_Ws('<br />',
    Concat('List name: ', virtualshelves.shelfname),
    Concat('List ID#: ', virtualshelves.shelfnumber),
    Concat('Title count: ', Count(virtualshelfcontents.biblionumber))
  ) AS LIST_INFO,
  virtualshelves.created_on,
    Concat('<a href=\"/cgi-bin/koha/reports/guided_reports.pl?phase=Run+this+report&reports=3228&sql_params=', virtualshelves.shelfnumber, '&param_name=Enter+list+number&limit=1000 \" target="_blank">List with links to titles</a>') AS LINKS_TO_TITLES,
    Concat('<a href=\"/cgi-bin/koha/reports/guided_reports.pl?phase=Run+this+report&reports=3227&sql_params=%25&sql_params=', virtualshelves.shelfnumber, '&param_name=Choose+your+branch%7CLBRANCH&param_name=Enter+a+list+ID+number&limit=1000 \" target="_blank">List with call numbers</a>') AS CALL_NUMBER_REPORT,
  Concat('<a href=\"/cgi-bin/koha/reports/guided_reports.pl?phase=Run+this+report&reports=3226&sql_params=', virtualshelves.shelfnumber, '&param_name=Enter+list+ID+number&limit=1000 \" target="_blank">Basic list to print</a>') AS REPORT_TO_PRINT
FROM
  virtualshelves
  JOIN virtualshelfcontents
    ON virtualshelfcontents.shelfnumber = virtualshelves.shelfnumber
WHERE
  virtualshelves.category = '2'AND
  virtualshelves.shelfname LIKE Concat("%", <<Enter part of a list name or a % symbol>>, "%")
GROUP BY
  virtualshelves.created_on,
  virtualshelves.shelfname,
  virtualshelves.shelfnumber
ORDER BY
  virtualshelves.shelfname



