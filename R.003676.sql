/*
R.003676

----------

Name: GHW - Backup - Label layouts and templates
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-11-07 17:26:57
Modified on: 2022-12-14 16:27:15
Date last run: 2022-12-14 16:27:18

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
  <p>Outputs label layout and template data to a spreadsheet as a backup</p>
  <ul>
    <li>Outputs current label data as of the time the report is run</li>
    <li>for all Next libraries</li>
    <li>grouped by creator_layouts.layout_id and creator_templates.template_id</li>
    <li>sorted by file name</li>
  </ul><br />
  <p></p>
  <p class= "notetags" style="display: none;">#backup</p>
  <!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes -->
</div>

----------
*/



SELECT
  Concat(
    'PL.',
    LPAD(creator_layouts.layout_id, 6,0)
  ) as FILE_NAME,
  Concat_WS(
    Concat(CHAR(13), CHAR(10), CHAR(13), CHAR(10)),
    Concat(
      'LayoutID: ',
      creator_layouts.layout_id
    ),
    Concat(
      'Layout name: ', 
      creator_layouts.layout_name
    ),
    Concat(
      'Choose barcode type (encoding): ', 
      IF(
        creator_layouts.barcode_type = 'CODE39',
        'Code 39',
        IF(
          creator_layouts.barcode_type = 'CODE39MOD',
          'Code 39 + Modulo43',
          IF(
            creator_layouts.barcode_type = 'CODE39MOD10',
            'Code 39 + Modulo10',
            IF(
              creator_layouts.barcode_type = 'COOP2OF5',
              'COOP2of5',
              IF(
                creator_layouts.barcode_type = 'EAN13',
                'EAN13',
                IF(
                  creator_layouts.barcode_type = 'INDUSTRIAL2OF5',
                  'Industrial2of5',
                  '/X/'
                )
              )
            )
          )
        )
      )
    ),
    Concat(
      'Choose layout type: ', 
      IF(
        creator_layouts.printing_type = 'BIB',
        'Only the bibliographic data is printed',
        IF(
          creator_layouts.printing_type = 'BARBIB',
          'Barcode precedes bibliographic data',
          IF(
            creator_layouts.printing_type = 'BIBBAR',
            'Bibliographic data precedes barcode',
            IF(
              creator_layouts.printing_type = 'ALT',
              'Barcode and bibliographic data are printed on alternating labels',
              IF(
                creator_layouts.printing_type = 'BAR',
                'Only the barcode is printed',
                '/X/'
              )
            )
          )
        )
      )
    ),
    Concat('Bibliographic data to print (list fields): ', creator_layouts.format_string),
    Concat(
      'Draw guide boxes: ', 
      IF(
        creator_layouts.guidebox = 1,
        'Yes',
        'No'
      )
    ),
    Concat(
      'Split call numbers: ', 
      IF(
        creator_layouts.callnum_split = 1,
        'Yes',
        'No'
      )
    ),
    Concat(
      'Text justification: ', 
      IF(
        creator_layouts.text_justify = 'L',
        'Left',
        IF(
          creator_layouts.text_justify = 'C',
          'Center',
          IF(
            creator_layouts.text_justify = 'R',
            'Right',
            '/X/'
          )
        )
      )
    ),
    Concat(
      'Font: ', 
      IF(
        creator_layouts.font = 'TR',
        'Times-Roman',
        IF(
          creator_layouts.font = 'TB',
          'Times-Bold',
          IF(
            creator_layouts.font = 'TI',
            'Times-Italic',
            IF(
              creator_layouts.font = 'TBI',
              'Times-Bold-Italic',
              IF(
                creator_layouts.font = 'C',
                'Courier',
                IF(
                  creator_layouts.font = 'CB',
                  'Courier-Bold',
                  IF(
                    creator_layouts.font = 'CO',
                    'Courier-Oblique',
                    IF(
                      creator_layouts.font = 'CBO',
                      'Courier-Bold-Oblique',
                      IF(
                        creator_layouts.font = 'H',
                        'Helvetica',
                        IF(
                          creator_layouts.font = 'HO',
                          'Helvetica-Oblique',
                          IF(
                            creator_layouts.font = 'HB',
                            'Helvetica-Bold',
                            IF(
                              creator_layouts.font = 'HBO',
                              'Helvetica-Bold-Oblique',
                              '/X/'
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
    ),
    Concat('Font size: ', creator_layouts.font_size),
    Concat(
      'Oblique title: ', 
      IF(
        creator_layouts.oblique_title = 1,
        'Yes',
        'No'
      )
    )
  ) AS PRINT_LAYOUT
FROM
  creator_layouts
WHERE
  creator_layouts.creator = 'Labels'
GROUP BY
  creator_layouts.layout_id
UNION
SELECT
  Concat('PT.', LPad(creator_templates.template_id, 6, 0)) AS FILE_NAME,
  Concat_WS(
    Concat(CHAR(13), CHAR(10), CHAR(13), CHAR(10)),
    Concat('Template ID: ', creator_templates.template_id),
    Concat('Template Code: ', creator_templates.template_code),
    Concat('Template Description: ', creator_templates.template_desc),
    Concat(
      'Units: ', 
      IF(
        creator_templates.units = 'POINT',
        'PostScript points',
        IF(
          creator_templates.units = 'AGATE',
          'Agates',
          IF(
            creator_templates.units = 'INCH',
            'US Inches',
            IF(
              creator_templates.units = 'MM',
              'SI Millimeters',
              IF(
                creator_templates.units = 'CM',
                'SI Centimeters',
                'X'
              )
            )
          )
        )
      )
    ),
    Concat('Page height: ', creator_templates.page_height),
    Concat('Page width: ', creator_templates.page_width),
    Concat('Label width: ', creator_templates.label_width),
    Concat('Label height: ', creator_templates.label_height),
    Concat('Top page margin: ', creator_templates.top_margin),
    Concat('Left page margin: ', creator_templates.left_margin),
    Concat('Top text margin: ', creator_templates.top_text_margin),
    Concat('Left text margin: ', creator_templates.left_text_margin),
    Concat('Number of columns: ', creator_templates.cols),
    Concat('Number of rows: ', creator_templates.`rows`),
    Concat('Gap between columns: ', creator_templates.col_gap),
    Concat('Gap between rows: ', creator_templates.row_gap),
    Concat('Profile: ', printers_profile.printer_name)
  ) AS PRINT_TEMPLATE
FROM
  creator_templates LEFT JOIN
  printers_profile ON printers_profile.profile_id = creator_templates.profile_id
WHERE
  creator_templates.creator = 'Labels'
GROUP BY
  creator_templates.template_id
ORDER BY FILE_NAME ASC

























