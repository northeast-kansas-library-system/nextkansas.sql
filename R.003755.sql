/*
R.003755

----------

Name: GHW - Bookshelves report for LEAVENWRTH - new adult titles
Created by: George Williams

----------

Group:  LEAVENWRTH
     -

Created on: 2023-08-23 11:11:41
Modified on: 2024-01-17 11:18:18
Date last run: 2024-10-22 10:39:09

----------

Public: 1
Expiry: 3600

----------

<div class="reportinfo noprint"> 
  <p>Report to create a list of ISBNs for the Wordpress bookshelves plugin for Leavenworth Public Library</p>
  <ul>
    <li>Shows the 25 most recently added 10 digit ISBNs for items owned by LEAVENWRTH</li>
    <li>only titles owned by LEAVENWRTH with a permanent shelving location of "Adult"</li>
    <li>grouped and sorted by biblionumber (descending sort)</li>
  </ul><br />
<p></p>
<p>
  <ul>
    <li>For use with the Bookshelves wordpress plugin</li>
    <li>Variables in this template include
      <ul>
          <li>home library = LEAVENWRTH</li>
          <li>permanent shelving location = L_AD</li>
          <li>item type = Any</li>
          <li>collection code = Any</li>
          <li>NOT_LOAN status = Any</li>
      </ul>
    </li>
    <li>The bookshelves plulgin requires a 10 digit ISBN</li>
    <li>Because non-book items do not have an ISBN, this plugin will only work with books</li>
    <li>The final report needs to be set as a "Public" report in order for the plugin to work</li>
  </ul>
</p>
<p></p>
  <p class= "notetags" style="display: none;">#wordpress #bookshelves #leavenwrth</p>
  <!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes -->
</div>

----------
*/



SELECT
IF(
    Length(Trim(SubString_Index(biblioitems.isbn, '|', 1))) = 10, 
    Trim(SubString_Index(biblioitems.isbn, '|', 1)), 
    IF(
      Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 2), '|', -1))) = 10, 
      Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 2), '|', -1)), 
      IF(
        Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 3), '|', -1))) = 10, 
        Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 3), '|', -1)), 
        IF(
          Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 4), '|', -1))) = 10, 
          Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 4), '|', -1)), 
          IF(
            Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 5), '|', -1))) = 10, 
            Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 5), '|', -1)), 
            IF(
              Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 6), '|', -1))) = 10, 
              Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 6), '|', -1)), 
              IF(
                Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 7), '|', -1))) = 10, 
                Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 7), '|', -1)), 
                IF(
                  Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 8), '|', -1))) = 10, 
                  Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 8), '|', -1)), 
                  IF(
                    Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 9), '|', -1))) = 10, 
                    Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 9), '|', -1)), 
                    IF(
                      Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 10), '|', -1))) = 10, 
                      Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 10), '|', -1)), 
                      'X'
                    )
                  )
                )
              )
            )
          )
        )
      )
    )
  ) AS isbns,
  biblio.title,
  biblio.author
FROM
  biblioitems JOIN
  biblio ON biblioitems.biblionumber = biblio.biblionumber JOIN
  items ON items.biblioitemnumber = biblioitems.biblioitemnumber
WHERE
  biblioitems.publicationyear >= Year(Now() - INTERVAL 3 MONTH) AND 
  biblioitems.isbn IS NOT NULL AND
  items.homebranch LIKE 'LEAVENWRTH' AND
  items.permanent_location LIKE 'L_AD' AND
  items.itype LIKE '%' AND
  items.ccode LIKE '%' AND
  items.notforloan = '%' AND
  items.damaged = 0 AND
  items.itemlost = '' AND
  items.withdrawn = 0 
GROUP BY
  biblio.biblionumber
HAVING
  isbns <> 'X'
ORDER BY
  items.itemnumber DESC
LIMIT 25

























