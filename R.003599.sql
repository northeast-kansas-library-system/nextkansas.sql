/*
R.003599

----------

Name: GHW - Bookshelves report for LINWOOD - CHILDRENS
Created by: George Williams

----------

Group:  LINWOOD
     -

Created on: 2021-10-20 15:32:03
Modified on: 2024-01-17 11:28:59
Date last run: 2024-10-22 12:09:12

----------

Public: 1
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
  &lt;p&gt;Creates a list of new childrens book ISBNs for the Wordpress bookshelves plugin for LINWOOD&lt;/p&gt;
  &lt;ul&gt;
    &lt;li&gt;Shows the 25 most recently added 10 digit ISBNs for items owned by LINWOOD&lt;/li&gt;
    &lt;li&gt;only titles owned by LINWOOD&lt;/li&gt;
    &lt;li&gt;grouped and sorted by biblionumber (descending sort)&lt;/li&gt;
  &lt;/ul&gt;&lt;br /&gt;
  &lt;p class= "notetags" style="display: none;"&gt;#wordpress #bookshelves&lt;/p&gt;
  &lt;!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt;
&lt;/div&gt;

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
  items.homebranch LIKE 'LINWOOD' AND
  biblioitems.isbn IS NOT NULL AND
  items.itype LIKE 'BOOK' AND
  items.permanent_location LIKE 'L_JU' AND
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
  biblio.biblionumber DESC
LIMIT 25

























