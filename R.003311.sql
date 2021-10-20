/*
R.003311

----------

Name: GHW - ADMINREPORT - narrow holdsqueue
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-02-10 10:35:13
Modified on: 2020-02-10 14:27:31
Date last run: 2020-02-10 14:28:16

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>

<script>

$(window).on("load", function() {
  $("#printme").click(function () {
    var divToPrint = document.getElementById('report_results');
    newWin = window.open("");
    newWin.document.write(divToPrint.outerHTML);
    newWin.print();
    newWin.close();
  });
});

    function printDiv() {
        var divToPrint = document.getElementById('report_results');
        newWin = window.open("");
        newWin.document.write(divToPrint.outerHTML);
        newWin.print();
        newWin.close();
   }
</script>

<p>Generates a pick-list that can be easily printed on a receipt printer.</p>
<ul><li>Shows items currently on the holds report</li>
<li>at the library you specify</li>
<li>sorted in standard Next Search Catalog classification order</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><input type="button" id="printme" style="margin: 20px; padding: 5px;" value="Print this report"></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3311&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT Concat_Ws('<br />',
  '',
  items.barcode,
  '',
  items.homebranch,
  items.holdingbranch,
  locations.lib,
  itypes.description,
  ccodes.lib,
  items.itemcallnumber,
  items.copynumber,
  biblio.author,
  Concat_Ws('<br />',
    biblio.title,
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')
  )
) AS ITEMS_WITH_REQUESTS
FROM biblio
LEFT JOIN ((hold_fill_targets
            LEFT JOIN items ON hold_fill_targets.itemnumber = items.itemnumber)
           LEFT JOIN biblio_metadata ON items.biblionumber = biblio_metadata.biblionumber) ON biblio.biblionumber = biblio_metadata.biblionumber
LEFT JOIN
  (SELECT authorised_values.category,
          authorised_values.authorised_value,
          authorised_values.lib
   FROM authorised_values
   WHERE authorised_values.category = 'CCODE') ccodes ON ccodes.authorised_value = items.ccode
LEFT JOIN
  (SELECT authorised_values.category,
          authorised_values.authorised_value,
          authorised_values.lib
   FROM authorised_values
   WHERE authorised_values.category = 'LOC') locations ON locations.authorised_value = items.location
LEFT JOIN
  (SELECT itemtypes.itemtype,
          itemtypes.description
   FROM itemtypes) itypes ON itypes.itemtype = items.itype
WHERE items.homebranch Like <<Choose your library|branches>>
ORDER BY items.homebranch,
         items.holdingbranch,
         items.location,
         items.itype,
         items.ccode,
         items.itemcallnumber,
         items.copynumber,
         biblio.author,
         biblio.title

























