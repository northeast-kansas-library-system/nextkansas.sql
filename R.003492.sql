/*
R.003492

----------

Name: GHW - Titles on a list with publication date and date added to the list
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-04-08 23:47:55
Modified on: 2021-04-09 08:58:43
Date last run: 2021-04-09 16:16:58

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  virtualshelves.shelfname,
  biblio_info.biblionumber,
  biblio_info.BIB_LOCATION,
  biblio_info.BIB_ITYPE,
  biblio_info.BIB_CCODE,
  biblio_info.author,
  biblio_info.TITLE,
  biblio_info.publicationyear,
  virtualshelfcontents.dateadded
FROM
  virtualshelfcontents  JOIN
  (SELECT
     biblio.biblionumber,
     bibloc.lib AS BIB_LOCATION,
     bibitype.description AS BIB_ITYPE,
     bibccode.lib AS BIB_CCODE,
     biblio.author,
     Concat_Ws(" ", biblio.title, biblio.subtitle, biblioitems.number,
     biblio.part_name) AS TITLE,
     biblioitems.publicationyear
   FROM
     biblio  JOIN
     biblioitems ON biblioitems.biblionumber = biblio.biblionumber LEFT JOIN
     (SELECT
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib,
        authorised_values.lib_opac
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'loc') bibloc ON bibloc.authorised_value =
         biblioitems.agerestriction LEFT JOIN
     (SELECT
        itemtypes.itemtype,
        itemtypes.description
      FROM
        itemtypes) bibitype ON bibitype.itemtype = biblioitems.itemtype
     LEFT JOIN
     (SELECT
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib,
        authorised_values.lib_opac
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'ccode') bibccode ON
         bibccode.authorised_value = biblioitems.cn_class) biblio_info
    ON biblio_info.biblionumber = virtualshelfcontents.biblionumber  JOIN
  virtualshelves ON virtualshelfcontents.shelfnumber =
      virtualshelves.shelfnumber
WHERE
  virtualshelfcontents.shelfnumber = <<Enter list ID number>>

























