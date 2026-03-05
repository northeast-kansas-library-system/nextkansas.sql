/*
R.003805

----------

Name: Sandbox ADMINREPORT
Created by: George Williams

----------

Group: -
     -

Created on: 2024-03-07 10:27:07
Modified on: 2024-03-07 10:27:07
Date last run: 2024-03-07 11:35:35

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  concat(
    '<a href="/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
    biblio_metadata.biblionumber, 
    '" target="blank">LINK</a>'
  ) AS LINK,
  Trim(
    Replace(
      Replace(
        Replace(
          ExtractValue(
            biblio_metadata.metadata, 
            '//datafield[@tag="245"]/subfield[@code="h"]'
          ), 
          "/", 
          ""
        ), 
        ":", 
        ""
      ), 
      ".", 
      ""
    )
  ) AS GMD
FROM
  biblio_metadata
WHERE
  Trim(
    Replace(
      Replace(
        Replace(
          ExtractValue(
            biblio_metadata.metadata, 
            '//datafield[@tag="245"]/subfield[@code="h"]'
          ), 
          "/", 
          ""
        ), 
        ":", 
        ""
      ), 
      ".", 
      ""
    )
  ) LIKE Concat('%', <<Enter GMD value>>, '%')
GROUP BY
  biblio_metadata.biblionumber
ORDER BY
  GMD

























