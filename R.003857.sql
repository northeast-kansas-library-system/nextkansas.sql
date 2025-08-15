/*
R.003857

----------

Name: link retrieval
Created by: George Williams

----------

Group: -
     -

Created on: 2024-09-03 16:34:42
Modified on: 2024-09-05 13:39:36
Date last run: 2024-09-09 13:42:03

----------

Public: 0
Expiry: 300

----------

692

759

----------
*/



SELECT
  *
FROM
  ((SELECT
      Concat(
        'https://nekls.aspendiscovery.org/Record/', 
        biblio.biblionumber
      ) AS URL
    FROM
      biblio
    WHERE
      biblio.biblionumber &gt; &lt;&gt;
    LIMIT 25)
    UNION
    SELECT
      '-----' AS URL
    UNION
    (SELECT
      Concat(
        'https://www.google.com/search?q=', 
         REPLACE(
           REPLACE(
            REGEXP_REPLACE(
              TRIM(
                Concat_Ws(
                  ' ', 
                  TRIM(biblio.title), 
                  TRIM(biblio.author))
                ), 
                '[^a-zA-Z]', 
                '+'
              ), 
            '++', 
            '+'
          ), 
          '&udm=2'
          '++',
          '+'
        )
      ) AS URL
    FROM
      biblio
    WHERE
      biblio.biblionumber &gt; &lt;&gt;
    LIMIT 25)) Query1
LIMIT 1000

























