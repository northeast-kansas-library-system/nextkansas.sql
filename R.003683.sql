/*
R.003683

----------

Name: Count of problem items at library
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-11-30 10:34:39
Modified on: 2022-11-30 10:45:11
Date last run: 2022-11-30 10:49:28

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  items.homebranch,
  If(
    items.barcode IS NULL, 
    "Barcode is blank", 
    If(
      plocs.lib IS NULL, 
      "Empty permanent location", 
      If(
        plocs.lib LIKE "%Cataloging%", 
        "Permanent location = cataloging", 
        If(
          plocs.lib LIKE "%Processing%", 
          "Permanent location = processing location", 
          If(
            plocs.lib LIKE "%Recently%", 
            "Permanent location = recently returned", 
            If(
              ccodes.lib IS NULL, 
              "Empty collection code", 
              If(
                ccodes.lib LIKE "%(UN%", 
                  "Collection code = (Unclassified)", 
                If(
                  itypes.description IS NULL, 
                  "Item type is blank", 
                  If(
                    itypes.description LIKE "%(UN%", 
                      "Item type = (Unclassified)", 
                    If(
                      items.itemcallnumber IS NULL, 
                      "Call number is blank", 
                      If(
                        items.replacementprice IS NULL, 
                        "Replacement price is blank", 
                        If(
                          items.replacementprice = 0, 
                          "Replacement price = $0.00", 
                          ""
                        )
                      )
                    )
                  )
                )
              )
            )
          )
        )
      )
    )
  ) AS PROBLEM,
  Count(DISTINCT items.itemnumber) AS Count_itemnumber,
  Concat(
    '<a ',
    'class="btn btn-success noprint" ',
    'style="color: white;" ',
    'href=/cgi-bin/koha/reports/guided_reports.pl?reports=214&phase=Run+this+report&param_name=Item+home+library|ZBRAN&sql_params=', 
    items.homebranch, 
    '&param_name=Empty+or+problematic+field+in+item+record|XS_NULLS&sql_params=', 
    If(
      items.barcode IS NULL, 
      "BE", 
      If(
        plocs.lib IS NULL, 
        "LE3", 
        If(
          plocs.lib LIKE "%Cataloging%", 
          "LG3", 
          If(
            plocs.lib LIKE "%Processing%", 
            "LG3", 
            If(
              plocs.lib LIKE "%Recently%", 
              "LG3", 
              If(
                ccodes.lib IS NULL, 
                "CE3", 
                If(
                  ccodes.lib LIKE "%(UN%", 
                  "CG3", 
                  If(
                    itypes.description IS NULL, 
                    "IE3", 
                    If(
                      itypes.description LIKE "%(UN%", 
                      "IG3", 
                      If(
                        items.itemcallnumber IS NULL, 
                        "NE", 
                        If(
                          items.replacementprice IS NULL, 
                          "PE", 
                          If(
                            items.replacementprice = 0, 
                            "PE", ""
                          )
                        )
                      )
                    )
                  )
                )
              )
            )
          )
        )
      )
    ),
    ' target="_blank">List of items</a>'
  ) AS LINK
FROM
  items JOIN
  biblio ON items.biblionumber = biblio.biblionumber JOIN
  biblioitems ON biblioitems.biblionumber = biblio.biblionumber AND
      items.biblioitemnumber = biblioitems.biblioitemnumber LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') plocs ON plocs.authorised_value =
      items.permanent_location LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') locs ON locs.authorised_value =
      items.location LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'ccode') ccodes ON ccodes.authorised_value =
      items.ccode LEFT JOIN
  (SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes) itypes ON itypes.itemtype = items.itype
WHERE
  items.homebranch LIKE <<Choose your library|LBRANCH>> AND
  ( 
    (items.barcode IS NULL) OR
    (plocs.lib IS NULL) OR
    (plocs.lib LIKE "%Cataloging%") OR
    (plocs.lib LIKE "%Processing%") OR
    (plocs.lib LIKE "%Recently%") OR
    (ccodes.lib IS NULL) OR
    (ccodes.lib LIKE "%(UN%") OR
    (itypes.description IS NULL) OR
    (itypes.description LIKE "%(UN%") OR
    (items.itemcallnumber IS NULL) OR
    (items.replacementprice IS NULL)
  )
GROUP BY
  items.homebranch,
  PROBLEM,
  LINK
ORDER BY
  items.homebranch,
  PROBLEM

























