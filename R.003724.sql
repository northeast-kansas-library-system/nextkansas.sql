/*
R.003724

----------

Name: Compare framework tags
Created by: George H Williams

----------

Group: -
     -

Created on: 2023-04-17 10:22:01
Modified on: 2023-04-17 12:11:32
Date last run: 2023-05-12 09:35:37

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  Concat_Ws(
    ' - ',
    y.tagfield,
    concat(
      'Framework: ',
      if(y.frameworkcode = '', 'Default', y.frameworkcode)
    )
  ) AS CODE_1,
  Concat_Ws(
    ' - ',
    d.tagfield,
    concat(
      'Framework: ',
      if(d.frameworkcode = '', 'Default', d.frameworkcode)
    )
  ) AS CODE_2,
  y.liblibrarian AS STAFF_LABEL_1,
  d.liblibrarian AS STAFF_LABEL_2,
  If(y.liblibrarian = d.liblibrarian, 'Yes', 'No') AS STAFF_LABEL_MATCH,
  y.libopac AS OPAC_LABEL_1,
  d.libopac AS OPAC_LABEL_2,
  If(y.libopac = d.libopac, 'Yes', 'No') AS OPAC_LABEL_MATCH,
  y.repeatable AS REPEATABLE_1,
  d.repeatable AS REPEATABLE_2,
  If(y.repeatable = d.repeatable, 'Yes', 'No') AS REPEATABLE_MATCH,
  y.mandatory AS MANDATORY_1,
  d.mandatory AS MANDATORY_2,
  If(y.mandatory = d.mandatory, 'Yes', 'No') AS MANDATORY_MATCH,
  y.important AS IMPORTANT_1,
  d.important AS IMPORTANT_2,
  If(y.important = d.important, 'Yes', 'No') AS IMPORTANT_MATCH,
  y.authorised_value AS AUTHORIZED_VALUE_1,
  d.authorised_value AS AUTHORIZED_VALUE_2,
  If(
    y.authorised_value = d.authorised_value,
    'Yes',
    'No'
  ) AS AUTHORIZED_VALUE_MATCH,
  y.ind1_defaultvalue AS IND1_DEFAULT_1,
  d.ind1_defaultvalue AS IND1_DEFAULT_2,
  If(
    y.ind1_defaultvalue = d.ind1_defaultvalue,
    'Yes',
    'No'
  ) AS IND1_DEFAULT_MATCH,
  y.ind2_defaultvalue AS IND2_DEFAULT_1,
  d.ind2_defaultvalue AS IND2_DEFAULT_2,
  If(
    y.ind2_defaultvalue = d.ind2_defaultvalue,
    'Yes',
    'No'
  ) AS IND2_DEFAULT_MATCH
FROM (
    SELECT 
      marc_tag_structure.tagfield,
      marc_tag_structure.frameworkcode,
      marc_tag_structure.liblibrarian,
      marc_tag_structure.libopac,
      marc_tag_structure.repeatable,
      marc_tag_structure.mandatory,
      marc_tag_structure.important,
      marc_tag_structure.authorised_value,
      marc_tag_structure.ind1_defaultvalue,
      marc_tag_structure.ind2_defaultvalue
    FROM marc_tag_structure
    WHERE 
      IF(marc_tag_structure.frameworkcode = '', '-', marc_tag_structure.frameworkcode) LIKE <<Enter code for framework 1>>
  ) y
  LEFT JOIN (
    SELECT 
      marc_tag_structure.tagfield,
      marc_tag_structure.frameworkcode,
      marc_tag_structure.liblibrarian,
      marc_tag_structure.libopac,
      marc_tag_structure.repeatable,
      marc_tag_structure.mandatory,
      marc_tag_structure.important,
      marc_tag_structure.authorised_value,
      marc_tag_structure.ind1_defaultvalue,
      marc_tag_structure.ind2_defaultvalue
    FROM marc_tag_structure
    WHERE IF(marc_tag_structure.frameworkcode = '', '-', marc_tag_structure.frameworkcode) LIKE <<Enter code for framework 2>>
  ) d ON d.tagfield = y.tagfield
WHERE
  If(y.liblibrarian = d.liblibrarian, 'Yes', 'No') LIKE <<STAFF_LABEL_MATCH|ZYES_NO>> AND
  If(y.libopac = d.libopac, 'Yes', 'No') LIKE <<OPAC_LABEL_MATCH|ZYES_NO>> AND
  If(y.repeatable = d.repeatable, 'Yes', 'No') LIKE <<REPEATABLE_MATCH|ZYES_NO>> AND
  If(y.mandatory = d.mandatory, 'Yes', 'No') LIKE <<MANDATORY_MATCH|ZYES_NO>> AND
  If(y.important = d.important, 'Yes', 'No') LIKE <<IMPORTANT_MATCH|ZYES_NO>> AND
  If(
    
    IF(y.authorised_value is null, '-', IF(y.authorised_value = '', '-', y.authorised_value))
    
    = 
    
    IF(d.authorised_value is null, '-', IF(d.authorised_value = '', '-', d.authorised_value)),
    
    'Yes', 'No') LIKE <<AUTHORIZED_VALUE_MATCH|ZYES_NO>> AND
  If(y.ind1_defaultvalue = d.ind1_defaultvalue, 'Yes', 'No') LIKE <<IND1_DEFAULT_MATCH|ZYES_NO>> AND
  If(y.ind2_defaultvalue = d.ind2_defaultvalue, 'Yes', 'No') LIKE <<IND2_DEFAULT_MATCH|ZYES_NO>>
ORDER BY 
  CODE_1

























