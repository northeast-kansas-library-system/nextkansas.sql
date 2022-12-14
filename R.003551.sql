/*
R.003551

----------

Name: GHW - Output letter templates as .md files
Created by: George H Williams

----------

Group: Administrative Reports
     -

Created on: 2021-08-23 11:13:33
Modified on: 2021-08-23 11:22:19
Date last run: 2022-12-14 11:55:55

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat(Lower(letter.code), ".rst") AS FILENAME,
  Concat(
    ".. include:: /images.rst", 
    Char(13), Char(10), 
    Char(13), Char(10),
    letter.name, 
    Char(13), Char(10), 
    "==========", 
    Char(13), Char(10), 
    Char(13), Char(10), 
    "Notice information", 
    Char(13), Char(10), 
    "----------", 
    Char(13), Char(10), 
    Char(13), Char(10), 
    "Description in progress", 
    Char(13), Char(10), 
    Char(10), Char(13), 
    "Notice details:", 
    Char(13), Char(10), 
    "----------", 
    Char(13), Char(10), 
    Char(13), Char(10), 
    "- General", 
    Char(13), Char(10), 
    "   - Library: ", 
    If(letter.branchcode = "", "* All libraries (default)", letter.branchcode), 
    Char(13), Char(10), 
    "   - Module: ", 
    letter.module, 
    Char(13), Char(10), 
    "   - Code: ", 
    letter.code, 
    Char(13), Char(10), 
    "   - Name: ", 
    letter.name, 
    Char(13), Char(10), 
    Char(13), Char(10), 
    "- Email", 
    Char(13), Char(10), 
    "   - Type: ", 
    If(letter.is_html = 1, "HTML", "Plain text"), 
    Char(13), Char(10), 
    "   - Message subject: ", 
    letter.title, 
    Char(13), Char(10), 
    Char(13), Char(10), 
    Char(13), Char(10), 
    "Message template:", 
    Char(13), Char(10), 
    "^^^^^^^^^^^", 
    Char(13), Char(10), 
    Char(13), Char(10), 
    ".. code-block:: html", 
    Char(13), Char(10), 
    Char(13), Char(10), 
    letter.content, 
    Char(13), Char(10)
  ) AS INFO
FROM
  letter
WHERE
  letter.branchcode = "" AND
  letter.message_transport_type = 'email'
GROUP BY
  letter.code
ORDER BY
  FILENAME

























