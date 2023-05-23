/*
R.003720

----------

Name: GHW - RST test
Created by: George H Williams

----------

Group: -
     -

Created on: 2023-03-22 09:07:30
Modified on: 2023-03-24 16:48:39
Date last run: 2023-03-24 16:49:10

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  Concat( 
    If( 
      Length( 
        Concat( 
          '    ', 
          Replace( 
            saved_sql.savedsql, 
            Char(10), 
            Concat(Char(10), '    ') 
          ) 
        ) 
      ) > 32766, 
      "X_", 
      "report_" 
    ), 
    LPad( 
      saved_sql.id, 
      6, 
      0 
    ) 
  ) AS FILE_NAME, 
  Concat( 
    Concat( 
      ".. include:: /include.rst", 
      Char(13), 
      Char(10), 
      Char(13), 
      Char(10), 
      "Report ", 
      LPad(saved_sql.id, 6, 0), 
      " contents // ", 
      saved_sql.report_name, 
      Char(13), 
      Char(10), 
      Repeat( 
        "=", 
        length( 
          concat( 
            "Report ", 
            LPad(saved_sql.id, 6, 0), 
            " contents // ", 
            saved_sql.report_name 
          ) 
        ) 
      ) 
    ), 
    Char(13), 
    Char(10), 
    Char(13), 
    Char(10), 
    "Report technical information: ", 
    saved_sql.id,
    Char(13), 
    Char(10), 
    Repeat('-', Length(Concat("Report technical information: ", saved_sql.id))),
    Char(13), 
    Char(10), 
    Char(13), 
    Char(10), 
    "ID number: ", 
    saved_sql.id, 
    Char(13), 
    Char(10), 
    Char(13), 
    Char(10), 
    if( 
      saved_sql.report_name is null, 
      '', 
      concat( 
        "Name: ", 
        saved_sql.report_name, 
        Char(13), 
        Char(10), 
        Char(13), 
        Char(10) 
      ) 
    ), 
    if( 
      reportgroups.lib is null, 
      '', 
      Concat( 
        "Group: ", 
        Coalesce(reportgroups.lib, "-"), 
        Char(13), 
        Char(10), 
        Char(13), 
        Char(10) 
      ) 
    ), 
    if( 
      reportsubgroups.lib is null, 
      '', 
      Concat( 
        "Sub-group: ", 
        Coalesce(reportsubgroups.lib, "-"), 
        Char(13), 
        Char(10), 
        Char(13), 
        Char(10) 
      ) 
    ), 
    if( 
      saved_sql.date_created is null, 
      '', 
      concat( 
        "Created on: ", 
        Coalesce(saved_sql.date_created, "-"), 
        Char(13), 
        Char(10), 
        Char(13), 
        Char(10) 
      ) 
    ), 
    if( 
      saved_sql.last_modified is null, 
      '', 
      concat( 
        "Modified on: ", 
        Coalesce(saved_sql.last_modified, "-"), 
        Char(13), 
        Char(10), 
        Char(13), 
        Char(10) 
      ) 
    ), 
    if( 
      saved_sql.cache_expiry = 0, 
      '', 
      concat( 
        'Cache expiry in seconds: ', 
        saved_sql.cache_expiry, 
        Char(13), 
        Char(10), 
        Char(13), 
        Char(10) 
      ) 
    ), 
    if( 
      saved_sql.public <> 1, 
      "", 
      concat( 
        "Public: ", 
        "Yes", 
        Char(13), 
        Char(10), 
        Char(13), 
        Char(10) 
      ) 
    ), 
    if( 
      borrowers.userid is null, 
      '', 
      concat( 
        'Created by: ', 
        borrowers.userid, 
        Char(13), 
        Char(10), 
        Char(13), 
        Char(10) 
      ) 
    ), 
    CONCAT( 
      'This file generated: ', 
      now(), 
      Char(13), 
      Char(10), 
      Char(13), 
      Char(10) 
    ), 
    if( 
      saved_sql.notes, 
      '', 
      concat( 
        'Notes:', 
        Char(13), 
        Char(10), 
        Char(13), 
        Char(10), 
        '.. raw:: html', 
        Char(13), 
        Char(10), 
        Char(13), 
        Char(10), 
        '  <div style="border: 1px solid black; padding: 25px;">', 
        Char(13), 
        Char(10), 
        Char(13), 
        Char(10), 
        concat( 
          '    ', 
          Replace( 
            saved_sql.notes, 
            Char(10), 
            Concat(Char(10), '    ') 
          ) 
        ), 
        Char(13), 
        Char(10), 
        Char(13), 
        Char(10), 
        '  </div>' 
      ) 
    ), 
    Char(13), 
    Char(10), 
    Char(13), 
    Char(10), 
    Char(13), 
    Char(10), 
    "----------", 
    Char(13), 
    Char(10), 
    Char(13), 
    Char(10), 
    "SQL: ", 
    saved_sql.id, 
    Char(13), 
    Char(10), 
    Repeat("-", LENGTH(Concat("SQL: ", saved_sql.id))), 
    Char(13), 
    Char(10), 
    Char(13), 
    Char(10), 
    '.. code-block:: sql', 
    Char(13), 
    Char(10), 
    '  :linenos:' 
  ) AS CONTENTS, 
  Concat( 
    '    ', 
    SubString( 
      Replace( 
        saved_sql.savedsql, 
        Char(10), 
        Concat(Char(10), '    ') 
      ) 
      From 1 for 30000 
    ) 
  ) AS PART_ONE, 
  If( 
    Length( 
      Concat( 
        '    ', 
        ( 
          Replace( 
            saved_sql.savedsql, 
            Char(10), 
            Concat(Char(10), '    ') 
          ) 
        ) 
      ) 
    ) > 30000, 
    "||AAAAA||", 
    "" 
  ) AS SEP_ONE, 
  Concat( 
    '    ', 
    SubString( 
      Replace( 
        saved_sql.savedsql, 
        Char(10), 
        Concat(Char(10), '    ') 
      ) 
      From 30001 for 30000 
    ) 
  ) AS PART_TWO, 
  If( 
    Length( 
      Concat( 
        '    ', 
        ( 
          Replace( 
            saved_sql.savedsql, 
            Char(10), 
            Concat(Char(10), '    ') 
          ) 
        ) 
      ) 
    ) > 60000, 
    "||AAAAA||", 
    "" 
  ) AS SEP_TWO, 
  Concat( 
    '    ', 
    SubString( 
      Replace( 
        saved_sql.savedsql, 
        Char(10), 
        Concat(Char(10), '    ') 
      ) 
      From 60001 for 30000 
    ) 
  ) AS PART_THREE, 
  If( 
    Length( 
      Concat( 
        '    ', 
        ( 
          Replace( 
            saved_sql.savedsql, 
            Char(10), 
            Concat(Char(10), '    ') 
          ) 
        ) 
      ) 
    ) > 90000, 
    "||AAAAA||", 
    "" 
  ) AS SEP_THREE, 
  Concat( 
    '    ', 
    SubString( 
      Replace( 
        saved_sql.savedsql, 
        Char(10), 
        Concat(Char(10), '    ') 
      ) 
      From 90001 for 30000 
    ) 
  ) AS PART_FOUR, 
  If( 
    Length( 
      Concat( 
        '    ', 
        ( 
          Replace( 
            saved_sql.savedsql, 
            Char(10), 
            Concat(Char(10), '    ') 
          ) 
        ) 
      ) 
    ) > 120000, 
    "||AAAAA||", 
    "" 
  ) AS SEP_FOUR, 
  Concat( 
    '    ', 
    SubString( 
      Replace( 
        saved_sql.savedsql, 
        Char(10), 
        Concat(Char(10), '    ') 
      ) 
      From 120001 for 30000 
    ) 
  ) AS PART_FIVE 
FROM 
  saved_sql 
  LEFT JOIN borrowers ON saved_sql.borrowernumber = borrowers.borrowernumber 
  LEFT JOIN 
  ( 
    SELECT authorised_values.id, 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib, 
      authorised_values.imageurl, 
      authorised_values.lib_opac 
    FROM authorised_values 
    WHERE authorised_values.category = 'REPORT_GROUP' 
  ) reportgroups ON saved_sql.report_group = reportgroups.authorised_value 
  LEFT JOIN 
  ( 
    SELECT authorised_values.id, 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib, 
      authorised_values.imageurl, 
      authorised_values.lib_opac 
    FROM authorised_values 
    WHERE authorised_values.category = 'REPORT_SUBGROUP' 
  ) reportsubgroups ON saved_sql.report_subgroup = reportsubgroups.authorised_value 
GROUP BY 
  saved_sql.id 
ORDER BY 
  FILE_NAME 

























