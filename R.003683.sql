/*
R.003683

----------

Name: GHW - Quick count - Count of items with potential problems at a library
Created by: George Williams

----------

Group: -
     -

Created on: 2022-11-30 10:34:39
Modified on: 2024-01-17 11:29:52
Date last run: 2023-02-10 16:20:49

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
  &lt;p&gt;Counts items with potential problems on their records&lt;/p&gt;
  &lt;ul&gt;
    &lt;li&gt;Displays items with problems right now&lt;/li&gt;
    &lt;li&gt;at the library you specify&lt;/li&gt;
    &lt;li&gt;grouped and sorted by item homebranch and problem&lt;/li&gt;
    &lt;li&gt;links to report 214&lt;/li&gt;
  &lt;/ul&gt;&lt;br /&gt;
  &lt;p&gt;&lt;/p&gt;
  &lt;p class= "notetags" style="display: none;"&gt;#quick_count&lt;/p&gt;
  &lt;!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt;
&lt;/div&gt;

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
    'List of items'
  ) AS LINK
FROM
  items JOIN
  biblio ON items.biblionumber = biblio.biblionumber JOIN
  biblioitems ON biblioitems.biblionumber = biblio.biblionumber AND
      items.biblioitemnumber = biblioitems.biblioitemnumber LEFT JOIN
  (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC'
  ) plocs ON 
    plocs.authorised_value = items.permanent_location LEFT JOIN
  (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC'
  ) locs ON 
    locs.authorised_value = items.location LEFT JOIN
  (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'ccode'
  ) ccodes ON 
    ccodes.authorised_value = items.ccode LEFT JOIN
  (
    SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes
  ) itypes ON 
    itypes.itemtype = items.itype
WHERE
  items.homebranch LIKE &lt;&gt; AND
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

























