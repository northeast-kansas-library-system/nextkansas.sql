/*
R.003346

----------

Name: Library data for confirmation
Created by: George Williams

----------

Group: -
     -

Created on: 2020-08-14 15:14:53
Modified on: 2023-11-21 17:17:51
Date last run: 2023-11-21 17:17:57

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  concat_ws( 
    '<br />', 
    '### Library name and code', 
    Concat_ws('', '- Branchcode: ', branches.branchcode), 
    Concat_ws('', '- Library name: ', branches.branchname), 
    '<br />', 
    '### Address and location information', 
    Concat_ws('', '- Mailing address: ', branches.branchaddress1), 
    Concat_ws('', '- Street address / Physical address: ', IF(branches.branchaddress2 is null, 'Same', branches.branchaddress2)), 
    Concat_ws('', '- City: ', branches.branchcity), 
    Concat_ws('', '- State: ', branches.branchstate), 
    Concat_ws('', '- Zipcode: ', branches.branchzip), 
    Concat_ws('', '- Geolocation: ', branches.geolocation), 
    '<br />', 
    '### Phone information', 
    Concat_ws('', '- Phone: ', branches.branchphone), 
    Concat_ws('', '- Fax: ', branches.branchfax), 
    '<br />', 
    '### e-mail and e-mail server configurarions', 
    Concat_ws('', '- Email: ', branches.branchemail), 
    Concat_ws('', '- ReplyTo: ', branches.branchreplyto), 
    Concat_ws('', '- ReturnPath: ', branches.branchreturnpath), 
    '<br />', 
    '### Director and other contact information', 
    Concat_ws('', '- Director / ILL contact: ', branches.branchaddress3), 
    Concat_ws('', '- KLE code: ', branches.branchcountry), 
    '<br />', 
    '### Library status', 
    Concat_ws('', '- Pickup location: ',  If(branches.pickup_location = 1, 'Yes', 'No')), 
    Concat_ws('', '- Public: ', If(branches.public = 1, 'Yes', 'No')), 
    '<br />', 
    '### Koha-to-Koha ILL information (currently not used)', 
    Concat_ws('', '- ILL email: ', branches.branchillemail), 
    Concat_ws('', '- Issuing: ', branches.issuing), 
    '<br />', 
    '### Misceleaneous information', 
    Concat_ws('', '- URL: ', branches.branchurl), 
    Concat_ws('', '- IP address: ', branches.branchip), 
    Concat_ws('', '- Marc organization code: ', branches.marcorgcode), 
    Concat_ws('', '- Notes: ', branches.branchnotes) 
  ) AS LIBRARY_INFORMATION 
FROM 
  branches 
WHERE 
  branches.branchcode LIKE <<Choose your library|ZBRAN>> 

























