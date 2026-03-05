/*
R.003065

----------

Name: GHW - Request cancelled note
Created by: George Williams

----------

Group: -
     -

Created on: 2018-04-02 15:12:43
Modified on: 2025-12-31 08:32:04
Date last run: 2025-12-31 08:42:05

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  CONCAT(
    "<br />REQUEST CANCELLED<br />",
    "The request on the following title was cancelled because there are no longer any copies available on the specified bibliographic record:<br />", 
    Concat_WS(" ",
      "Title: <span style='color: #000000;'>",
      biblio.title,
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'),
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
      "</span>"),
    Concat("<br />Link to bibliographic record in staff client: ",
      Concat("<a href='/cgi-bin/koha/catalogue/detail.pl?biblionumber=",
        biblio.biblionumber,
        "' target='_blank'>",
        biblio.title,
        "</a>")),
      "<br />Search for other copies of this title: ",
      Concat("<a href='/cgi-bin/koha/catalogue/search.pl?idx=ti%2Cphr&q=",
        REPLACE(biblio.title,
        ' ',
        '+'),
      "' target='_blank'>SEARCH</a>")) AS TITLE
FROM
  items
  JOIN biblio ON items.biblionumber = biblio.biblionumber
  JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
WHERE
  items.barcode Like Concat("%", <<Enter barcode number>>, "%")

























