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

&lt;div class="reportinfo noprint"&gt; 
  &lt;p&gt;Report to create a list of ISBNs for the Wordpress bookshelves plugin for Leavenworth Public Library&lt;/p&gt;
  &lt;ul&gt;
    &lt;li&gt;Shows the 25 most recently added 10 digit ISBNs for items owned by LEAVENWRTH&lt;/li&gt;
    &lt;li&gt;only titles owned by LEAVENWRTH with a permanent shelving location of "Adult"&lt;/li&gt;
    &lt;li&gt;grouped and sorted by biblionumber (descending sort)&lt;/li&gt;
  &lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;
  &lt;ul&gt;
    &lt;li&gt;For use with the Bookshelves wordpress plugin&lt;/li&gt;
    &lt;li&gt;Variables in this template include
      &lt;ul&gt;
          &lt;li&gt;home library = LEAVENWRTH&lt;/li&gt;
          &lt;li&gt;permanent shelving location = L_AD&lt;/li&gt;
          &lt;li&gt;item type = Any&lt;/li&gt;
          &lt;li&gt;collection code = Any&lt;/li&gt;
          &lt;li&gt;NOT_LOAN status = Any&lt;/li&gt;
      &lt;/ul&gt;
    &lt;/li&gt;
    &lt;li&gt;The bookshelves plulgin requires a 10 digit ISBN&lt;/li&gt;
    &lt;li&gt;Because non-book items do not have an ISBN, this plugin will only work with books&lt;/li&gt;
    &lt;li&gt;The final report needs to be set as a "Public" report in order for the plugin to work&lt;/li&gt;
  &lt;/ul&gt;
&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
  &lt;p class= "notetags" style="display: none;"&gt;#wordpress #bookshelves #leavenwrth&lt;/p&gt;
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
  biblioitems.publicationyear &gt;= Year(Now() - INTERVAL 3 MONTH) AND 
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
  isbns &lt;&gt; 'X'
ORDER BY
  items.itemnumber DESC
LIMIT 25

























