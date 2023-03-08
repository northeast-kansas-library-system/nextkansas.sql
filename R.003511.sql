/*
R.003511

----------

Name: 942e - ADULT
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-05-27 22:10:53
Modified on: 2022-12-05 16:05:17
Date last run: 2023-03-08 09:18:19

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
  locs.lib_opac AS BIB_LOC, 
  itypes.description AS BIB_TYPE, 
  ccodes.lib_opac AS BIB_CCODE, 
  biblio.datecreated, 
  biblio.biblionumber, 
  Concat( 
    '<a class= "clicked" href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
    biblio.biblionumber, 
    '\" target="_blank">Go to title</a>' 
  ) AS LINK_TO_TITLE, 
  bib_locations.Group_Concat_permanent_location, 
  biblioitems.agerestriction, 
  bib_locations.Count_permanent_location 
FROM 
  biblio JOIN 
  biblioitems ON biblioitems.biblionumber = biblio.biblionumber LEFT JOIN 
  ( 
    SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib, 
      authorised_values.lib_opac 
    FROM 
      authorised_values 
    WHERE 
      authorised_values.category = 'LOC' 
  ) locs ON locs.authorised_value = biblioitems.agerestriction LEFT JOIN 
  ( 
    SELECT 
      itemtypes.itemtype, 
      itemtypes.description 
    FROM 
      itemtypes 
  ) itypes ON itypes.itemtype = biblioitems.itemtype LEFT JOIN 
  ( 
    SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib, 
      authorised_values.lib_opac 
    FROM 
      authorised_values 
    WHERE 
      authorised_values.category = 'CCODE' 
  ) ccodes ON ccodes.authorised_value = biblioitems.cn_class INNER JOIN 
  ( 
    SELECT 
      items.biblionumber, 
      Group_Concat( 
        DISTINCT 
        If( 
          items.permanent_location LIKE '%AD%', 
          'L_AD', 
          If( 
            items.permanent_location LIKE '%JU%', 
            'L_JU', 
            If( 
              items.permanent_location LIKE '%YA%', 
              'L_YA', 
              'OTHER' 
            ) 
          ) 
        ) 
      ) AS Group_Concat_permanent_location, 
      Count( 
        DISTINCT 
        If( 
          items.permanent_location LIKE '%AD%', 
          'L_AD', 
          If( 
            items.permanent_location LIKE '%JU%', 
            'L_JU', 
            If( 
              items.permanent_location LIKE '%YA%', 
              'L_YA', 
              'OTHER' 
            ) 
          ) 
        ) 
      ) AS Count_permanent_location 
    FROM 
      items 
    GROUP BY 
      items.biblionumber 
    HAVING 
      Count( 
        DISTINCT 
        If( 
          items.permanent_location LIKE '%AD%', 
          'L_AD', 
          If( 
            items.permanent_location LIKE '%JU%', 
            'L_JU', 
            If( 
              items.permanent_location LIKE '%YA%', 
              'L_YA', 
              'OTHER' 
            ) 
          ) 
        ) 
      ) = 1 
  ) bib_locations ON bib_locations.biblionumber = biblio.biblionumber 
WHERE 
  biblioitems.agerestriction <> 'L_AD' AND 
  bib_locations.Group_Concat_permanent_location = 'L_AD' 
GROUP BY 
  biblio.biblionumber 
LIMIT 
  500 

























