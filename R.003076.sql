/*
R.003076

----------

Name: GHW - e-mail checkout receipt
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-04-19 09:08:58
Modified on: 2018-04-25 16:19:04
Date last run: 2021-02-12 15:16:34

----------

Public: 0
Expiry: 300

----------

<script>

  $(window).on("load", function() {

    $("#rep_guided_reports_start #yui-main table").attr("id","receipttable");

    $("#rep_guided_reports_start td .hideme").hide();

      $("#digireciept").click(function () {
        var el = document.getElementById("receipttable");
        var range = document.createRange();
        range.selectNodeContents(el);
        var sel = window.getSelection();
        sel.removeAllRanges();
        sel.addRange(range);
        document.execCommand('copy');
        window.open("http://news.nexpresslibrary.org/one-time-digital-receipt/", "_blank"); 
      });

});

</script>

<div id="reportinfo" class="hideme">
<p>Creates a digital receipt that can be copied and pasted into a form for easy mailing to a patron's e-mail address</p>
<ul><li>WHEN</li>
<li>Whose Stuff</li>
<li>grouped by</li>
<li>sorted by</li>
<li>links</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><input type="button" id="digireciept" style="margin: 20px; padding: 5px;" value="One time e-mail receipt step 2"></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3076&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  Concat_Ws(
    "<br />",
    Concat("<br />Due on: ", Date_Format(issues.date_due, '%m/%d/%Y')),
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
  issues.borrowernumber = <<Enter borrower ID number>>
GROUP BY
  items.biblionumber,
  issues.borrowernumber
ORDER BY
  issues.date_due ASC
LIMIT 1000

























