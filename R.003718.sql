/*
R.003718

----------

Name: GHW - Courier fire report
Created by: George H Williams

----------

Group: -
     -

Created on: 2023-03-13 10:46:38
Modified on: 2023-03-15 09:43:51
Date last run: 2023-05-16 16:37:09

----------

Public: 0
Expiry: 300

----------

<div id="reportinfo" class="noprint reportInfo"> 
 
  <div> 
 
    <p>On March 9 and 10, 2023, there was a fire at the warehouse complex in Topeka where Henry Industries has their Topeka shipping center.  It is very likely that any library materials that were in the shipping center were destroyed or damaged beyond repair.  This report hopes to identify items that may have been at the shipping center during the time that the fire took place.</p> 
 
    <ul> 
      <li>Items that were in-transit between March 3 and March 10, 2023</li> 
      <li>Either en-route to or en route from a library on the Topeka courier hub.</li> 
      <li>grouped by biblio number and item number</li> 
      <li>sorted by item home library</li> 
      <li>links to the bibliographic record for the item</li> 
    </ul> 
 
    <p> 
      <ins>Notes:</ins> 
    </p> 
 
    <p> 

    </p> 
 
    <p> 
      We recommend running this report for your library and checking the shelves during the week of March 19-25 to see if any items still on this list have been found. 
    </p> 
 
    <p> 
 
    </p> 
 
  </div> 
 
  <div id="reportInfoLinks"> 
 
    <p class="notetags" style="display: none;"> 
      #CourierFire2023
    </p> 
 
    <!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --> 
 
  </div> 
 
</div> 

----------
*/



SELECT 
  Concat( 
    '<a class="btn btn-default btn-xs noprint"', 
    'href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
    item_info.biblionumber, 
    '\" target="_blank">BIBLIO</a>' 
  ) AS 'LINK', 
  item_info.HOME_LIBRARY, 
  item_info.branchname AS CURRENTLY_AT, 
  item_info.LOCATION, 
  item_info.ITYPE, 
  item_info.CCODE, 
  item_info.CALL_NUMBER, 
  item_info.author, 
  item_info.TITLE, 
  item_info.datelastseen, 
  item_info.barcode1, 
  item_info.replacementprice,
  item_info.homebranch AS OWNED_BY, 
  frombranches.branchname AS SENT_FROM, 
  branchtransfers.datesent AS SENT_DATE, 
  tobranches.branchname AS SENT_TO, 
  branchtransfers.reason AS TRANSFER_REASON, 
  Concat_WS('', 
    '<a class="btn btn-default btn-xs noprint" ', 
    'href="mailto:', 
    item_info.branchemail, 
    '?subject=Missing&nbsp;in&nbsp;transit&nbsp;', 
    branchtransfers.branchtransfer_id, 
    '%20&#40;Possible%20loss%20in%20Topeka%20fire&#41;'
    '&amp;cc=', 
    frombranches.branchemail, 
    ';', 
    tobranches.branchemail, 
    '&body=An%20item%20owned%20by%20&#42;&#42;', 
    item_info.HOME_LIBRARY, 
    '&#42;&#42;%20was%20shipped%20from%20&#42;&#42;', 
    frombranches.branchname, 
    '&#42;&#42;%20to%20&#42;&#42;', 
    tobranches.branchname, 
    '&#42;&#42;%20on%20', 
    branchtransfers.datesent, 
    '%20and%20the%20item%20has%20not%20yet%20arrived.', 
    '%0D%0A%0D%0A', 
    'The%20details%20are%20as%20follow%3A', 
    '%0D%0A%0D%0A', 
    'Branch%20transfer%20ID%3A%20', 
    branchtransfers.branchtransfer_id, 
    '%0D%0A%0D%0A', 
    'Home%20library%3A%20', 
    item_info.HOME_LIBRARY, 
    '%0D%0ALocation%3A%20', 
    item_info.LOCATION, 
    '%0D%0AItem%20type%3A%20', 
    item_info.ITYPE, 
    '%0D%0ACollection%20code%3A%20', 
    item_info.CCODE, 
    '%0D%0ACall%20number%3A%20', 
    item_info.CALL_NUMBER, 
    '%0D%0AAuthor%3A%20', 
    item_info.author, 
    '%0D%0ATitle%3A%20', 
    UPPER(item_info.TITLE), 
    '%0D%0ABarcode%20number%3A%20', 
    item_info.barcode, 
    '%0D%0A%0D%0A', 
    'Sent%20from%3A%20', 
    frombranches.branchname, 
    '%0D%0ASent%20to%3A%20', 
    tobranches.branchname, 
    '%0D%0ASent%20on%3A%20', 
    branchtransfers.datesent, 
    '%0D%0A%0D%0A', 
    'Transfer%20reason%3A%20', 
    branchtransfers.reason, 
    '%20%0D%0A%0D%0A', 
    'Could%20you%20please%20check%20the%20shelves%20at%20your%20library%20', 
    '&#40;including%20the%20hold%20shelf&#41;%20', 
    'and%20check%20this%20item%20in%20if%20you%20find%20it&#63;%20%20', 
    '%0D%0A%0D%0A', 
    'It%20is%20possible%20that%20this%20item%20was%20at%20the%20', 
    'Henry%20Industries%20Topeka%20shipping%20center%20', 
    'at%20the%20time%20of%20the%20fire%20on%20March%209%20and%20', 
    'may%20have%20been%20destroyed%20in%20that%20fire&#46;%20%20', 
    'We%20need%20to%20confirm%20that%20it%20cannot%20be%20found%20', 
    'in%20order%20to%20proceed%20with%20an%20insurance%20claim&#46;%20', 
    '%0D%0A%0D%0A', 
    'Thank you,', 
    '%20%0D%0A%0D%0A', 
    '">Send e-mail</a>' 
  ) AS MAILTO_LINK, 
  @SortOrder := '1' AS SORTING 
FROM 
  branchtransfers JOIN 
  branches frombranches ON branchtransfers.frombranch = frombranches.branchcode JOIN 
  branches tobranches ON branchtransfers.tobranch = tobranches.branchcode JOIN 
  (SELECT 
    items.biblionumber, 
    items.itemnumber, 
    items.barcode, 
    items.replacementprice,
    home.branchname AS HOME_LIBRARY, 
    holding.branchname, 
    perm_locs.lib AS PERM_LOCATION, 
    Concat_Ws('', 
      perm_locs.lib, 
      If(locs.lib = 'Recently returned', ' (Recently returned)', '') 
    ) AS LOCATION, 
    itemtypes.description AS ITYPE, 
    ccodes.lib AS CCODE, 
    items.itemcallnumber, 
    Concat_Ws('', 
      items.itemcallnumber, 
      If(items.copynumber IS NULL, '', Concat(' (Copy number: ', items.copynumber, ')')) 
    ) AS CALL_NUMBER, 
    biblio.author, 
    Concat_Ws(' ', biblio.title, biblio.medium, biblio.subtitle, 
    biblioitems.number, biblio.part_name) AS TITLE, 
    items.datelastseen, 
    items.copynumber, 
    Concat('-', items.barcode, '-') AS barcode1, 
    items.homebranch, 
    home.branchemail 
  FROM 
    items JOIN 
    biblio ON items.biblionumber = biblio.biblionumber JOIN 
    biblioitems ON biblioitems.biblionumber = biblio.biblionumber LEFT JOIN 
    (SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib, 
      authorised_values.lib_opac 
    FROM 
      authorised_values 
    WHERE 
      authorised_values.category = 'LOC' 
    ) 
    perm_locs ON perm_locs.authorised_value = items.permanent_location LEFT JOIN 
    (SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib, 
      authorised_values.lib_opac 
    FROM 
      authorised_values 
    WHERE 
      authorised_values.category = 'LOC' 
    ) locs ON locs.authorised_value = items.location LEFT JOIN 
    itemtypes ON itemtypes.itemtype = items.itype LEFT JOIN 
    (SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib, 
      authorised_values.lib_opac 
    FROM 
      authorised_values 
    WHERE 
      authorised_values.category = 'CCODE' 
    ) 
    ccodes ON 
    ccodes.authorised_value = items.ccode LEFT JOIN 
    branches home ON home.branchcode = items.homebranch LEFT JOIN 
    branches holding ON holding.branchcode = items.holdingbranch 
  GROUP BY 
    items.biblionumber, 
    items.itemnumber 
  ) 
  item_info ON item_info.itemnumber = branchtransfers.itemnumber 
WHERE 
  branchtransfers.datearrived IS NULL AND 
  branchtransfers.datecancelled IS NULL AND 
  (branchtransfers.datesent BETWEEN '2023-03-03' AND '2023-03-10') AND  
  (Concat_Ws(' | ', 
    item_info.homebranch, 
    branchtransfers.frombranch, 
    branchtransfers.tobranch 
  ) LIKE Concat('%', 'BERN', '%') OR
  Concat_Ws(' | ', 
    item_info.homebranch, 
    branchtransfers.frombranch, 
    branchtransfers.tobranch 
  ) LIKE Concat('%', 'CARBONDALE', '%') OR
  Concat_Ws(' | ', 
    item_info.homebranch, 
    branchtransfers.frombranch, 
    branchtransfers.tobranch 
  ) LIKE Concat('%', 'CENTRALIA', '%') OR
  Concat_Ws(' | ', 
    item_info.homebranch, 
    branchtransfers.frombranch, 
    branchtransfers.tobranch 
  ) LIKE Concat('%', 'CORNING', '%') OR
  Concat_Ws(' | ', 
    item_info.homebranch, 
    branchtransfers.frombranch, 
    branchtransfers.tobranch 
  ) LIKE Concat('%', 'EFFINGHAM', '%') OR
  Concat_Ws(' | ', 
    item_info.homebranch, 
    branchtransfers.frombranch, 
    branchtransfers.tobranch 
  ) LIKE Concat('%', 'EVEREST', '%') OR
  Concat_Ws(' | ', 
    item_info.homebranch, 
    branchtransfers.frombranch, 
    branchtransfers.tobranch 
  ) LIKE Concat('%', 'HIAWATHA', '%') OR
  Concat_Ws(' | ', 
    item_info.homebranch, 
    branchtransfers.frombranch, 
    branchtransfers.tobranch 
  ) LIKE Concat('%', 'HOLTON', '%') OR
  Concat_Ws(' | ', 
    item_info.homebranch, 
    branchtransfers.frombranch, 
    branchtransfers.tobranch 
  ) LIKE Concat('%', 'HORTON', '%') OR
  Concat_Ws(' | ', 
    item_info.homebranch, 
    branchtransfers.frombranch, 
    branchtransfers.tobranch 
  ) LIKE Concat('%', 'MERIDEN', '%') OR
  Concat_Ws(' | ', 
    item_info.homebranch, 
    branchtransfers.frombranch, 
    branchtransfers.tobranch 
  ) LIKE Concat('%', 'NORTONVILLE', '%') OR
  Concat_Ws(' | ', 
    item_info.homebranch, 
    branchtransfers.frombranch, 
    branchtransfers.tobranch 
  ) LIKE Concat('%', 'OVERBROOK', '%') OR
  Concat_Ws(' | ', 
    item_info.homebranch, 
    branchtransfers.frombranch, 
    branchtransfers.tobranch 
  ) LIKE Concat('%', 'PH', '%') OR
  Concat_Ws(' | ', 
    item_info.homebranch, 
    branchtransfers.frombranch, 
    branchtransfers.tobranch 
  ) LIKE Concat('%', 'ROSSVILLE', '%') OR
  Concat_Ws(' | ', 
    item_info.homebranch, 
    branchtransfers.frombranch, 
    branchtransfers.tobranch 
  ) LIKE Concat('%', 'SABETHA', '%') OR
  Concat_Ws(' | ', 
    item_info.homebranch, 
    branchtransfers.frombranch, 
    branchtransfers.tobranch 
  ) LIKE Concat('%', 'SENECA', '%') OR
  Concat_Ws(' | ', 
    item_info.homebranch, 
    branchtransfers.frombranch, 
    branchtransfers.tobranch 
  ) LIKE Concat('%', 'SILVERLAKE', '%') OR
  Concat_Ws(' | ', 
    item_info.homebranch, 
    branchtransfers.frombranch, 
    branchtransfers.tobranch 
  ) LIKE Concat('%', 'VALLEYFALLS', '%') OR
  Concat_Ws(' | ', 
    item_info.homebranch, 
    branchtransfers.frombranch, 
    branchtransfers.tobranch 
  ) LIKE Concat('%', 'WETMORE', '%') OR
  Concat_Ws(' | ', 
    item_info.homebranch, 
    branchtransfers.frombranch, 
    branchtransfers.tobranch 
  ) LIKE Concat('%', 'WINCHESTER', '%')) AND 
  Concat_Ws(' | ', 
    item_info.homebranch, 
    branchtransfers.frombranch, 
    branchtransfers.tobranch 
  ) LIKE Concat('%', <<Choose your library|LBRANCH>>, '%')
GROUP BY 
  item_info.biblionumber, 
  item_info.itemnumber 
ORDER BY 
  CASE WHEN SORTING = '1' THEN item_info.HOME_LIBRARY END ASC, 
  CASE WHEN SORTING = '2' THEN item_info.PERM_LOCATION END ASC, 
  item_info.PERM_LOCATION, 
  item_info.ITYPE, 
  item_info.CCODE, 
  item_info.itemcallnumber, 
  item_info.author, 
  item_info.TITLE, 
  item_info.copynumber 

























