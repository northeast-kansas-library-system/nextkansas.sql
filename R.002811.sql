/*
R.002811

----------

Name: GHW - List of lists
Created by: George H Williams

----------

Group: Lists Module
     -

Created on: 2016-10-18 11:59:18
Modified on: 2019-07-17 16:35:06
Date last run: 2019-07-17 16:34:34

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Generates a list of public lists with a title that contains a specified phrase</p>
<ul><li>Shows a count of how many titles are on each list</li>
<li>shows all lists in NExpress</li>
<li>grouped and sorted by list name</li>
<li>contains links to the lists</li>
</ul><br />
<p>&nbsp;</p>
<p><span style="background-color: darkred; color: white">Scheduled for deletion on August 31, 2019</p>
<p><span style="background-color: black; color: white">Is being replaced by report 3224</p>
<p>&nbsp;</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2811&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  CONCAT( '<a href=\"/cgi-bin/koha/virtualshelves/shelves.pl?op=view&shelfnumber=', virtualshelves.shelfnumber,'\" target="_blank">Link to list</a>' ) AS LINK_TO_LIST,
  virtualshelves.shelfname,
  Count(virtualshelfcontents.biblionumber) AS Count_biblionumber
FROM
  virtualshelves LEFT JOIN
  virtualshelfcontents
    ON virtualshelfcontents.shelfnumber = virtualshelves.shelfnumber
WHERE
  virtualshelves.category = '2' AND
  virtualshelves.shelfname LIKE concat('%',<<Enter a list name search phrase>>, '%')
GROUP BY
  virtualshelves.shelfname
ORDER BY
  virtualshelves.shelfname



