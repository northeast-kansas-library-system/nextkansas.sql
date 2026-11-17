/*
R.003658

----------

Name: GHW - Missing in transit items
Created by: George Williams

----------

Group: -
     -

Created on: 2022-03-25 18:26:18
Modified on: 2026-09-10 00:50:10
Date last run: 2026-11-16 21:40:35

----------

Public: 0
Expiry: 300

----------

<div> 

  <p>Items that have been in transit for more than 7 days</p> 

  <div> 

    <div> 

       
         

            Report function:

         
       
      <div> 
        <div> 

          <p>This report shows items that:</p> 
          <ul> 
            <li>are owned by your library</li> 
            <li>or are in transit from your library to another library</li> 
            <li>or are in transit to your library</li> 
          </ul> 

        </div> 
      </div> 
    </div> 

    <div> 

       
         

          Report instructions:

         
       
      <div> 
        <div> 

          <div> 

            <p>Please search for these items at your library once a week and then:</p> 
            <ul> 
              <li>check in any items you find</li> 
              <li>e-mail the other libraries involved in missing in transit transfers and ask them to also search for the missing items</li> 
              <li>change the status of any items owned by your library that no one can find to "Missing (unable to locate on shelf)" within a reasonable amount of time</li> 
            </ul> 

            <p>If you have a default e-mail program configured on your computer, clicking the "Send e-mail" button in the far right column will automatically generate an e-mail to all libraries concerned with a specific transfer.</p> 

          </div> 

        </div> 
      </div> 
    </div> 

  </div> 

  <div> 

    <p> 

      #core 
      #weekly 
      #missing in transit 
      #mit 

    </p> 

  </div> 

  <div>
    <br><br>
    Training page for report 3658<i></i>
    <br>

    <br>

  </div>

</div>

----------
*/



SELECT
  Concat('<a class="btn btn-default btn-xs noprint"', 'href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',
  items.biblionumber, '\" target="_blank">BIBLIO</a>') AS 'LINK',
  home_library.branchname AS HOME_LIBRARY,
  current_library.branchname AS CURRENT_LIBRARY,
  CASE
    WHEN perm_locs.lib = locs.lib
    THEN perm_locs.lib
    ELSE Concat(perm_locs.lib, ' (', locs.lib, ')')
  END AS LOCATION,
  itemtypes.description AS ITYPE,
  ccodes.lib AS CCODE,
  CASE
    WHEN Coalesce(items.copynumber, '') = ''
    THEN items.itemcallnumber
    ELSE Concat(items.itemcallnumber, ' (Copy: ', items.copynumber, ')')
  END AS CALL_NUMBER,
  biblio.author AS AUTHOR,
  Concat_Ws(' ', biblio.title, biblio.medium, biblio.subtitle, biblioitems.number, biblio.part_name) AS TITLE,
  items.datelastseen AS LAST_SEEN,
  CASE
    WHEN items.barcode LIKE '0%'
    THEN Concat('-', items.barcode, '-')
    ELSE items.barcode
  END AS BARCODE,
  home_library.branchname AS OWNED_BY,
  branchtransfers.datesent AS SENT_ON,
  from_library.branchname AS SENT_FROM,
  to_library.branchname AS SENT_TO,
  branchtransfers.reason,
  Concat_Ws('', '<a class="btn btn-default btn-xs noprint" ', 'href="mailto:', home_library.branchreplyto,
  '?subject=Missing&nbsp;in&nbsp;transit&nbsp;', branchtransfers.branchtransfer_id, '&amp;cc=',
  from_library.branchreturnpath, ';', to_library.branchreplyto, '&body=An%20item%20owned%20by%20&#42;&#42;',
  home_library.branchname, '&#42;&#42;%20was%20shipped%20from%20&#42;&#42;', from_library.branchname,
  '&#42;&#42;%20to%20&#42;&#42;', to_library.branchname, '&#42;&#42;%20on%20', branchtransfers.datesent,
  '%20and%20the%20item%20has%20not%20yet%20arrived.', '%0D%0A%0D%0A', 'The%20details%20are%20as%20follow%3A',
  '%0D%0A%0D%0A', 'Branch%20transfer%20ID%3A%20', branchtransfers.branchtransfer_id, '%0D%0A%0D%0A',
  'Home%20library%3A%20', home_library.branchname, '%0D%0ALocation%3A%20', CASE
    WHEN perm_locs.lib = locs.lib
    THEN perm_locs.lib
    ELSE Concat(perm_locs.lib, ' (', locs.lib, ')')
  END, '%0D%0AItem%20type%3A%20', itemtypes.description, '%0D%0ACollection%20code%3A%20', ccodes.lib,
  '%0D%0ACall%20number%3A%20', CASE
    WHEN Coalesce(items.copynumber, '') = ''
    THEN items.itemcallnumber
    ELSE Concat(items.itemcallnumber, ' (Copy: ', items.copynumber, ')')
  END, '%0D%0AAuthor%3A%20', biblio.author, '%0D%0ATitle%3A%20', Upper(Replace(Concat_Ws(' ', biblio.title,
  biblio.medium, biblio.subtitle, biblioitems.number, biblio.part_name), '&', 'and')), '%0D%0ABarcode%20number%3A%20',
  items.barcode, '%0D%0A%0D%0A', 'Sent%20from%3A%20', from_library.branchname, '%0D%0ASent%20to%3A%20',
  to_library.branchname, '%0D%0ASent%20on%3A%20', branchtransfers.datesent, '%0D%0A%0D%0A', 'Transfer%20reason%3A%20',
  branchtransfers.reason, '%20%0D%0A%0D%0A', 'Could%20you%20please%20check%20the%20shelves%20at%20your%20library%20',
  '&#40;including%20the%20hold%20shelf&#41;%20', 'and%20check%20this%20item%20in%20if%20you%20find%20it&#63;',
  '%0D%0A%0D%0A', 'If%20no%20one%20can%20find%20this%20item%20after%2010-14%20days%2C%20',
  'the%20owning%20library%2C%20%2A%2A', home_library.branchname,
  '%2A%2A%2C%20should%20change%20the%20status%20of%20the%20item%20',
  'to%20 %22Missing%20%28unable%20to%20locate%20on%20shelf%29.%22%20', '%0D%0A%0D%0A', 'Thank you,', '%20%0D%0A%0D%0A',
  '">Send e-mail</a>') AS MAILTO_LINK,
  <<Sort by|XS_BRANCH>> AS SORT_ORDER
FROM
  branchtransfers
  JOIN items
    ON branchtransfers.itemnumber = items.itemnumber
  LEFT JOIN branches home_library
    ON home_library.branchcode = items.homebranch
  LEFT JOIN branches current_library
    ON current_library.branchcode = items.holdingbranch
  LEFT JOIN branches from_library
    ON from_library.branchcode = branchtransfers.frombranch
  LEFT JOIN branches to_library
    ON to_library.branchcode = branchtransfers.tobranch
  JOIN biblio
    ON items.biblionumber = biblio.biblionumber
  JOIN biblioitems
    ON biblioitems.biblionumber = biblio.biblionumber
  LEFT JOIN (SELECT
     authorised_values.category,
     authorised_values.authorised_value,
     authorised_values.lib,
     authorised_values.lib_opac
   FROM
     authorised_values
   WHERE
     authorised_values.category = 'LOC') perm_locs
    ON perm_locs.authorised_value = items.permanent_location
  LEFT JOIN (SELECT
     authorised_values.category,
     authorised_values.authorised_value,
     authorised_values.lib,
     authorised_values.lib_opac
   FROM
     authorised_values
   WHERE
     authorised_values.category = 'LOC') locs
    ON locs.authorised_value = items.location
  LEFT JOIN itemtypes
    ON itemtypes.itemtype = items.itype
  LEFT JOIN (SELECT
     authorised_values.category,
     authorised_values.authorised_value,
     authorised_values.lib,
     authorised_values.lib_opac
   FROM
     authorised_values
   WHERE
     authorised_values.category = 'CCODE') ccodes
    ON ccodes.authorised_value = items.ccode
WHERE
  branchtransfers.datesent < (CurDate() - INTERVAL 7 DAY) AND
  branchtransfers.datearrived IS NULL AND
  branchtransfers.datecancelled IS NULL AND
  Concat_Ws(' | ', 
    branchtransfers.frombranch, 
    branchtransfers.tobranch, 
    items.homebranch 
  ) LIKE Concat('%', <<Choose your library|branches>>, '%')
GROUP BY
  branchtransfers.branchtransfer_id,
  home_library.branchillemail,
  to_library.branchillemail,
  from_library.branchemail,
  current_library.branchemail
ORDER BY
  CASE
    WHEN SORT_ORDER = '1'
    THEN home_library.branchname
    ELSE perm_locs.lib
  END,
  LOCATION,
  ITYPE,
  CCODE,
  CALL_NUMBER,
  AUTHOR,
  TITLE

























