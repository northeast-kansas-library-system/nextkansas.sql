/*
R.003709

----------

Name: GHW - Notices and slips website - work in progress
Created by: George H Williams

----------

Group: -
     -

Created on: 2023-02-17 17:21:17
Modified on: 2023-02-19 17:16:13
Date last run: 2023-02-21 20:35:34

----------

Public: 0
Expiry: 300

----------

    Char(92),

----------
*/



Select 
  Concat(
    'n_s_templates\\',
    If(
      letter.branchcode = '',
      'aaaaa',
      LOWER(letter.branchcode)
    ),
    '.',
    LOWER(letter.code),
    '.',
    letter.lang,
    '.',
    letter.message_transport_type,
    '.rst'
  ) As FILE,
  Concat(
    '.. include:: /include.rst',
    Char(13),
    Char(10),
    Char(13),
    Char(10),
    Concat(
      If(
        letter.branchcode = '',
        'All libraries (default)',
        branches.branchname
      ),
      ' : ',
      letter.name,
      ' -- ',
      letter.code,
      ' -- ',
      letter.message_transport_type
    ),
    Char(13),
    Char(10),
    "============================================================",
    Char(13),
    Char(10),
    Char(13),
    Char(10),
    Concat(
      'Library: :ref:`', 
      If(
        letter.branchcode = '',
        'All libraries (default)<Default notices for all libraries>',
        CONCAT(
          branches.branchname,
          '<Notices for a specific library>'
        )
      ),
      '`'
    ),
    Char(13),
    Char(10),
    Char(13),
    Char(10),
    Concat('Code: :ref:`', letter.code, '`'),
    Char(13),
    Char(10),
    Char(13),
    Char(10),
    Concat('Name: ', letter.name),
    Char(13),
    Char(10),
    Char(13),
    Char(10),
    Concat('Code: ', letter.code),
    Char(13),
    Char(10),
    Char(13),
    Char(10),
    Concat('Language: :ref:`', letter.lang, '<', letter.lang, ' language>`'),
    Char(13),
    Char(10),
    Char(13),
    Char(10),
    Concat('Transport: :ref:`', letter.message_transport_type, '<', letter.message_transport_type, ' transport type>`'),
    Char(13),
    Char(10),
    Char(13),
    Char(10),
    Concat('Subject: ', letter.title),
    Char(13),
    Char(10),
    Char(13),
    Char(10),
    Concat("Message template:"),
    Char(13),
    Char(10),
    Char(13),
    Char(10),
    Concat(".. code-block:: html"),
    Char(13),
    Char(10),
    Char(13),
    Char(10),
    Concat(
      '    ',
      Replace(
        letter.content,
        Char(10),
        Concat(Char(10), '    ')
      )
    ),
    Char(13),
    Char(10),
    Char(13),
    Char(10),
    Concat(
      '|',
      letter.code,
      '|'
    )
  ) As CONTENTS
From letter
  Left Join branches On branches.branchcode = letter.branchcode
Order By FILE

























