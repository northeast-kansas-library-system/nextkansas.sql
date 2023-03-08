/*
R.003696

----------

Name: GHW - Bookshelves report for TONGANOXIE - ADULT 
Created by: George H Williams

----------

Group:  TONGANOXIE
     -

Created on: 2023-01-19 16:31:58
Modified on: 2023-02-17 09:01:07
Date last run: 2023-03-08 13:55:35

----------

Public: 1
Expiry: 3600

----------

<div id=reportinfo class=noprint>
  <p>Creates a list of new adult book ISBNs for the Wordpress bookshelves plugin for TONGANOXIE</p>
  <ul>
    <li>Shows the 25 most recently added 10 digit ISBNs for items owned by TONGANOXIE</li>
    <li>only titles owned by TONGANOXIE</li>
    <li>grouped and sorted by biblionumber (descending sort)</li>
  </ul><br />
  <p class= "notetags" style="display: none;">#wordpress #bookshelves</p>
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
  items.homebranch LIKE 'TONGANOXIE' AND
  biblioitems.isbn IS NOT NULL AND
  items.itype LIKE "BOOK" AND
  items.permanent_location LIKE "L_AD" AND
  items.ccode NOT LIKE "%LARGE%" AND
  items.ccode NOT LIKE "%WESTERN%" AND
  items.notforloan = 0 AND
  items.damaged = 0 AND
  items.itemlost = '' AND
  items.withdrawn = 0 AND 
  biblioitems.publicationyear >= Year(Now() - INTERVAL 3 MONTH)
GROUP BY
  biblio.biblionumber
HAVING
  isbns <> 'X'
ORDER BY
  items.itemnumber DESC
LIMIT 25

























