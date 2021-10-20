/*
R.003489

----------

Name: ADMINREPORT - From g
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-04-02 22:17:06
Modified on: 2021-04-11 17:03:14
Date last run: 2021-04-11 17:03:24

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblio.author,
  Concat_Ws(" ", 
    biblio.title, 
    biblio.subtitle, 
    biblioitems.number, 
    biblio.part_name
  ) AS FULL_TITLE,
  locs.lib AS BIB_LOCATION,
  itypess.description AS BIB_ITYPE,
  ccodes.lib AS CCODE,
  Date_Format(biblio.datecreated, "%Y.%m.%d") AS DATE_ADDED,
  biblio.biblionumber AS BIBLIO_NUMBER,
  biblioitems.isbn AS ISBN,
  Concat(
    '<a class= "clicked" href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
    biblio.biblionumber, 
    '\" target="_blank">Go to title</a>'
  ) AS LINK_TO_TITLE,
  Group_Concat(icounts.Group_Concat_itemcallnumber) AS CNS,
  GROUP_CONCAT(
    icounts.LOCATIONS 
    ORDER BY icounts.LOCATIONS 
    DESC SEPARATOR
    " | "
  ) AS Group_Concat_LOCATIONS
FROM
  biblio JOIN
  biblioitems ON biblioitems.biblionumber = biblio.biblionumber LEFT JOIN
  (SELECT
     authorised_values.category,
     authorised_values.authorised_value,
     authorised_values.lib,
     authorised_values.lib_opac
   FROM
     authorised_values
   WHERE
     authorised_values.category = 'LOC') locs ON locs.authorised_value =
      biblioitems.agerestriction LEFT JOIN
  (SELECT
     itemtypes.itemtype,
     itemtypes.description
   FROM
     itemtypes) itypess ON itypess.itemtype = biblioitems.itemtype LEFT JOIN
  (SELECT
     authorised_values.category,
     authorised_values.authorised_value,
     authorised_values.lib,
     authorised_values.lib_opac
   FROM
     authorised_values
   WHERE
     authorised_values.category = 'ccode') ccodes ON ccodes.authorised_value =
      biblioitems.cn_class INNER JOIN
  (SELECT
     items.biblionumber,
     Concat_Ws(" - ", LPad(Count(DISTINCT items.itemnumber), 2, 0),
     items.permanent_location) AS LOCATIONS,
     Group_Concat(items.itemcallnumber) AS Group_Concat_itemcallnumber
   FROM
     items
   GROUP BY
     items.biblionumber,
     items.permanent_location) icounts ON icounts.biblionumber =
      biblio.biblionumber
WHERE
  locs.lib IS NULL
GROUP BY
  biblio.biblionumber
HAVING
  Group_Concat_LOCATIONS LIKE "_____A%"

























