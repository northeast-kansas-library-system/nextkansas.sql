/*
R.003113

----------

Name: GHW - Deleted item dashboard
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-08-13 15:03:41
Modified on: 2019-03-19 13:56:19
Date last run: 2020-08-17 08:44:06

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Basic information about an item that has been deleted</p>
<ul><li>Shows items that are currently in the deleteditems table.  Item data is stored in the deleteditems table for 13 months after an item is deleted.</li>
<li>shows items with the barcode numbers you specify</li>
<li>grouped by itemnumber</li>
<li>sorted by homebranch, item type, collection code, call number, author, and title</li>
<li>Contains links to the items bibliographic record (if the bibliographic record has not been deleted) and links to a fines/fees report that can search by item barcode</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3113&phase=Run%20this%20report&limit=400"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  Concat_Ws(
    '<br />',
    Concat('At the time of its deletion on:  <ins><strong>', deleteditems.timestamp, "<br /></strong></ins> this item's information was as follows:<br />"),
    Concat('Item homebranch: ', deleteditems.homebranch),
    Concat('Current branch: ', deleteditems.holdingbranch),
    Concat('Shelving location: ', deleteditems.location),
    Concat('Item type: ', deleteditems.itype),
    Concat('Collection code: ', ccodes.lib),
    Concat('Call#: ', deleteditems.itemcallnumber),
    Concat('Author: ', Coalesce(biblio.author, deletedbiblio.author)),
    Concat('Title: ', Coalesce(biblio.title, deletedbiblio.title)),
    Concat('Item barcode: ', deleteditems.barcode),
    Concat('Item id number: ', deleteditems.itemnumber),
    Concat("<br />Damaged status: ",
      If(
        deleteditems.damaged = 0,
        "-",
        If(
          deleteditems.damaged IS NULL,
          "-",
          damagedi.lib
        )
      )
    ),
    Concat("Lost status: ",
      If(
        deleteditems.itemlost = 0,
        "-",
        If(
          deleteditems.itemlost IS NULL,
          "-",
          Concat(losti.lib, " on ", deleteditems.itemlost_on)
        )
      )
    ),
    Concat("Withdrawn status: ",
      If(
        deleteditems.withdrawn = 0,
        "-",
        If(
          deleteditems.withdrawn IS NULL,
          "- ",
          Concat(deletedwithdrawni.lib, " on ", deleteditems.withdrawn_on)
        )
      )
    ),
    If(biblio.biblionumber IS NULL,
      "<br />-- Bibliographic record has been deleted --",
      Concat(
        "<br /><a href='/cgi-bin/koha/catalogue/detail.pl?biblionumber=",
        biblio.biblionumber,
        "' target='_blank'>go to the bibliographic record</a>"
      )
    ),
    Concat(
      "<br /><a href='/cgi-bin/koha/reports/guided_reports.pl?phase=Run+this+report&reports=3009&sql_params=",
      REPLACE(
        REPLACE(
          REPLACE(
            REPLACE(
              REPLACE(
                REPLACE(
                  REPLACE(
                    deleteditems.barcode,
                    CHAR(43), "%2B"
                  ),
                  CHAR(47),"%2F"
                ),
                CHAR(32), "%20"
              ),
              CHAR(45), "%2D"
            ),
            CHAR(36), "%24"
          ),
          CHAR(37), "%25"
        ),
        CHAR(46), "%2E"
      ),
      "&limit=50' target='_blank'>See all fine and fees history for this item barcode number</a>"
    )
  ) AS INFO
FROM
  deleteditems
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE'
    GROUP BY
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
  ) ccodes
    ON deleteditems.ccode = ccodes.authorised_value
  LEFT JOIN biblio
    ON deleteditems.biblionumber = biblio.biblionumber
  LEFT JOIN deletedbiblio
    ON deleteditems.biblionumber = deletedbiblio.biblionumber
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'DAMAGED'
  ) damagedi
    ON damagedi.authorised_value = deleteditems.damaged
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOST'
  ) losti
    ON losti.authorised_value = deleteditems.itemlost
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'WITHDRAWN'
  ) deletedwithdrawni
    ON deletedwithdrawni.authorised_value = deleteditems.withdrawn
WHERE
  deleteditems.barcode LIKE Concat("%", <<Enter a deleted item barcode number, a partial barcode nuber or a % symbol>>, "%")
GROUP BY
  deleteditems.itemnumber
ORDER BY
  deleteditems.homebranch,
  deleteditems.itype,
  ccodes.lib,
  deleteditems.itemcallnumber,
  Coalesce(biblio.author, deletedbiblio.author),
  Coalesce(biblio.title, deletedbiblio.title)



