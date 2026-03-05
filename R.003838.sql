/*
R.003838

----------

Name: failed attempts - locked accounts monthly
Created by: George Williams

----------

Group: -
     -

Created on: 2024-05-31 23:07:04
Modified on: 2024-05-31 23:07:04
Date last run: 2024-08-28 08:32:16

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  branchess.branchname,
  intranet_login_attempts.login_attempst As staff_interface_failed_login_attempts,
  intranet_locked_accounts.locked_accounts As accounts_locked_via_staff_interface,
  opac_login_attempts.login_attempst As non_staff_interface_failed_login_attempts,
  opac_locked_accounts.Count_object As accounts_locked_via_opac,
  sip_locked_accounts.Count_object As accounts_locked_via_sip,
  api_locked_accounts.Count_object As accounts_locked_via_api
From
  (Select
      branches.branchname,
      branches.branchcode
    From
      branches
    Union
    Select
      ' Branch not defined' As Branchname,
      '-' As branchcode) branchess Left Join
  (Select
      Coalesce(borrowers.branchcode, '-') As branchcode,
      Count(action_logs.action_id) As login_attempst
    From
      action_logs Left Join
      borrowers On borrowers.borrowernumber = action_logs.object
    Where
      action_logs.module = 'AUTH' And
      action_logs.action = 'FAILURE' And
      action_logs.interface = 'INTRANET' And
      Year(action_logs.timestamp) = Year(Now() - Interval 1 Month) And
      Month(action_logs.timestamp) = Month(Now() - Interval 1 Month)
    Group By
      borrowers.branchcode) intranet_login_attempts On intranet_login_attempts.branchcode = branchess.branchcode
  Left Join
  (Select
      Coalesce(borrowers.branchcode, '-') As branchcode,
      Count(action_logs.action_id) As login_attempst
    From
      action_logs Left Join
      borrowers On borrowers.borrowernumber = action_logs.object
    Where
      action_logs.module = 'AUTH' And
      action_logs.action = 'FAILURE' And
      action_logs.interface = 'opac' And
      Year(action_logs.timestamp) = Year(Now() - Interval 1 Month) And
      Month(action_logs.timestamp) = Month(Now() - Interval 1 Month)
    Group By
      borrowers.branchcode) opac_login_attempts On opac_login_attempts.branchcode = branchess.branchcode Left Join
  (Select
      Coalesce(borrowers.branchcode, '-') As branchcode,
      Count(Distinct action_logs.user) As locked_accounts
    From
      action_logs Left Join
      borrowers On borrowers.borrowernumber = action_logs.object
    Where
      action_logs.module = 'members' And
      action_logs.action = 'modify' And
      action_logs.info Like '%login_attempts%' And
      action_logs.info Like '%"after" : "5"%' And
      Year(action_logs.timestamp) = Year(Now() - Interval 1 Month) And
      Month(action_logs.timestamp) = Month(Now() - Interval 1 Month) And
      action_logs.interface = 'intranet'
    Group By
      Coalesce(borrowers.branchcode, '-')) intranet_locked_accounts On intranet_locked_accounts.branchcode =
      branchess.branchcode Left Join
  (Select
      Coalesce(borrowers.branchcode, '-') As branchcode,
      Count(Distinct action_logs.object) As Count_object
    From
      action_logs Left Join
      borrowers On borrowers.borrowernumber = action_logs.object
    Where
      action_logs.module = 'members' And
      action_logs.action = 'modify' And
      action_logs.info Like '%login_attempts%' And
      action_logs.info Like '%"after" : "5"%' And
      action_logs.interface = 'opac' And
      Year(action_logs.timestamp) = Year(Now() - Interval 1 Month) And
      Month(action_logs.timestamp) = Month(Now() - Interval 1 Month)
    Group By
      Coalesce(borrowers.branchcode, '-')) opac_locked_accounts On opac_locked_accounts.branchcode =
      branchess.branchcode Left Join
  (Select
      Coalesce(borrowers.branchcode, '-') As branchcode,
      Count(Distinct action_logs.object) As Count_object
    From
      action_logs Left Join
      borrowers On borrowers.borrowernumber = action_logs.user
    Where
      action_logs.module = 'members' And
      action_logs.action = 'modify' And
      action_logs.info Like '%login_attempts%' And
      action_logs.info Like '%"after" : "5"%' And
      action_logs.interface = 'sip' And
      Year(action_logs.timestamp) = Year(Now() - Interval 1 Month) And
      Month(action_logs.timestamp) = Month(Now() - Interval 1 Month)
    Group By
      Coalesce(borrowers.branchcode, '-')) sip_locked_accounts On sip_locked_accounts.branchcode = branchess.branchcode
  Left Join
  (Select
      Coalesce(borrowers.branchcode, '-') As branchcode,
      Count(Distinct action_logs.object) As Count_object
    From
      action_logs Left Join
      borrowers On borrowers.borrowernumber = action_logs.user
    Where
      action_logs.module = 'members' And
      action_logs.action = 'modify' And
      action_logs.info Like '%login_attempts%' And
      action_logs.info Like '%"after" : "5"%' And
      action_logs.interface = 'api' And
      Year(action_logs.timestamp) = Year(Now() - Interval 1 Month) And
      Month(action_logs.timestamp) = Month(Now() - Interval 1 Month)
    Group By
      Coalesce(borrowers.branchcode, '-')) api_locked_accounts On api_locked_accounts.branchcode = branchess.branchcode
Order By
  branchess.branchname

























