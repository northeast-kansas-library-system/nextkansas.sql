# nexpress-SQL
Next Kansas SQL

This is a repostitory for all of the SQL used by the Next Search Catalog library consortium reports.

-----

Instructions:

Run report 3047 and save as a spreadsheet.

The SQL for this report is:

```SQL

SELECT
  Concat(If(Length(saved_sql.savedsql) > 32766, "X.", "R."), LPad(saved_sql.id, 6, 0)) AS FILE_NAME,
  Concat(
    Concat("/*", Char(13), Char(10), "R.", LPad(saved_sql.id, 6, 0)), Char(13), Char(10), Char(13), Char(10),
    Concat("----------"), Char(13), Char(10), Char(13), Char(10),
    Concat("Name: ", Coalesce(saved_sql.report_name, "-")), Char(13), Char(10),
    Concat("Created by: ", If(Coalesce(borrowers.borrowernumber, 0) = 0, "-", Concat(borrowers.firstname, " ", borrowers.surname))), Char(13), Char(10), Char(13), Char(10),
    Concat("----------"), Char(13), Char(10), Char(13), Char(10),
    Concat("Group: ", Coalesce(reportgroups.lib, "-")), Char(13), Char(10),
    Concat("     ", Coalesce(reportsubgroups.lib, "-")), Char(13), Char(10), Char(13), Char(10),
    Concat("Created on: ", Coalesce(saved_sql.date_created, "-")), Char(13), Char(10),
    Concat("Modified on: ", Coalesce(saved_sql.last_modified, "-")), Char(13), Char(10),
    Concat("Date last run: ", Coalesce(saved_sql.last_run, "-")), Char(13), Char(10), Char(13), Char(10),
    Concat("----------"), Char(13), Char(10), Char(13), Char(10),
    Concat("Public: ", Coalesce(saved_sql.public, "-")), Char(13), Char(10),
    Concat("Expiry: ", Coalesce(saved_sql.cache_expiry, "-")), Char(13), Char(10), Char(13), Char(10),
    Concat("----------"), Char(13), Char(10), Char(13), Char(10),
    Concat(Coalesce(saved_sql.notes, "-")), Char(13), Char(10), Char(13), Char(10),
    Concat("----------", Char(13), Char(10), "*/"), Char(13), Char(10), Char(13), Char(10),
    Concat(IF(Length(saved_sql.savedsql) > 32766, "Too large to process", saved_sql.savedsql)), Char(13), Char(10), Char(13), Char(10)
  ) AS CONTENTS
FROM
  saved_sql
  LEFT JOIN borrowers ON saved_sql.borrowernumber = borrowers.borrowernumber
  LEFT JOIN (SELECT
        authorised_values.id,
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib,
        authorised_values.imageurl,
        authorised_values.lib_opac
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'REPORT_GROUP') reportgroups ON
    saved_sql.report_group = reportgroups.authorised_value
  LEFT JOIN (SELECT
        authorised_values.id,
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib,
        authorised_values.imageurl,
        authorised_values.lib_opac
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'REPORT_SUBGROUP') reportsubgroups ON saved_sql.report_subgroup =
    reportsubgroups.authorised_value
GROUP BY
  saved_sql.id
ORDER BY
  FILE_NAME
```

----------

Make sure you have a folder on your local computer called C:\git\ and that it is empty.

Open the csv file and run the following VBA macro:

```

Sub WriteToSQL()

Const forReading = 1, forAppending = 3, fsoForWriting = 2
Dim fs, objTextStream, sText As String
Dim lLastRow As Long, lRowLoop As Long, lLastCol As Long, lColLoop As Long

lLastRow = Cells(Rows.Count, 1).End(xlUp).Row

For lRowLoop = 1 To lLastRow

    Set fs = CreateObject("Scripting.FileSystemObject")
    Set objTextStream = fs.opentextfile("c:\git\" & Cells(lRowLoop, 1) & ".sql", fsoForWriting, True)

    sText = ""

    For lColLoop = 2 To 2
        sText = sText & Cells(lRowLoop, lColLoop) & Chr(10) & Chr(10)
    Next lColLoop

    objTextStream.writeline (Left(sText, Len(sText) - 1))


    objTextStream.Close
    Set objTextStream = Nothing
    Set fs = Nothing

Next lRowLoop

End Sub

```

----------

This should give you 1 .sql file for each row in the report.  Each text file represents 1 SQL report from Koha with all of the notes, titles, comments, etc. commented out so that you can run the report from Emacs or Atom if you have the right plugin enabled and a working ODBC connection (reports with runtime parameters will not run from Emacs or Atom without modification).

Save all of these files into the github folder for your repository.

----------

Optional -- I have my repository set up with Github Pages so that I can navigate to /myaccount.github.io/repositoryname/report_index.html and see a table with name and comments for each report.  To add report_index.html to your repository:

Run report 3050 but do not save it as a spreadsheet.  Instead, expand the report to show all results on the screen at once.  Then right click the page and view the source.  Copy all of the data from the results table - from the first <table> tag to the final </table> tag in the page source and paste it into report_index.html in an html file called report_index.html.

The SQL for this report is:

----------

```SQL

SELECT
  Concat(
    LPad(saved_sql.id, 5, 0),
    "<br /><br />",
    Coalesce(saved_sql.report_name, "-"),
    "<br /><br />",
    Concat(Coalesce(groups.lib, "-"),
    "<br />",
    Coalesce(subgroups.lib, "-")),
    "<br /><br />",
    Concat("Created by:<br />", If(borrowers.borrowernumber IS NULL, "-", Concat(borrowers.firstname, " ", borrowers.surname)))
  ) AS NAME,
  Coalesce(saved_sql.notes, "-") AS NOTES
FROM
  saved_sql
  LEFT JOIN borrowers ON saved_sql.borrowernumber = borrowers.borrowernumber
  LEFT JOIN (SELECT
        authorised_values.id,
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib,
        authorised_values.imageurl,
        authorised_values.lib_opac
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'REPORT_GROUP') groups ON saved_sql.report_group = groups.authorised_value
  LEFT JOIN (SELECT
        authorised_values.id,
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib,
        authorised_values.imageurl,
        authorised_values.lib_opac
      FROM
        authorised_values) subgroups ON saved_sql.report_subgroup = subgroups.authorised_value
GROUP BY
  saved_sql.id
ORDER BY
  saved_sql.id
LIMIT 10000
```

----------

Once all files are saved in the github folder, update your repository.
