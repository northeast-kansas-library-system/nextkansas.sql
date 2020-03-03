/*
R.003225

----------

Name: GHW - List / virtualshelf report 002 - Display all lists (public or private) owned by a patron
Created by: George H Williams

----------

Group: Lists Module
     -

Created on: 2019-07-17 09:09:24
Modified on: 2019-11-07 14:34:56
Date last run: 2019-11-07 15:11:04

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class='noprint'>
<p>Generates a report of all lists owned by the borrower you specify and allows you to run further reports on those lists</p>
<ul><li>Displays lists currently in the system - public or private</li>
<li>displays lists created by the borrower you specify</li>
<li>grouped by date created, list name, and list id number</li>
<li>sorted by list name</li>
<li>links to the Staff client and OPAC pages for the list; links to reports:
<ul>
<li>3228 (Display list titles with links to bibliographic records)</li>
<li>3227 (Display list titles with call numbers at a specific library)</li>
<li>3226 (Display author/title information for a list - for printing)</li>
<li>3279 (Export list to spreadsheet()</li>
</ul>
</li><br />
</ul>
<p><ins>Notes:</ins></p>
<p></p>
<p>This report is the master report for private lists.</p>
<p></p>
<p>Allows staff to run reports on private lists provided they have the patron's library card number.</p>
<p></p>
<p>Replaces the following reports:</p>
<ul>
<li>2810 - GHW - Public lists with items</li>
<li>3020 - GHW - List of lists</li>
</ul>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3225&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  IF(
    virtualshelves.category = 1,
    "Private list",
    Concat_Ws('<br />',
      Concat(
        '<a href=\"/cgi-bin/koha/virtualshelves/shelves.pl?op=view&shelfnumber=',
        virtualshelves.shelfnumber,
        ' \" target="_blank">Staff</a>'),
      Concat(
        '<a href=\"https://nextkansas.org/cgi-bin/koha/opac-shelves.pl?op=view&shelfnumber=',
        virtualshelves.shelfnumber,
        ' \" target="_blank">OPAC</a>')
    )
  ) AS LINK,
  Concat_Ws('<br />',
    Concat('List name: ', virtualshelves.shelfname),
    Concat('List ID#: ', virtualshelves.shelfnumber),
    Concat('Title count: ', Count(virtualshelfcontents.biblionumber))
  ) AS LIST_INFO,
  virtualshelves.created_on,
    Concat(
      '<a href=\"/cgi-bin/koha/reports/guided_reports.pl?phase=Run+this+report&reports=3228&sql_params=',
      virtualshelves.shelfnumber,
      '&param_name=Enter+list+number&limit=1000 \" target="_blank">Run report 3228<br />Display list titles with links to bibliographic records</a>'
    ) AS LINKS_TO_TITLES,
    Concat(
      '<a href=\"/cgi-bin/koha/reports/guided_reports.pl?phase=Run+this+report&reports=3227&sql_params=%25&sql_params=',
      virtualshelves.shelfnumber,
      '&param_name=Choose+your+branch%7CLBRANCH&param_name=Enter+a+list+ID+number&limit=1000 \" target="_blank">Run report 3227<br />Display list titles with call numbers at a specific library</a>'
    ) AS CALL_NUMBER_REPORT,
    Concat(
      '<a href=\"/cgi-bin/koha/reports/guided_reports.pl?phase=Run+this+report&reports=3226&sql_params=',
      virtualshelves.shelfnumber,
      '&param_name=Enter+list+ID+number&limit=1000 \" target="_blank">Run report 3226<br />Display author/title information for a list - for printing</a>'
    ) AS REPORT_TO_PRINT,
    Concat(
      '<a href=\"/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3279&sql_params=',
      virtualshelves.shelfnumber,
      '&sql_params=%25&param_name=Enter%20list%20number&param_name=Choose%20your%20library%7CLBRANCH \" target="_blank">Download report 3279<br />Export list to spreadsheet</a>'
    ) AS EXPORT_TO_SPREADSHEET
FROM
  virtualshelves
  JOIN virtualshelfcontents
    ON virtualshelfcontents.shelfnumber = virtualshelves.shelfnumber
  JOIN borrowers
    ON virtualshelves.owner = borrowers.borrowernumber
WHERE
  borrowers.cardnumber LIKE <<Enter patron barcode number>>
GROUP BY
  virtualshelves.created_on,
  virtualshelves.shelfname,
  virtualshelves.shelfnumber
ORDER BY
  virtualshelves.shelfname



