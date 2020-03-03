/*
R.003227

----------

Name: GHW - List / virtualshelf report 004 - Display list titles with call numbers at a specific library
Created by: George H Williams

----------

Group: Lists Module
     -

Created on: 2019-07-17 09:10:07
Modified on: 2019-11-05 10:52:50
Date last run: 2019-12-02 17:05:00

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class='noprint'>
<p>Generates a printable shelf list with call numbers at a specific branch based on a list</p>
<ul><li>Displays titles currently on the list you specify</li>
<li>at the library you specify</li>
<li>grouped by title and list id number</li>
<li>sorted by standard Next Search Catalog classification, author, and title</li>
<li>links to the actual list</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>To determine the list id number, look at the URL for the list and take the number off of the end of the URL. For example, the list at<br />
https://staff.nextkansas.org/cgi-bin/koha/virtualshelves/shelves.pl?op=view&shelfnumber=6003<br />
would be list number 6003.</p>
<p></p>
<p>Can be accessed by running reports 3224 or 3225 and clicking on the link in the "CALL_NUMBER_REPORT" column</p>
<p></p>
<p>Replaces the following reports:</p>
<ul>
<li>1746 - Shelf List from a Private List</li>
<li>2049 - Printed list of books from a list</li>
</ul>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3227&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>



----------
*/

SELECT
  IF(
    virtualshelves.category = 1,
    "Private list",
    Concat(
      '<a href=\"/cgi-bin/koha/virtualshelves/shelves.pl?op=view&shelfnumber=',
      virtualshelves.shelfnumber,
      ' \" target="_blank">Link</a>'
    )
  ) AS LINK,
  Concat(
    "Name: ",
    virtualshelves.shelfname,
    "<br /><br />Number: ",
    virtualshelves.shelfnumber
  ) AS LIST_NAME_NUMBER,
  Coalesce(
    Concat_Ws(" ",
      Concat_Ws(
        "",
        IF(
          Length(biblio.title) > 40,
          Concat(Left(biblio.title, 40), ". . . "),
          biblio.title
        ),
        "<br />",
        If(
          ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]') = "",
          "",
          Concat(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'), "<br />")
        ),
        If(
          ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]') = "",
          "",
          Concat(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), "<br />")
        ),
        If(
          ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]') = "",
          "",
          Concat(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'), "<br />")
        ),
        If(
          ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]') = "",
          "",
          If(
            LENGTH(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]')) > 40,
            Concat(LEFT(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), 40), " . . .<br />"),
            Concat(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), "<br />")
          )
        ),
        biblio.author
      )
    ),
    "Title deleted"
  ) AS TITLE_INFO,
  GROUP_CONCAT(
    Concat_Ws("",
      itemss.homebranch,
      " / ",
      If(itemss.location IS NULL, "", Concat(itemss.location, " / ")),
      itemss.itype,
      " / ",
      If(itemss.ccode IS NULL, "", Concat(itemss.ccode, " / ")), itemss.itemcallnumber)
      ORDER BY
        itemss.homebranch,
        itemss.location,
        itemss.itype,
        itemss.ccode,
        itemss.itemcallnumber
      SEPARATOR "<br />"
    ) AS CLASSIFICATION
FROM
  virtualshelves
  JOIN virtualshelfcontents
    ON virtualshelfcontents.shelfnumber = virtualshelves.shelfnumber
  JOIN biblio
    ON virtualshelfcontents.biblionumber = biblio.biblionumber
  LEFT JOIN biblio_metadata
    ON biblio_metadata.biblionumber = biblio.biblionumber
  JOIN (
    SELECT
      items.biblionumber,
      items.homebranch,
      locs.lib AS location,
      items.itype,
      ccodes.lib AS ccode,
      items.itemcallnumber
    FROM
      items
      LEFT JOIN (
        SELECT
          authorised_values.category,
          authorised_values.authorised_value,
          authorised_values.lib
        FROM
          authorised_values
        WHERE
          authorised_values.category = 'ccode'
      ) ccodes
        ON ccodes.authorised_value = items.ccode
      LEFT JOIN (
        SELECT
          authorised_values.category,
          authorised_values.authorised_value,
          authorised_values.lib
        FROM
          authorised_values
        WHERE
          authorised_values.category = 'loc'
      ) locs
        ON locs.authorised_value = items.location
    WHERE
      items.homebranch LIKE <<Choose your branch|LBRANCH>>
  ) itemss
    ON itemss.biblionumber = biblio.biblionumber
WHERE
  virtualshelves.shelfnumber = <<Enter a list ID number>>
GROUP BY
  TITLE_INFO,
  virtualshelves.shelfnumber
ORDER BY
  CLASSIFICATION,
  biblio.author,
  biblio.title



