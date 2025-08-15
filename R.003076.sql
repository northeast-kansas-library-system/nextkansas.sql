/*
R.003076

----------

Name: GHW - e-mail checkout receipt
Created by: George Williams

----------

Group: -
     -

Created on: 2018-04-19 09:08:58
Modified on: 2024-01-17 12:11:27
Date last run: 2021-02-12 15:16:34

----------

Public: 0
Expiry: 300

----------



 
Creates a digital receipt that can be copied and pasted into a form for easy mailing to a patron's e-mail address
WHEN
Whose Stuff
grouped by
sorted by
links

Notes:



Click here to run in a new window


----------
*/



SELECT
  Concat_Ws(
    "",
    Concat("Due on: ", Date_Format(issues.date_due, '%m/%d/%Y')),
    Concat("Call number: ", items.itemcallnumber),
    Concat("Author / Title: ", If(biblio.author IS NULL, "", Concat(biblio.author, " / ")), Upper(biblio.title)),
    Concat("Barcode: ", items.barcode),
    Concat("Checked out at: ", branches.branchname),
    "--------------------------------------------------------------------------------"
  ) AS DIGITAL_RECIEPT
FROM
  biblio
  JOIN items ON items.biblionumber = biblio.biblionumber
  LEFT JOIN (SELECT
        authorised_values.authorised_value,
        authorised_values.lib,
        authorised_values.category
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'CCODE') ccodes ON items.ccode = ccodes.authorised_value
  LEFT JOIN (SELECT
        itemtypes.itemtype,
        itemtypes.description
      FROM
        itemtypes) itypes ON items.itype = itypes.itemtype
  LEFT JOIN (SELECT
        authorised_values.authorised_value,
        authorised_values.lib,
        authorised_values.category
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'LOC') locations ON items.location = locations.authorised_value
  JOIN issues ON issues.itemnumber = items.itemnumber
  JOIN branches ON issues.branchcode = branches.branchcode
  JOIN borrowers ON issues.borrowernumber = borrowers.borrowernumber
WHERE
  issues.borrowernumber = &lt;&gt;
GROUP BY
  items.biblionumber,
  issues.borrowernumber
ORDER BY
  issues.date_due ASC
LIMIT 1000

























