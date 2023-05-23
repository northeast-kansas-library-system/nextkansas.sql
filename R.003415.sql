/*
R.003415

----------

Name: GHW - Flexible shelflist for specific item barcode numbers
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-02-01 10:32:30
Modified on: 2021-02-01 10:43:18
Date last run: 2023-05-22 19:28:00

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Generates a list of items on in the catalog by list of item barcode numbers</p>
<ul><li>Shows data regarding the supplied barcode numbers at the time the report was run</li>
<li>based on the home library of the item barcode numbers provided</li>
<li>grouped by item number, item type description, and collection code description</li>
<li>sorted by the normal Next Search Catalog classification scheme</li>
<li>links to the bibliographic record for each biblionumber and the edit item page for each item number</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>To run, ask nexthelp@nekls.org to set up the report for you -- you will need to supply a text file containing the barcode numbers of all of the items you wish to appear in the results</p>
<p>Currently set up for Kelly at PAOLA based on a list of 250 barcode numbers submitted on February 1, 2021.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3415&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">tag goes here</p>
</div>

----------
*/



SELECT
  Concat(
    '<a class= "clicked" href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
    items.biblionumber, 
    '\" target="_blank">', 
    items.biblionumber, 
    '</a>'
  ) AS LINK_TO_TITLE,
  items.biblionumber,
  items.itemnumber AS ITEM_NUMBER,
  Concat("-", Coalesce(items.barcode, "-"), "-") AS BARCODE,
  items.homebranch,
  items.holdingbranch,
  Coalesce(items.permanent_location, "-") AS PERMANENT_LOCATION,
  Coalesce(items.location, "-") AS LOCATION,
  Coalesce(itypes.description, "-") AS ITYPE,
  Coalesce(ccodes.lib, "-") AS CCODE,
  items.itemcallnumber,
  biblio.author,
  Concat_Ws(" ", 
    biblio.title, 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')
  ) AS FULL_TITLE,
  biblioitems.publicationyear,
  items.dateaccessioned,
  items.datelastborrowed,
  items.datelastseen,
  items.issues,
  items.renewals,
  Sum((Coalesce(items.issues, 0)) + (Coalesce(items.renewals, 0))) AS
  CHECKOUTS_PLUS_RENEWALS,
  If(items.onloan IS NULL, 'No', 'Yes') AS CHECKED_OUT,
  If(
    Sum(
      Coalesce(items.damaged, 0) + 
      Coalesce(items.itemlost, 0) +  
      Coalesce(items.withdrawn, 0)
    ) = 0, 
    'No', 
    'Yes'
  ) AS STATUS_PROBLEMS,
  If(notloan.authorised_value = 0, "-", notloan.lib) AS NOT_FOR_LOAN,
  items.itemnotes,
  items.itemnotes_nonpublic,
  items.copynumber,
  items.replacementprice,
  localcounts.Count_itemnumber AS LOCAL_COPIES,
  systemcounts.Count_itemnumber AS SYSTEM_COPIES,
  Concat(
    '<a class= "clicked" href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=', 
    items.biblionumber, 
    '&itemnumber=', 
    items.itemnumber, 
    '#edititem\" target="_blank">Edit item</a>'
  ) AS EDIT_ITEM
FROM
  items JOIN
  biblio ON items.biblionumber = biblio.biblionumber JOIN
  biblio_metadata ON items.biblionumber = biblio_metadata.biblionumber JOIN
  biblioitems ON items.biblioitemnumber = biblioitems.biblioitemnumber JOIN
  (SELECT
      items.biblionumber,
      items.homebranch,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    GROUP BY
      items.biblionumber,
      items.homebranch) localcounts ON items.biblionumber =
      localcounts.biblionumber AND
      items.homebranch = localcounts.homebranch JOIN
  (SELECT
      items.biblionumber,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    GROUP BY
      items.biblionumber) systemcounts ON items.biblionumber =
      systemcounts.biblionumber LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'NOT_LOAN'
    GROUP BY
      authorised_values.category,
      authorised_values.authorised_value) notloan ON notloan.authorised_value =
      items.notforloan LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'ccode') ccodes ON ccodes.authorised_value =
      items.ccode LEFT JOIN
  (SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes) itypes ON itypes.itemtype = items.itype
WHERE
  items.barcode = "0003047003668" OR
  items.barcode = "0003047003774" OR
  items.barcode = "0003047003667" OR
  items.barcode = "0003047008869" OR
  items.barcode = "0003047003765" OR
  items.barcode = "0003047003766" OR
  items.barcode = "0003047003775" OR
  items.barcode = "0003047003800" OR
  items.barcode = "0003047003788" OR
  items.barcode = "0003047003799" OR
  items.barcode = "0003047003794" OR
  items.barcode = "0003047003787" OR
  items.barcode = "0003047003791" OR
  items.barcode = "0003047003783" OR
  items.barcode = "0003047003784" OR
  items.barcode = "0003047003803" OR
  items.barcode = "0003047003801" OR
  items.barcode = "0003047003793" OR
  items.barcode = "0003047003786" OR
  items.barcode = "0003047003796" OR
  items.barcode = "0003047004917" OR
  items.barcode = "0003047004918" OR
  items.barcode = "0003047004919" OR
  items.barcode = "0003047004922" OR
  items.barcode = "0003047004926" OR
  items.barcode = "0003047004127" OR
  items.barcode = "0003047004128" OR
  items.barcode = "0003047004129" OR
  items.barcode = "0003047004146" OR
  items.barcode = "0003047005776" OR
  items.barcode = "0003047005777" OR
  items.barcode = "0003047005778" OR
  items.barcode = "0003047005779" OR
  items.barcode = "0003047005137" OR
  items.barcode = "0003047005141" OR
  items.barcode = "0003047005780" OR
  items.barcode = "0003047005133" OR
  items.barcode = "0003047005886" OR
  items.barcode = "0003047030005" OR
  items.barcode = "0003047008918" OR
  items.barcode = "0003047008914" OR
  items.barcode = "0003047008926" OR
  items.barcode = "0003047009083" OR
  items.barcode = "0003047030013" OR
  items.barcode = "0003047009099" OR
  items.barcode = "0003047009288" OR
  items.barcode = "0003047009095" OR
  items.barcode = "0003047009466" OR
  items.barcode = "0003047009478" OR
  items.barcode = "0003047009481" OR
  items.barcode = "0003047009474" OR
  items.barcode = "0003047009438" OR
  items.barcode = "0003047009470" OR
  items.barcode = "0003047009064" OR
  items.barcode = "0003047009284" OR
  items.barcode = "0003047009056" OR
  items.barcode = "0003047009280" OR
  items.barcode = "0003047009060" OR
  items.barcode = "0003047009222" OR
  items.barcode = "0003047009218" OR
  items.barcode = "0003047009226" OR
  items.barcode = "0003047005713" OR
  items.barcode = "0003047005625" OR
  items.barcode = "0003047006004" OR
  items.barcode = "0003047006007" OR
  items.barcode = "0003047006006" OR
  items.barcode = "0003047005830" OR
  items.barcode = "0003047006031" OR
  items.barcode = "0003047006076" OR
  items.barcode = "0003047006068" OR
  items.barcode = "0003047006035" OR
  items.barcode = "0003047005611" OR
  items.barcode = "0003047005612" OR
  items.barcode = "0003047005615" OR
  items.barcode = "0003047005614" OR
  items.barcode = "0003047005613" OR
  items.barcode = "0003047005626" OR
  items.barcode = "0003047003266" OR
  items.barcode = "0003047000763" OR
  items.barcode = "0003047002408" OR
  items.barcode = "0003047000788" OR
  items.barcode = "0003047005657" OR
  items.barcode = "0003047005661" OR
  items.barcode = "0003047005796" OR
  items.barcode = "0003047005877" OR
  items.barcode = "0003047005792" OR
  items.barcode = "0003047004823" OR
  items.barcode = "0003047004843" OR
  items.barcode = "0003047004835" OR
  items.barcode = "0003047003720" OR
  items.barcode = "0003047004400" OR
  items.barcode = "0003047004533" OR
  items.barcode = "0003047004596" OR
  items.barcode = "0003047005447" OR
  items.barcode = "0003047005454" OR
  items.barcode = "0003047005455" OR
  items.barcode = "0003047005473" OR
  items.barcode = "0003047005488" OR
  items.barcode = "0003047005489" OR
  items.barcode = "0003047005510" OR
  items.barcode = "0003047007275" OR
  items.barcode = "0003047007317" OR
  items.barcode = "0003047008828" OR
  items.barcode = "0003047008827" OR
  items.barcode = "0003047008826" OR
  items.barcode = "0003047008829" OR
  items.barcode = "0003047008830" OR
  items.barcode = "0003047008832" OR
  items.barcode = "0003047008831" OR
  items.barcode = "0003047003309" OR
  items.barcode = "0003047003298" OR
  items.barcode = "0003047003302" OR
  items.barcode = "0003047009111" OR
  items.barcode = "0003047009165" OR
  items.barcode = "0003047009181" OR
  items.barcode = "0003047009359" OR
  items.barcode = "0003047009358" OR
  items.barcode = "0003047009366" OR
  items.barcode = "0003047009362" OR
  items.barcode = "0003047009347" OR
  items.barcode = "0003047010509" OR
  items.barcode = "0003047009355" OR
  items.barcode = "0003047009351" OR
  items.barcode = "0003047009370" OR
  items.barcode = "0003047009374" OR
  items.barcode = "0003047009386" OR
  items.barcode = "0003047009378" OR
  items.barcode = "0003047009382" OR
  items.barcode = "0003047009343" OR
  items.barcode = "0003047009130" OR
  items.barcode = "0003047009131" OR
  items.barcode = "0003047009133" OR
  items.barcode = "0003047009304" OR
  items.barcode = "0003047009581" OR
  items.barcode = "0003047009583" OR
  items.barcode = "0003047009586" OR
  items.barcode = "0003047009584" OR
  items.barcode = "0003047001801" OR
  items.barcode = "0003047009448" OR
  items.barcode = "0003047009483" OR
  items.barcode = "0003047009467" OR
  items.barcode = "0003047009471" OR
  items.barcode = "0003047009479" OR
  items.barcode = "0003047009440" OR
  items.barcode = "0003047009543" OR
  items.barcode = "0003047009539" OR
  items.barcode = "0003047009685" OR
  items.barcode = "0003047009704" OR
  items.barcode = "0003047009705" OR
  items.barcode = "0003047009703" OR
  items.barcode = "0003047009709" OR
  items.barcode = "0003047009711" OR
  items.barcode = "0003047009715" OR
  items.barcode = "0003047009708" OR
  items.barcode = "0003047009717" OR
  items.barcode = "0003047009718" OR
  items.barcode = "0003047009747" OR
  items.barcode = "0003047009760" OR
  items.barcode = "0003047009895" OR
  items.barcode = "0003047009898" OR
  items.barcode = "0003047009900" OR
  items.barcode = "0003047009896" OR
  items.barcode = "0003047009902" OR
  items.barcode = "0003047009903" OR
  items.barcode = "0003047009906" OR
  items.barcode = "0003047009892" OR
  items.barcode = "0003047009904" OR
  items.barcode = "0003047009899" OR
  items.barcode = "0003047009907" OR
  items.barcode = "0003047009911" OR
  items.barcode = "0003047009912" OR
  items.barcode = "0003047009986" OR
  items.barcode = "0003047003357" OR
  items.barcode = "0003047003353" OR
  items.barcode = "0003047003292" OR
  items.barcode = "0003047009521" OR
  items.barcode = "0003047009510" OR
  items.barcode = "0003047009494" OR
  items.barcode = "0003047009745" OR
  items.barcode = "0003047009506" OR
  items.barcode = "0003047004034" OR
  items.barcode = "0003047001089" OR
  items.barcode = "0003047009649" OR
  items.barcode = "0003047000862" OR
  items.barcode = "0003047010256" OR
  items.barcode = "0003047010262" OR
  items.barcode = "0003047010638" OR
  items.barcode = "0003047010669" OR
  items.barcode = "0003047007056" OR
  items.barcode = "0003047007046" OR
  items.barcode = "0003047000868" OR
  items.barcode = "0003047001956" OR
  items.barcode = "0003047001957" OR
  items.barcode = "0003047002062" OR
  items.barcode = "0003047031007" OR
  items.barcode = "0003047031920" OR
  items.barcode = "0003047001944" OR
  items.barcode = "0003047034873" OR
  items.barcode = "0003047001988" OR
  items.barcode = "0003047002023" OR
  items.barcode = "0003047007456" OR
  items.barcode = "0003047024778" OR
  items.barcode = "0003047014040" OR
  items.barcode = "0003047014050" OR
  items.barcode = "0003047014067" OR
  items.barcode = "0003047014142" OR
  items.barcode = "0003047014973" OR
  items.barcode = "0003047014993" OR
  items.barcode = "0003047014999" OR
  items.barcode = "0003047015000" OR
  items.barcode = "0003047015097" OR
  items.barcode = "0003047015096" OR
  items.barcode = "0003047015165" OR
  items.barcode = "0003047015166" OR
  items.barcode = "0003047015364" OR
  items.barcode = "0003047015360" OR
  items.barcode = "0003047015437" OR
  items.barcode = "0003047015450" OR
  items.barcode = "0003047016945" OR
  items.barcode = "0003047016897" OR
  items.barcode = "0003047016894" OR
  items.barcode = "0003047016895" OR
  items.barcode = "0003047017277" OR
  items.barcode = "0003047017261" OR
  items.barcode = "0003047020658" OR
  items.barcode = "0003047017427" OR
  items.barcode = "0003047026475" OR
  items.barcode = "0003047026435" OR
  items.barcode = "0003047026985" OR
  items.barcode = "0003047027149" OR
  items.barcode = "0003047027249" OR
  items.barcode = "0003047027253" OR
  items.barcode = "0003047027385" OR
  items.barcode = "0003047027397" OR
  items.barcode = "0003047027342" OR
  items.barcode = "0003047027321" OR
  items.barcode = "0003047027322" OR
  items.barcode = "0003047027338" OR
  items.barcode = "0003047028524" OR
  items.barcode = "0003047028390" OR
  items.barcode = "0003047028289" OR
  items.barcode = "0003047028382" OR
  items.barcode = "0003047027382" OR
  items.barcode = "0003047027399" OR
  items.barcode = "0003047027467" OR
  items.barcode = "0003047027956" OR
  items.barcode = "0003047006296" OR
  items.barcode = "0003047006083" OR
  items.barcode = "0003047006084" OR
  items.barcode = "0003047028520" 
GROUP BY
  items.itemnumber,
  itypes.description,
  ccodes.lib
ORDER BY
  items.homebranch,
  LOCATION,
  ITYPE,
  CCODE,
  items.itemcallnumber,
  biblio.author,
  biblio.title

























