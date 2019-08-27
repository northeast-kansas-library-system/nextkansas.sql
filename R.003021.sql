/*
R.003021

----------

Name: GHW - Print a list - variant
Created by: George H Williams

----------

Group: Lists Module
     -

Created on: 2017-12-20 20:10:54
Modified on: 2019-07-17 17:24:51
Date last run: 2019-07-17 17:24:18

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Creates a printable version of a list</p>
<ul><li>Shows titles currently in a list</li>
<li>based on the list number you specify</li>
<li>grouped by list ID and biblio number</li>
<li>sorted by author and title</li>
<li>links</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>List ID numbers can be found at the end of the the list's URL.</p>
<p>For example, the list titled "Summer" has a URL of:<br />https://staff.nextkansas.org/cgi-bin/koha/virtualshelves/shelves.pl?op=view&shelfnumber=3342<br />so the list ID number is 3342.</p>
<p>&nbsp;</p>
<p><span style="background-color: darkred; color: white">Scheduled for deletion on August 31, 2019</p>
<p><span style="background-color: black; color: white">Is being replaced by report 2336</p>
<p>&nbsp;</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3021&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  virtualshelves.shelfname AS LIST_NAME,
  Coalesce(
    Concat_WS(
      " ",
      "Title: ",
      Concat_Ws(
        "",
        biblio.title,
        "<br />",
        IF(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]') = "", "", Concat(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'), "<br />")),
        IF(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]') = "", "", Concat(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), "<br />")),
        IF(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]') = "", "", Concat(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'), "<br />")),
        IF(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]') = "", "", Concat(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), "<br />")),
        IF(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="c"]') = "", "", Concat(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="c"]'), "<br />"))
      ),
      IF(biblio.author IS NULL, "", Concat("Author: ", biblio.author))
    ),
    "Title deleted"
  ) AS TITLE_INFO
FROM virtualshelves
JOIN virtualshelfcontents ON virtualshelfcontents.shelfnumber = virtualshelves.shelfnumber
JOIN biblio ON virtualshelfcontents.biblionumber = biblio.biblionumber
LEFT JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
WHERE virtualshelves.shelfnumber = <<Enter list ID number>>
GROUP BY
  virtualshelves.shelfnumber,
  biblio.biblionumber
ORDER BY
  biblio.author,
  biblio.title DESC



