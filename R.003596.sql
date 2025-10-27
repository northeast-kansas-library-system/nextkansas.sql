/*
R.003596

----------

Name: GHW - Backups - system preferences
Created by: George Williams

----------

Group: Administrative Reports
     -

Created on: 2021-10-16 14:23:35
Modified on: 2025-03-08 22:57:44
Date last run: 2025-10-27 13:56:31

----------

Public: 0
Expiry: 300

----------

 
See Northeast Kansas Library Sytem/system_preference_backup on Github for full instructions

Click here to download as a csv file
#backups #monthly #sysprefs






----------
*/



SELECT
  Concat(If(Length(systempreferences.value) &gt; 30000, "XX.", "SP."), Replace(systempreferences.variable, ":", "_")) AS FILE_NAME,
  Concat_Ws("",
    Concat(If(Length(systempreferences.value) &gt; 30000, "XX.", "SP."), systempreferences.variable, ".txt"),
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
  SubString(REPLACE(REPLACE(systempreferences.value, '&gt;', 'GMLGMLGML'), '&lt;', 'ZAZAZAB') FROM 1 FOR 30000 ) AS PART_ONE,
  If(Length(REPLACE(REPLACE(systempreferences.value, '&gt;', 'GMLGMLGML'), '&lt;', 'ZAZAZAB')) &gt; 30000, "||AAAAA||", "") AS SEP_ONE,
  SubString(REPLACE(REPLACE(systempreferences.value, '&gt;', 'GMLGMLGML'), '&lt;', 'ZAZAZAB') FROM 30001 FOR 30000 ) AS PART_TWO,
  If(Length(REPLACE(REPLACE(systempreferences.value, '&gt;', 'GMLGMLGML'), '&lt;', 'ZAZAZAB')) &gt; 60000, "||AAAAA||", "") AS SEP_TWO,
  SubString(REPLACE(REPLACE(systempreferences.value, '&gt;', 'GMLGMLGML'), '&lt;', 'ZAZAZAB') FROM 60001 FOR 30000 ) AS PART_THREE,
  If(Length(REPLACE(REPLACE(systempreferences.value, '&gt;', 'GMLGMLGML'), '&lt;', 'ZAZAZAB')) &gt; 90000, "||AAAAA||", "") AS SEP_THREE,
  SubString(REPLACE(REPLACE(systempreferences.value, '&gt;', 'GMLGMLGML'), '&lt;', 'ZAZAZAB') FROM 90001 FOR 30000 ) AS PART_FOUR,
  If(Length(REPLACE(REPLACE(systempreferences.value, '&gt;', 'GMLGMLGML'), '&lt;', 'ZAZAZAB')) &gt; 120000, "||AAAAA||", "") AS SEP_FOUR,
  SubString(REPLACE(REPLACE(systempreferences.value, '&gt;', 'GMLGMLGML'), '&lt;', 'ZAZAZAB') FROM 120001 FOR 30000 ) AS PART_FIVE
FROM
  systempreferences
GROUP BY
  systempreferences.variable

























