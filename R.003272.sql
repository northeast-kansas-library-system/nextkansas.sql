/*
R.003272

----------

Name: GHW - Email template report for miss-labeled deliveries ADMINREPORT
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-09-30 17:39:47
Modified on: 2019-10-02 15:49:00
Date last run: 2019-10-01 15:52:39

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat_Ws(
    "",
    'nexthelp@nekls.org',
    '<br /><br />',
    shippinginfo.frommail,
    '<br /><br />',
    'Items shipped with incorrect label',
    '<br /><br />', 
    'According to the logs in the system, an item was shipped from ', 
    '<span style="text-decoration: underline;">', 
    shippinginfo.fromname, 
    '</span>', 
    ' to ', 
    '<span style="text-decoration: underline;">', 
    shippinginfo.toname, 
    '</span>', 
    ' on ', 
    shippinginfo.DATE, 
    ' at ', 
    shippinginfo.TIME, 
    '<br /><br />', 
    'The details are as follow:<br /><br />', 
    Concat('BC: ', Upper(items.barcode), '<br />'), 
    Concat('Home library: ', items.homebranch, '<br />'), 
    Concat('Current library: ', items.holdingbranch, '<br />'), 
    Concat('Location: ', loction.lib, '<br />'), 
    Concat('Item type: ', itemtypes.description, '<br />'), 
    Concat('Collection code: ', ccodes.lib, '<br />'), 
    Concat('Call number: ', items.itemcallnumber, '<br />'), 
    Concat('Author: ', biblio.author, '<br />'), 
    Concat_Ws(
      ' ', 
      'Title: ', 
      biblio.title, 
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), 
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), 
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')
    ), 
    '<br /><br />', 
    'It appears that your staff used the incorrect shipping label because this item arrived recently in the delivery at ', 
    '<span style="text-decoration: underline; font-weight: bold;">', 
    Concat(receivingbranch.branchnotes, " - ", receivingbranch.branchname), 
    '</span>', 
    ' instead of its intended destination.', 
    '<br /><br />', 
    'We are letting you know because we have had a significant problem with miss-labeled deliveries at ',
    receivingbranch.branchname,
    ' recently.', 
    '  We were hoping you could let your staff know about this so we can get the ', 
    '<span style="text-decoration: underline; font-weight: bold;">', 
    Concat(shippinginfo.tonotes, " - ", shippinginfo.toname), 
    '</span>', 
    ' items shipped directly to ', 
    '<span style="text-decoration: underline; font-weight: bold;">', 
    Concat(shippinginfo.tonotes, " - ", shippinginfo.toname), 
    '</span>', 
    ' instead of ', 
    '<span style="text-decoration: underline; font-weight: bold;">', 
    Concat(receivingbranch.branchnotes, " - ", receivingbranch.branchname), 
    '</span>', '.', '<br /><br />', 
    'Thanks for your help - and if you have any questions (or if you are having a similar problem with miss-labeled deliveries), please let us know at nexthelp@nekls.org,<br /><br />George<br />nexthelp@nekls.org') AS LETTER
FROM
  items
  JOIN biblio
    ON items.biblionumber = biblio.biblionumber
  JOIN biblio_metadata
    ON biblio_metadata.biblionumber = biblio.biblionumber AND
      items.biblionumber = biblio_metadata.biblionumber
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC'
  ) loction
    ON loction.authorised_value = items.location
  LEFT JOIN itemtypes
    ON itemtypes.itemtype = items.itype
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'ccode'
  ) ccodes
    ON ccodes.authorised_value = items.ccode
  JOIN (
    SELECT
      branchtransfers.branchtransfer_id,
      Date_Format(branchtransfers.datesent, "%Y.%m.%d") AS DATE,
      Date_Format(branchtransfers.datesent, "%h:%i %p") AS TIME,
      branchtransfers.itemnumber,
      branchfrom.branchemail AS frommail,
      branchfrom.branchname AS fromname,
      branchfrom.branchnotes AS fromnotes,
      branchto.branchname AS toname,
      branchto.branchnotes AS tonotes
    FROM
      branchtransfers
      JOIN (
        SELECT
          branches.branchcode,
          branches.branchname,
          branches.branchnotes,
          branches.branchemail
        FROM
          branches
      ) branchfrom
        ON branchfrom.branchcode = branchtransfers.frombranch
      JOIN (
        SELECT
          branches.branchcode,
          branches.branchname,
          branches.branchnotes
        FROM
          branches
      ) branchto
        ON branchto.branchcode = branchtransfers.tobranch
    WHERE
      branchtransfers.branchtransfer_id = <<Transfer ID>>
    GROUP BY
      branchtransfers.branchtransfer_id,
      branchtransfers.itemnumber,
      branchfrom.branchemail,
      branchfrom.branchname,
      branchfrom.branchnotes,
      branchto.branchname,
      branchto.branchnotes
  ) shippinginfo
    ON shippinginfo.itemnumber = items.itemnumber
  JOIN branches
    ON items.homebranch = branches.branchcode,
  (
    SELECT
      branches.branchcode,
      branches.branchname,
      branches.branchnotes
    FROM
      branches
    WHERE
      branches.branchcode = <<Library receiving miss-labeled item|branches>>
  ) receivingbranch
GROUP BY
  items.itemnumber

























