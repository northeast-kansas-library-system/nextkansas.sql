/*
R.003596

----------

Name: GHW - Backups - system preferences
Created by: George H Williams

----------

Group: Administrative Reports
     -

Created on: 2021-10-16 14:23:35
Modified on: 2021-10-16 16:29:17
Date last run: 2021-10-16 16:29:21

----------

Public: 0
Expiry: 300

----------



<div id=reportinfo class=noprint>
<p>See Northeast Kansas Library Sytem/system_preference_backup on Github for full instructions</p>
<p></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3596">Click here to download as a csv file</a></p>
<p class= "notetags" style="display: none;">#backups #monthly #sysprefs</p>
</div>

----------
*/



SELECT 
  Concat(If(Length(systempreferences.value) > 30000, "XX.", "SP."), Replace(systempreferences.variable, ":", "_")) AS FILE_NAME, 
  Concat_Ws("", 
    Concat(If(Length(systempreferences.value) > 30000, "XX.", "SP."), systempreferences.variable, ".txt"), 
    Char(13), Char(10), Char(13), Char(10), 
    "----------", 
    Char(13), Char(10), Char(13), Char(10), 
    "Preference name: ", systempreferences.variable, 
    Char(13), Char(10), Char(13), Char(10), 
    "Type: ", systempreferences.type, 
    Char(13), Char(10), Char(13), Char(10), 
    "Options: ", systempreferences.options, 
    Char(13), Char(10), Char(13), Char(10), 
    "----------", 
    Char(13), Char(10), Char(13), Char(10), 
    "Preference value: ", 
    Char(13), Char(10), Char(13), Char(10) 
  ) AS INFO, 
  SubString(systempreferences.value FROM 1 FOR 30000 ) AS PART_ONE, 
  If(Length(systempreferences.value) > 30000, "||AAAAA||", "") AS SEP_ONE, 
  SubString(systempreferences.value FROM 30001 FOR 30000 ) AS PART_TWO, 
  If(Length(systempreferences.value) > 60000, "||AAAAA||", "") AS SEP_TWO, 
  SubString(systempreferences.value FROM 60001 FOR 30000 ) AS PART_THREE, 
  If(Length(systempreferences.value) > 90000, "||AAAAA||", "") AS SEP_THREE, 
  SubString(systempreferences.value FROM 90001 FOR 30000 ) AS PART_FOUR, 
  If(Length(systempreferences.value) > 120000, "||AAAAA||", "") AS SEP_FOUR, 
  SubString(systempreferences.value FROM 120001 FOR 30000 ) AS PART_FIVE 
FROM 
  systempreferences 
GROUP BY 
  systempreferences.variable 

























