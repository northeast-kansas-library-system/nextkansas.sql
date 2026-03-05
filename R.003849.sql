/*
R.003849

----------

Name: Test for kus
Created by: George Williams

----------

Group: -
     -

Created on: 2024-06-19 11:46:30
Modified on: 2024-06-19 14:47:13
Date last run: 2024-06-19 14:45:28

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) AS metadata, 
  Count(biblio_metadata.biblionumber) AS BIBS, 
  CASE 
    WHEN SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) 
      IN ('a', 'c', 'd', 'e', 'f', 'g', 'i', 'j', 'k', 'm', 'o', 'p', 'r', 't') 
      THEN SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) 
    ELSE Concat('<span style="text-decoration: underline;">',  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ), ' - Invalid code</span>') 
  END AS LDR_POSITION_6, 
  Concat( 
    '<a class="next_btn next_green noprint"', 
    'href="/cgi-bin/koha/reports/guided_reports.pl?reports=3848&phase=Run+this+report&param_name=Enter+code+for+position+6&sql_params=', 
    SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ), 
    '" target="_blank">Report 3848</a>' 
  ) AS LINK 
FROM 
  biblio_metadata 
GROUP BY 
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) 
ORDER BY 
  metadata 

























