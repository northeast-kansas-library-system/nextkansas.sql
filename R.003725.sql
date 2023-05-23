/*
R.003725

----------

Name: Subfield matcher
Created by: George H Williams

----------

Group: -
     -

Created on: 2023-04-17 14:28:38
Modified on: 2023-04-21 14:13:05
Date last run: 2023-05-15 12:42:23

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  y.CTRLX,
  y.tagfield,
  y.tagsubfield,
  d.CTRLX AS CTRLX1,
  If(
    y.liblibrarian = '',
    '-',
    If(y.liblibrarian IS NULL, '-', y.liblibrarian)
  ) AS `"Text for librarian_1"`,
  If(
    d.liblibrarian = '',
    '-',
    If(d.liblibrarian IS NULL, '-', d.liblibrarian)
  ) AS `"Text for librarian_2"`,
  If(
    If(
      y.liblibrarian = '',
      '-',
      If(y.liblibrarian IS NULL, '-', y.liblibrarian)
    ) <> If(
      d.liblibrarian = '',
      '-',
      If(d.liblibrarian IS NULL, '-', d.liblibrarian)
    ),
    'No',
    'Yes'
  ) AS `"Text for librarian_matches"`,
  If(
    y.libopac = '',
    '-',
    If(y.libopac IS NULL, '-', y.libopac)
  ) AS `"Text for OPAC_1"`,
  If(
    d.libopac = '',
    '-',
    If(d.libopac IS NULL, '-', d.libopac)
  ) AS `"Text for OPAC_2"`,
  If(
    If(
      y.libopac = '',
      '-',
      If(y.libopac IS NULL, '-', y.libopac)
    ) <> If(
      d.libopac = '',
      '-',
      If(d.libopac IS NULL, '-', d.libopac)
    ),
    'No',
    'Yes'
  ) AS `"Text for OPAC_matches"`,
  If(
    y.repeatable = '',
    '-',
    If(y.repeatable IS NULL, '-', y.repeatable)
  ) AS `"Repeatable_1"`,
  If(
    d.repeatable = '',
    '-',
    If(d.repeatable IS NULL, '-', d.repeatable)
  ) AS `"Repeatable_2"`,
  If(
    If(
      y.repeatable = '',
      '-',
      If(y.repeatable IS NULL, '-', y.repeatable)
    ) <> If(
      d.repeatable = '',
      '-',
      If(d.repeatable IS NULL, '-', d.repeatable)
    ),
    'No',
    'Yes'
  ) AS `"Repeatable_matches"`,
  If(
    y.mandatory = '',
    '-',
    If(y.mandatory IS NULL, '-', y.mandatory)
  ) AS `"Mandatory_1"`,
  If(
    d.mandatory = '',
    '-',
    If(d.mandatory IS NULL, '-', d.mandatory)
  ) AS `"Mandatory_2"`,
  If(
    If(
      y.mandatory = '',
      '-',
      If(y.mandatory IS NULL, '-', y.mandatory)
    ) <> If(
      d.mandatory = '',
      '-',
      If(d.mandatory IS NULL, '-', d.mandatory)
    ),
    'No',
    'Yes'
  ) AS `"Mandatory_matches"`,
  If(
    y.important = '',
    '-',
    If(y.important IS NULL, '-', y.important)
  ) AS `"Important_1"`,
  If(
    d.important = '',
    '-',
    If(d.important IS NULL, '-', d.important)
  ) AS `"Important_2"`,
  If(
    If(
      y.important = '',
      '-',
      If(y.important IS NULL, '-', y.important)
    ) <> If(
      d.important = '',
      '-',
      If(d.important IS NULL, '-', d.important)
    ),
    'No',
    'Yes'
  ) AS `"Important_matches"`,
  If(y.tab = '', '-', If(y.tab IS NULL, '-', y.tab)) AS `"Managed in tab_1"`,
  If(d.tab = '', '-', If(d.tab IS NULL, '-', d.tab)) AS `"Managed in tab_2"`,
  If(
    If(y.tab = '', '-', If(y.tab IS NULL, '-', y.tab)) <> If(
      d.tab = '',
      '-',
      If(d.tab IS NULL, '-', d.tab)
    ),
    'No',
    'Yes'
  ) AS `"Managed in tab_matches"`,
  If(
    y.defaultvalue = '',
    '-',
    If(y.defaultvalue IS NULL, '-', y.defaultvalue)
  ) AS `"Default value_1"`,
  If(
    d.defaultvalue = '',
    '-',
    If(d.defaultvalue IS NULL, '-', d.defaultvalue)
  ) AS `"Default value_2"`,
  If(
    If(
      y.defaultvalue = '',
      '-',
      If(y.defaultvalue IS NULL, '-', y.defaultvalue)
    ) <> If(
      d.defaultvalue = '',
      '-',
      If(d.defaultvalue IS NULL, '-', d.defaultvalue)
    ),
    'No',
    'Yes'
  ) AS `"Default value_matches"`,
  If(
    y.maxlength = '',
    '-',
    If(y.maxlength IS NULL, '-', y.maxlength)
  ) AS `"Max length_1"`,
  If(
    d.maxlength = '',
    '-',
    If(d.maxlength IS NULL, '-', d.maxlength)
  ) AS `"Max length_2"`,
  If(
    If(
      y.maxlength = '',
      '-',
      If(y.maxlength IS NULL, '-', y.maxlength)
    ) <> If(
      d.maxlength = '',
      '-',
      If(d.maxlength IS NULL, '-', d.maxlength)
    ),
    'No',
    'Yes'
  ) AS `"Max length_matches"`,
  If(
    y.hidden = '',
    '-',
    If(y.hidden IS NULL, '-', y.hidden)
  ) AS `"Visibility_1"`,
  If(
    d.hidden = '',
    '-',
    If(d.hidden IS NULL, '-', d.hidden)
  ) AS `"Visibility_2"`,
  If(
    If(
      y.hidden = '',
      '-',
      If(y.hidden IS NULL, '-', y.hidden)
    ) <> If(
      d.hidden = '',
      '-',
      If(d.hidden IS NULL, '-', d.hidden)
    ),
    'No',
    'Yes'
  ) AS `"Visibility_matches"`,
  If(
    y.isurl = '',
    '-',
    If(y.isurl IS NULL, '-', y.isurl)
  ) AS `"Is a URL_1"`,
  If(
    d.isurl = '',
    '-',
    If(d.isurl IS NULL, '-', d.isurl)
  ) AS `"Is a URL_2"`,
  If(
    If(
      y.isurl = '',
      '-',
      If(y.isurl IS NULL, '-', y.isurl)
    ) <> If(
      d.isurl = '',
      '-',
      If(d.isurl IS NULL, '-', d.isurl)
    ),
    'No',
    'Yes'
  ) AS `"Is a URL_matches"`,
  If(
    y.link = '',
    '-',
    If(y.link IS NULL, '-', y.link)
  ) AS `"Link_1"`,
  If(
    d.link = '',
    '-',
    If(d.link IS NULL, '-', d.link)
  ) AS `"Link_2"`,
  If(
    If(
      y.link = '',
      '-',
      If(y.link IS NULL, '-', y.link)
    ) <> If(
      d.link = '',
      '-',
      If(d.link IS NULL, '-', d.link)
    ),
    'No',
    'Yes'
  ) AS `"Link_matches"`,
  If(
    y.kohafield = '',
    '-',
    If(y.kohafield IS NULL, '-', y.kohafield)
  ) AS `"Koha link_1"`,
  If(
    d.kohafield = '',
    '-',
    If(d.kohafield IS NULL, '-', d.kohafield)
  ) AS `"Koha link_2"`,
  If(
    If(
      y.kohafield = '',
      '-',
      If(y.kohafield IS NULL, '-', y.kohafield)
    ) <> If(
      d.kohafield = '',
      '-',
      If(d.kohafield IS NULL, '-', d.kohafield)
    ),
    'No',
    'Yes'
  ) AS `"Koha link_matches"`,
  If(
    y.authorised_value = '',
    '-',
    If(
      y.authorised_value IS NULL,
      '-',
      y.authorised_value
    )
  ) AS `"Authorized value_1"`,
  If(
    d.authorised_value = '',
    '-',
    If(
      d.authorised_value IS NULL,
      '-',
      d.authorised_value
    )
  ) AS `"Authorized value_2"`,
  If(
    If(
      y.authorised_value = '',
      '-',
      If(
        y.authorised_value IS NULL,
        '-',
        y.authorised_value
      )
    ) <> If(
      d.authorised_value = '',
      '-',
      If(
        d.authorised_value IS NULL,
        '-',
        d.authorised_value
      )
    ),
    'No',
    'Yes'
  ) AS `"Authorized value_matches"`,
  If(
    y.authtypecode = '',
    '-',
    If(y.authtypecode IS NULL, '-', y.authtypecode)
  ) AS `"Thesaurus_1"`,
  If(
    d.authtypecode = '',
    '-',
    If(d.authtypecode IS NULL, '-', d.authtypecode)
  ) AS `"Thesaurus_2"`,
  If(
    If(
      y.authtypecode = '',
      '-',
      If(y.authtypecode IS NULL, '-', y.authtypecode)
    ) <> If(
      d.authtypecode = '',
      '-',
      If(d.authtypecode IS NULL, '-', d.authtypecode)
    ),
    'No',
    'Yes'
  ) AS `"Thesaurus_matches"`,
  If(
    y.value_builder = '',
    '-',
    If(y.value_builder IS NULL, '-', y.value_builder)
  ) AS `"Plugin_1"`,
  If(
    d.value_builder = '',
    '-',
    If(d.value_builder IS NULL, '-', d.value_builder)
  ) AS `"Plugin_2"`,
  If(
    If(
      y.value_builder = '',
      '-',
      If(y.value_builder IS NULL, '-', y.value_builder)
    ) <> If(
      d.value_builder = '',
      '-',
      If(d.value_builder IS NULL, '-', d.value_builder)
    ),
    'No',
    'Yes'
  ) AS `"Plugin_matches"`,
  If(
    y.seealso = '',
    '-',
    If(y.seealso IS NULL, '-', y.seealso)
  ) AS `"See also_1"`,
  If(
    d.seealso = '',
    '-',
    If(d.seealso IS NULL, '-', d.seealso)
  ) AS `"See also_2"`,
  If(
    If(
      y.seealso = '',
      '-',
      If(y.seealso IS NULL, '-', y.seealso)
    ) <> If(
      d.seealso = '',
      '-',
      If(d.seealso IS NULL, '-', d.seealso)
    ),
    'No',
    'Yes'
  ) AS `"See also_match"`,
  If(
    y.display_order = '',
    '-',
    If(y.display_order IS NULL, '-', y.display_order)
  ) AS `"Display order_1"`,
  If(
    d.display_order = '',
    '-',
    If(d.display_order IS NULL, '-', d.display_order)
  ) AS `"Display order_2"`,
  If(
    If(
      y.display_order = '',
      '-',
      If(y.display_order IS NULL, '-', y.display_order)
    ) <> If(
      d.display_order = '',
      '-',
      If(d.display_order IS NULL, '-', d.display_order)
    ),
    'No',
    'Yes'
  ) AS `"Display order_match"`,
  CONCAT_WS('', 'https://staff.nextkansas.org/cgi-bin/koha/admin/marc_subfields_structure.pl?op=add_form&tagfield=', y.tagfield, '&frameworkcode=', d.frameworkcode )
FROM (
    SELECT Concat(
        marc_subfield_structure.tagfield,
        marc_subfield_structure.tagsubfield
      ) AS CTRLX,
      marc_subfield_structure.tagfield,
      marc_subfield_structure.tagsubfield,
      marc_subfield_structure.liblibrarian,
      marc_subfield_structure.libopac,
      marc_subfield_structure.repeatable,
      marc_subfield_structure.mandatory,
      marc_subfield_structure.important,
      marc_subfield_structure.kohafield,
      marc_subfield_structure.tab,
      marc_subfield_structure.authorised_value,
      marc_subfield_structure.authtypecode,
      marc_subfield_structure.value_builder,
      marc_subfield_structure.isurl,
      marc_subfield_structure.hidden,
      marc_subfield_structure.frameworkcode,
      marc_subfield_structure.seealso,
      marc_subfield_structure.link,
      marc_subfield_structure.defaultvalue,
      marc_subfield_structure.maxlength,
      marc_subfield_structure.display_order
    FROM marc_subfield_structure
    WHERE
  marc_subfield_structure.frameworkcode = 'Y'
  ) y
  LEFT JOIN (
    SELECT Concat(
        marc_subfield_structure.tagfield,
        marc_subfield_structure.tagsubfield
      ) AS CTRLX,
      marc_subfield_structure.tagfield,
      marc_subfield_structure.tagsubfield,
      marc_subfield_structure.liblibrarian,
      marc_subfield_structure.libopac,
      marc_subfield_structure.repeatable,
      marc_subfield_structure.mandatory,
      marc_subfield_structure.important,
      marc_subfield_structure.kohafield,
      marc_subfield_structure.tab,
      marc_subfield_structure.authorised_value,
      marc_subfield_structure.authtypecode,
      marc_subfield_structure.value_builder,
      marc_subfield_structure.isurl,
      marc_subfield_structure.hidden,
      marc_subfield_structure.frameworkcode,
      marc_subfield_structure.seealso,
      marc_subfield_structure.link,
      marc_subfield_structure.defaultvalue,
      marc_subfield_structure.maxlength,
      marc_subfield_structure.display_order
    FROM marc_subfield_structure
    WHERE marc_subfield_structure.frameworkcode = ''
  ) d ON d.CTRLX = y.CTRLX
WHERE 
  y.tagsubfield Like <<Enter subfield>> AND
  If(
    If(
      y.liblibrarian = '',
      '-',
      If(y.liblibrarian IS NULL, '-', y.liblibrarian)
    ) <> If(
      d.liblibrarian = '',
      '-',
      If(d.liblibrarian IS NULL, '-', d.liblibrarian)
    ),
    'No',
    'Yes'
  ) LIKE <<"Text for librarian" match|ZYES_NO>>
  AND If(
    If(
      y.libopac = '',
      '-',
      If(y.libopac IS NULL, '-', y.libopac)
    ) <> If(
      d.libopac = '',
      '-',
      If(d.libopac IS NULL, '-', d.libopac)
    ),
    'No',
    'Yes'
  ) LIKE <<"Text for OPAC" match|ZYES_NO>>
  AND If(
    If(
      y.repeatable = '',
      '-',
      If(y.repeatable IS NULL, '-', y.repeatable)
    ) <> If(
      d.repeatable = '',
      '-',
      If(d.repeatable IS NULL, '-', d.repeatable)
    ),
    'No',
    'Yes'
  ) LIKE <<"Repeatable" match|ZYES_NO>>
  AND If(
    If(
      y.mandatory = '',
      '-',
      If(y.mandatory IS NULL, '-', y.mandatory)
    ) <> If(
      d.mandatory = '',
      '-',
      If(d.mandatory IS NULL, '-', d.mandatory)
    ),
    'No',
    'Yes'
  ) LIKE <<"Mandatory" match|ZYES_NO>>
  AND If(
    If(
      y.important = '',
      '-',
      If(y.important IS NULL, '-', y.important)
    ) <> If(
      d.important = '',
      '-',
      If(d.important IS NULL, '-', d.important)
    ),
    'No',
    'Yes'
  ) LIKE <<"Important" match|ZYES_NO>>
  AND If(
    If(y.tab = '', '-', If(y.tab IS NULL, '-', y.tab)) <> If(
      d.tab = '',
      '-',
      If(d.tab IS NULL, '-', d.tab)
    ),
    'No',
    'Yes'
  ) LIKE <<"Managed in tab" match|ZYES_NO>>
  AND If(
    If(
      y.defaultvalue = '',
      '-',
      If(y.defaultvalue IS NULL, '-', y.defaultvalue)
    ) <> If(
      d.defaultvalue = '',
      '-',
      If(d.defaultvalue IS NULL, '-', d.defaultvalue)
    ),
    'No',
    'Yes'
  ) LIKE <<"Default value" match|ZYES_NO>>
  AND If(
    If(
      y.maxlength = '',
      '-',
      If(y.maxlength IS NULL, '-', y.maxlength)
    ) <> If(
      d.maxlength = '',
      '-',
      If(d.maxlength IS NULL, '-', d.maxlength)
    ),
    'No',
    'Yes'
  ) LIKE <<"Max length" match|ZYES_NO>>
  AND If(
    If(
      y.hidden = '',
      '-',
      If(y.hidden IS NULL, '-', y.hidden)
    ) <> If(
      d.hidden = '',
      '-',
      If(d.hidden IS NULL, '-', d.hidden)
    ),
    'No',
    'Yes'
  ) LIKE <<"Visibility" match|ZYES_NO>>
  AND If(
    If(
      y.isurl = '',
      '-',
      If(y.isurl IS NULL, '-', y.isurl)
    ) <> If(
      d.isurl = '',
      '-',
      If(d.isurl IS NULL, '-', d.isurl)
    ),
    'No',
    'Yes'
  ) LIKE <<"Is a URL" match|ZYES_NO>>
  AND If(
    If(
      y.link = '',
      '-',
      If(y.link IS NULL, '-', y.link)
    ) <> If(
      d.link = '',
      '-',
      If(d.link IS NULL, '-', d.link)
    ),
    'No',
    'Yes'
  ) LIKE <<"Link" match|ZYES_NO>>
  AND If(
    If(
      y.kohafield = '',
      '-',
      If(y.kohafield IS NULL, '-', y.kohafield)
    ) <> If(
      d.kohafield = '',
      '-',
      If(d.kohafield IS NULL, '-', d.kohafield)
    ),
    'No',
    'Yes'
  ) LIKE <<"Koha link" match|ZYES_NO>>
  AND If(
    If(
      y.authorised_value = '',
      '-',
      If(
        y.authorised_value IS NULL,
        '-',
        y.authorised_value
      )
    ) <> If(
      d.authorised_value = '',
      '-',
      If(
        d.authorised_value IS NULL,
        '-',
        d.authorised_value
      )
    ),
    'No',
    'Yes'
  ) LIKE <<"Authorized value" match|ZYES_NO>>
  AND If(
    If(
      y.authtypecode = '',
      '-',
      If(y.authtypecode IS NULL, '-', y.authtypecode)
    ) <> If(
      d.authtypecode = '',
      '-',
      If(d.authtypecode IS NULL, '-', d.authtypecode)
    ),
    'No',
    'Yes'
  ) LIKE <<"Thesaurus" match|ZYES_NO>>
  AND If(
    If(
      y.value_builder = '',
      '-',
      If(y.value_builder IS NULL, '-', y.value_builder)
    ) <> If(
      d.value_builder = '',
      '-',
      If(d.value_builder IS NULL, '-', d.value_builder)
    ),
    'No',
    'Yes'
  ) LIKE <<"Plugin" match|ZYES_NO>>
  AND If(
    If(
      y.seealso = '',
      '-',
      If(y.seealso IS NULL, '-', y.seealso)
    ) <> If(
      d.seealso = '',
      '-',
      If(d.seealso IS NULL, '-', d.seealso)
    ),
    'No',
    'Yes'
  ) LIKE <<"See also" match|ZYES_NO>>
  AND If(
    If(
      y.display_order = '',
      '-',
      If(y.display_order IS NULL, '-', y.display_order)
    ) <> If(
      d.display_order = '',
      '-',
      If(d.display_order IS NULL, '-', d.display_order)
    ),
    'No',
    'Yes'
  ) LIKE <<"Display order" match|ZYES_NO>>
ORDER BY y.CTRLX

























