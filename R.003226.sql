/*
R.003226

----------

Name: GHW - List / virtualshelf report 003 - Display author/title information for a list - for printing
Created by: George H Williams

----------

Group: Lists Module
     -

Created on: 2019-07-17 09:09:51
Modified on: 2019-11-05 10:52:52
Date last run: 2021-04-06 22:03:54

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class='noprint'>
<p>Creates a simple printable list of titles and authors from a list</p>
<ul><li>Displays titles and authors currently on a list</li>
<li>you need to specify the list number (see below for more informaiton)</li>
<li>grouped by biblio number</li>
<li>sorted by author and title</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>To determine the list id number, look at the URL for the list and take the number off of the end of the URL.  For example, the list at<br />
https://staff.nextkansas.org/cgi-bin/koha/virtualshelves/shelves.pl?op=view&shelfnumber=6003<br />
would be list number 6003.</p>
<p></p>
<p>Can be accessed by running reports 3224 or 3225 and clicking on the link in the "LINKS_TO_TITLES" column</p>
<p></p>
<p>Replaces report:</p>
<ul>
<li>1746 - Shelf List from a Private List</li>
<li>3021 - GHW - Print a list - variant</li>
<li>3063 - GHW - Print list by ID number</li>
</ul>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3226&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  Concat("<span style='font-size: 125%;'><span style='float: left'><ins>Title:</ins> ", Coalesce(biblio.title, '--'), "</span><span style='float: right'><ins>Author:</ins> ", Coalesce(biblio.author, '--'), "</span></span>") AS TITLE_AUTHOR
FROM
  virtualshelfcontents
  LEFT JOIN biblio ON virtualshelfcontents.biblionumber = biblio.biblionumber
WHERE
  virtualshelfcontents.shelfnumber = <<Enter list ID number>>
GROUP BY
  biblio.biblionumber
ORDER BY
  biblio.author,
  biblio.title

























