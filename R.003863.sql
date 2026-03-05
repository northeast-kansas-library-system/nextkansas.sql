/*
R.003863

----------

Name: GHW - Get all 10 and 13 digit ISBNs
Created by: George Williams

----------

Group: -
     -

Created on: 2024-10-17 11:10:34
Modified on: 2024-10-19 10:47:11
Date last run: 2026-01-09 10:46:53

----------

Public: 0
Expiry: 300

----------

<div class="reportInfo noprint"> 
 
  <div class="reportInfoContent"> 
 
    <p>Outputs a list of all 10 and 13 digit ISBNs</p> 
 
    <ul> 
      <li>Shows current ISBNs in biblioitems table</li> 
      <li>at all Next Search Catalog libraries</li> 
      <li>grouped by ISBN</li> 
    </ul> 
 
  </div> 
 
  <div class="reportInfoNotes"> 
 
    <p> 
 
    </p> 
 
    <p> 
     Used for Novelist updates
    </p> 
 
  </div> 
 
  <div id="reportInfoLinks"> 
 
    <p id="sql_quick_down"> 
      <a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=3863"> 
        Click here to download as a csv file 
      </a> 
    </p> 
 
  </div> 
 
  <div id="reportInfoTags"> 
 
    <p style="display: none;"> 
      #isbn #novelist
    </p> 
 
  </div> 
 
  <!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/Query_Library#Render_patron_messages_as_HTML_and_in_Report_notes --> 
 
</div> 

----------
*/



SELECT 
  IF( 
    Length(Trim(SubString_Index(biblioitems.isbn, '|', 1))) = 13, 
    Trim(SubString_Index(biblioitems.isbn, '|', 1)), 
    IF( 
      Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 2), '|', -1))) = 10, 
      Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 2), '|', -1)), 
      IF( 
        Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 3), '|', -1))) = 10, 
        Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 3), '|', -1)), 
        IF( 
          Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 4), '|', -1))) = 10, 
          Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 4), '|', -1)), 
          IF( 
            Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 5), '|', -1))) = 10, 
            Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 5), '|', -1)), 
            IF( 
              Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 6), '|', -1))) = 10, 
              Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 6), '|', -1)), 
              IF( 
                Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 7), '|', -1))) = 10, 
                Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 7), '|', -1)), 
                IF( 
                  Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 8), '|', -1))) = 10, 
                  Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 8), '|', -1)), 
                  IF( 
                    Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 9), '|', -1))) = 10, 
                    Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 9), '|', -1)), 
                    IF( 
                      Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 10), '|', -1))) = 10, 
                      Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 10), '|', -1)), 
                      IF( 
                        Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 10), '|', -1))) = 10, 
                        Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 11), '|', -1)), 
                        IF( 
                          Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 10), '|', -1))) = 10, 
                          Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 12), '|', -1)), 
                          IF( 
                            Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 10), '|', -1))) = 10, 
                            Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 13), '|', -1)), 
                            IF( 
                              Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 10), '|', -1))) = 10, 
                              Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 14), '|', -1)), 
                              IF( 
                                Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 10), '|', -1))) = 10, 
                                Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 15), '|', -1)), 
                                IF( 
                                  Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 10), '|', -1))) = 10, 
                                  Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 16), '|', -1)), 
                                  IF( 
                                    Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 10), '|', -1))) = 10, 
                                    Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 17), '|', -1)), 
                                    IF( 
                                      Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 10), '|', -1))) = 10, 
                                      Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 18), '|', -1)), 
                                      IF( 
                                        Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 10), '|', -1))) = 10, 
                                        Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 19), '|', -1)), 
                                        IF( 
                                          Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 10), '|', -1))) = 10, 
                                          Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 20), '|', -1)), 
                                          'X' 
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
                  ) 
                ) 
              ) 
            ) 
          ) 
        ) 
      ) 
    ) 
  ) AS isbns 
FROM 
  biblioitems 
GROUP BY 
  isbns 
HAVING 
  isbns <> 'X' AND 
  isbns Not like '%:%' AND 
  isbns Not like '%-%' AND 
  isbns Not like '%"%' AND 
  isbns Not like '%a%' AND 
  isbns Not like '%b%' AND 
  isbns Not like '%c%' AND 
  isbns Not like '%d%' AND 
  isbns Not like '%e%' AND 
  isbns Not like '%f%' AND 
  isbns Not like '%g%' AND 
  isbns Not like '%h%' AND 
  isbns Not like '%i%' AND 
  isbns Not like '%j%' AND 
  isbns Not like '%k%' AND 
  isbns Not like '%l%' AND 
  isbns Not like '%m%' AND 
  isbns Not like '%n%' AND 
  isbns Not like '%o%' AND 
  isbns Not like '%p%' AND 
  isbns Not like '%q%' AND 
  isbns Not like '%r%' AND 
  isbns Not like '%s%' AND 
  isbns Not like '%t%' AND 
  isbns Not like '%u%' AND 
  isbns Not like '%v%' AND 
  isbns Not like '%w%' AND 
  isbns Not like '%y%' AND 
  isbns Not like '%z%' 
UNION 
SELECT 
  IF( 
    Length(Trim(SubString_Index(biblioitems.isbn, '|', 1))) = 13, 
    Trim(SubString_Index(biblioitems.isbn, '|', 1)), 
    IF( 
      Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 2), '|', -1))) = 13, 
      Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 2), '|', -1)), 
      IF( 
        Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 3), '|', -1))) = 13, 
        Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 3), '|', -1)), 
        IF( 
          Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 4), '|', -1))) = 13, 
          Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 4), '|', -1)), 
          IF( 
            Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 5), '|', -1))) = 13, 
            Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 5), '|', -1)), 
            IF( 
              Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 6), '|', -1))) = 13, 
              Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 6), '|', -1)), 
              IF( 
                Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 7), '|', -1))) = 13, 
                Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 7), '|', -1)), 
                IF( 
                  Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 8), '|', -1))) = 13, 
                  Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 8), '|', -1)), 
                  IF( 
                    Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 9), '|', -1))) = 13, 
                    Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 9), '|', -1)), 
                    IF( 
                      Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 10), '|', -1))) = 13, 
                      Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 10), '|', -1)), 
                      IF( 
                        Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 10), '|', -1))) = 13, 
                        Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 11), '|', -1)), 
                        IF( 
                          Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 10), '|', -1))) = 13, 
                          Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 12), '|', -1)), 
                          IF( 
                            Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 10), '|', -1))) = 13, 
                            Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 13), '|', -1)), 
                            IF( 
                              Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 10), '|', -1))) = 13, 
                              Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 14), '|', -1)), 
                              IF( 
                                Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 10), '|', -1))) = 13, 
                                Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 15), '|', -1)), 
                                IF( 
                                  Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 10), '|', -1))) = 13, 
                                  Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 16), '|', -1)), 
                                  IF( 
                                    Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 10), '|', -1))) = 13, 
                                    Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 17), '|', -1)), 
                                    IF( 
                                      Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 10), '|', -1))) = 13, 
                                      Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 18), '|', -1)), 
                                      IF( 
                                        Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 10), '|', -1))) = 13, 
                                        Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 19), '|', -1)), 
                                        IF( 
                                          Length(Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 10), '|', -1))) = 13, 
                                          Trim(SubString_Index(SubString_Index(biblioitems.isbn, '|', 20), '|', -1)), 
                                          'X' 
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
                  ) 
                ) 
              ) 
            ) 
          ) 
        ) 
      ) 
    ) 
  ) AS isbns 
FROM 
  biblioitems 
GROUP BY 
  isbns 
HAVING 
  isbns <> 'X' AND 
  isbns Not like '%:%' AND 
  isbns Not like '%-%' AND 
  isbns Not like '%"%' AND 
  isbns Not like '%a%' AND 
  isbns Not like '%b%' AND 
  isbns Not like '%c%' AND 
  isbns Not like '%d%' AND 
  isbns Not like '%e%' AND 
  isbns Not like '%f%' AND 
  isbns Not like '%g%' AND 
  isbns Not like '%h%' AND 
  isbns Not like '%i%' AND 
  isbns Not like '%j%' AND 
  isbns Not like '%k%' AND 
  isbns Not like '%l%' AND 
  isbns Not like '%m%' AND 
  isbns Not like '%n%' AND 
  isbns Not like '%o%' AND 
  isbns Not like '%p%' AND 
  isbns Not like '%q%' AND 
  isbns Not like '%r%' AND 
  isbns Not like '%s%' AND 
  isbns Not like '%t%' AND 
  isbns Not like '%u%' AND 
  isbns Not like '%v%' AND 
  isbns Not like '%w%' AND 
  isbns Not like '%y%' AND 
  isbns Not like '%z%' 

























