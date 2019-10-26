/*
R.003225

----------

Name: GHW - List report 002 - Show all lists (public or private) owned by a patron
Created by: George H Williams

----------

Group: Lists Module
     -

Created on: 2019-07-17 09:09:24
Modified on: 2019-07-23 17:36:19
Date last run: 2019-10-10 10:21:34

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Generates a report of all lists owned by the borrower you specify and allows you to run further reports on those lists</p>
<ul><li>Shows lists currently in the system - public or private</li>
<li>shows lists created by the borrower you specify</li>
<li>grouped by date created, list name, and list id number</li>
<li>sorted by list name</li>
<li>links to the Staff client and OPAC pages for the list; links to report 3228 (links to titles); links to report 3227 (call numbers at a branch); links to report 3226 (print title and author only)</li>
</ul><br />
<p><ins>Notes:</ins></p>
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
    Concat('<a href=\"/cgi-bin/koha/reports/guided_reports.pl?phase=Run+this+report&reports=3228&sql_params=', virtualshelves.shelfnumber, '&param_name=Enter+list+number&limit=1000 \" target="_blank">List with links to titles</a>') AS LINKS_TO_TITLES,
    Concat('<a href=\"/cgi-bin/koha/reports/guided_reports.pl?phase=Run+this+report&reports=3227&sql_params=%25&sql_params=', virtualshelves.shelfnumber, '&param_name=Choose+your+branch%7CLBRANCH&param_name=Enter+a+list+ID+number&limit=1000 \" target="_blank">List with call numbers</a>') AS CALL_NUMBER_REPORT,
  Concat('<a href=\"/cgi-bin/koha/reports/guided_reports.pl?phase=Run+this+report&reports=3226&sql_params=', virtualshelves.shelfnumber, '&param_name=Enter+list+ID+number&limit=1000 \" target="_blank">Basic list to print</a>') AS REPORT_TO_PRINT
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



