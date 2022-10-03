/*
R.003228

----------

Name: GHW - List / virtualshelf report 005 - Display list titles with links to bibliographic records
Created by: George H Williams

----------

Group: Lists Module
     -

Created on: 2019-07-17 16:43:43
Modified on: 2020-11-10 16:56:06
Date last run: 2022-03-29 14:07:32

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class='noprint'>
<p>Shows the titles on a list with just the author and title and links to the title's bibliographic record</p>
<ul><li>Displays titles currently on a list</li>
<li>only displays the list you specify</li>
<li>grouped by biblionumber</li>
<li>sorted by author and title</li>
<li>links to the title</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>To determine the list id number, look at the URL for the list and take the number off of the end of the URL. For example, the list at
https://staff.nextkansas.org/cgi-bin/koha/virtualshelves/shelves.pl?op=view&shelfnumber=6003
would be list number 6003.</p>
<p></p>
<p>Can be accessed by running reports 3224 or 3225 and clicking on the link in the "REPORT_TO_PRINT" column</p>
<p></p>
<p>Replaces the following reports:</p>
<ul>
<li>3003 - List information</li>
</ul>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3228&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  biblio.author,
  biblio.title,
  Concat('<a class="btn btn-default" href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">Go to title</a>') AS BUTTON
FROM
  biblio
  JOIN virtualshelfcontents
    ON biblio.biblionumber = virtualshelfcontents.biblionumber
WHERE
  virtualshelfcontents.shelfnumber LIKE <<Enter list number>>
GROUP BY
  biblio.biblionumber
ORDER BY
  biblio.author,
  biblio.title

























