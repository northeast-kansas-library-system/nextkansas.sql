/*
R.003065

----------

Name: GHW - Request cancelled note
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-04-02 15:12:43
Modified on: 2018-04-02 15:15:41
Date last run: 2018-04-02 15:15:52

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  CONCAT("&lt;br /&gt;REQUEST CANCELLED&lt;br /&gt;The request on the following item was cancelled because there are no longer any copies available on the specified bibliographic record:&lt;br /&gt;", 
    Concat_WS(" ",
      "Title: &lt;span style='color: #000000;'&gt;",
      biblio.title,
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'),
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
      "&lt;/span&gt;"),
    Concat("&lt;br /&gt;Link to bibliographic record in staff client: ",
      Concat("&lt;a href='/cgi-bin/koha/catalogue/detail.pl?biblionumber=",
        biblio.biblionumber,
        "' target='_blank'&gt;",
        biblio.title,
        "&lt;/a&gt;")),
      "&lt;br /&gt;Search for other copies of this title: ",
      Concat("&lt;a href='/cgi-bin/koha/catalogue/search.pl?idx=ti%2Cphr&q=",
        REPLACE(biblio.title,
        ' ',
        '+'),
      "' target='_blank'&gt;SEARCH&lt;/a&gt;")) AS TITLE
FROM
  items
  JOIN biblio ON items.biblionumber = biblio.biblionumber
  JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
WHERE
  items.barcode Like Concat("%", <<Enter barcode number>>, "%")

























