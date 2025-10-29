/*
R.003498

----------

Name: GHW - Bookshelves template report
Created by: George Williams

----------

Group: -
     -

Created on: 2021-04-29 11:50:12
Modified on: 2024-01-17 11:32:57
Date last run: 2025-03-04 10:32:19

----------

Public: 1
Expiry: 300

----------

<div class="reportinfo noprint"> 
  <p>Report template to create a list of new book ISBNs for the Wordpress bookshelves plugin for any library we choose</p>
  <ul>
    <li>Shows the 25 most recently added 10 digit ISBNs for items owned by libraries in Next</li>
    <li>only titles owned by the library defined in the code</li>
    <li>grouped and sorted by biblionumber (descending sort)</li>
  </ul><br />
<p></p>
<p>
  <ul>
    <li>For use with the Bookshelves wordpress plugin</li>
    <li>Variables in this template include
      <ul>
          <li>home library</li>
          <li>permanent shelving location</li>
          <li>item type</li>
          <li>collection code</li>
      </ul>
    </li>
    <li>The bookshelves plulgin requires a 10 digit ISBN</li>
    <li>Because non-book items do not have an ISBN, this plugin will only work with books</li>
    <li>The final report needs to be set as a "Public" report in order for the plugin to work</li>
    <li>Publication year parameters can be added - see TONGANOXIE report for a working example</li>
  </ul>
</p>
<p></p>
  <p class= "notetags" style="display: none;">#wordpress #bookshelves #template</p>
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
  biblioitems.publicationyear &gt;= Year(Now() - INTERVAL 6 MONTH) AND 
  biblioitems.isbn IS NOT NULL AND
  items.homebranch LIKE '%' AND
  items.permanent_location LIKE "%" AND
  items.itype LIKE "%" AND
  items.ccode LIKE "%" AND
  items.notforloan = 0 AND
  items.damaged = 0 AND
  items.itemlost = '' AND
  items.withdrawn = 0 
GROUP BY
  biblio.biblionumber
HAVING
  isbns &lt;&gt; 'X'
ORDER BY
  items.itemnumber DESC
LIMIT 25

























