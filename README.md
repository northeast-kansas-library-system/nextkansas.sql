# nexpress-SQL
Next Kansas SQL

This is a repostitory for all of the SQL used by the Next Search Catalog library consortium reports.

-----

Instructions:

Run report 3047 and save as a spreadsheet.

The SQL for this report is:

```SQL

SELECT
  Concat("R.", LPad(saved_sql.id, 6, 0)) AS FILE_NAME,
  Concat(
    Concat("R.", LPad(saved_sql.id, 6, 0)), Char(13), Char(10), Char(13), Char(10),
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
    Concat("----------"), Char(13), Char(10), Char(13), Char(10),
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
  saved_sql.id
```

----------

Make sure you have a folder on your local computer called C:\git\ and that it is empty.

Open the csv file and run the macro from the XLSX macro file.

The VBA for the macro is:

```

Sub WriteTotxtSQL()

Const forReading = 1, forAppending = 3, fsoForWriting = 2
Dim fs, objTextStream, sText As String
Dim lLastRow As Long, lRowLoop As Long, lLastCol As Long, lColLoop As Long

lLastRow = Cells(Rows.Count, 1).End(xlUp).Row

For lRowLoop = 1 To lLastRow

    Set fs = CreateObject("Scripting.FileSystemObject")
    Set objTextStream = fs.opentextfile("c:\git\" & Cells(lRowLoop, 1) & ".txt", fsoForWriting, True)

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

This should give you 1 text file for each row in the report.  Each text file represents 1 SQL report from Koha.

Save all of these files into the github folder.

----------

Once all files are saved in the github folder, use Git or Atom to sync with the online repository.
