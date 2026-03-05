/*
R.003743

----------

Name: FAST builder ADMINREPORT
Created by: George Williams

----------

Group: -
     -

Created on: 2023-07-25 18:32:59
Modified on: 2023-07-25 19:47:20
Date last run: 2023-07-25 19:59:13

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  auth_header.authid,
  auth_header.authtypecode,
  ExtractValue(auth_header.marcxml, '//datafield[@tag="155"]/subfield[@code="a"]') AS AAAAA,
  ExtractValue(auth_header.marcxml, '//datafield[@tag="010"]/subfield[@code="a"]') AS TEN,
  Concat("(DLC)", (ExtractValue(auth_header.marcxml, '//datafield[@tag="010"]/subfield[@code="a"]'))) AS FST_O,
  ExtractValue(auth_header.marcxml, '//datafield[@tag="016"]/subfield[@code="a"]') AS SIXTEEN,
  ExtractValue(auth_header.marcxml, '//datafield[@tag="024"]/subfield[@code="0"]') AS TWENTYFOUR_0,
  ExtractValue(auth_header.marcxml, '//datafield[@tag="024"]/subfield[@code="a"]') AS TWENTYFOUR_A,
  ExtractValue(auth_header.marcxml, '//datafield[@tag="035"]/subfield[@code="a"]') AS THIRTYFIVE,
  auth_header.authid AS VALUE1,
  Concat('(OCoLC)', (ExtractValue(auth_header.marcxml, '//datafield[@tag="016"]/subfield[@code="a"]'))) AS FST_O,
  Concat(
    'SUBFIELD_EDIT[t]655[t]0[t]', 
    Concat('(OCoLC)', (ExtractValue(auth_header.marcxml, '//datafield[@tag="016"]/subfield[@code="a"]')), '[t]'),
    Concat(
      '(OCoLC)', 
      (ExtractValue(auth_header.marcxml, '//datafield[@tag="016"]/subfield[@code="a"]')), 
      '$9', 
      auth_header.authid,
      '[t]0|1'
    )
  ) AS X,
  Concat(
    'SUBFIELD_EDIT[t]655[t]0[t]', 
    Concat('(DLC)', (ExtractValue(auth_header.marcxml, '//datafield[@tag="010"]/subfield[@code="a"]')), '[t]'),
    Concat(
      '(DLC)', 
      (ExtractValue(auth_header.marcxml, '//datafield[@tag="010"]/subfield[@code="a"]')), 
      '$9', 
      auth_header.authid,
      '[t]0|1'
    )
  ) AS Y
FROM
  auth_header
WHERE
  auth_header.authtypecode = "GENRE/FORM"
GROUP BY
  auth_header.authid

























