/*
R.003933

----------

Name: GHW - Failed login attempts
Created by: George Williams

----------

Group: -
     -

Created on: 2025-12-29 22:59:53
Modified on: 2025-12-30 10:08:02
Date last run: 2026-01-27 15:42:53

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  branches.branchcode,
  Coalesce(Sum(logins.SUCCESSFUL_LOGINS), 0) As SUCCESSFUL_LOGINS,
  Coalesce(Sum(logins.SUCCESSFUL_VIA_STAFF), 0) AS SUCCESSFUL_VIA_STAFF,
  Coalesce(Sum(logins.SUCCESSFUL_VIA_OTHER), 0) AS SUCCESSFUL_VIA_OTHER,
  Coalesce(Sum(logins.FAILED_LOGIN_ATTEMPTS), 0) AS FAILED_LOGIN_ATTEMPTS,
  Coalesce(Sum(logins.FAILED_VIA_STAFF), 0) AS FAILED_VIA_STAFF,
  Coalesce(Sum(logins.FAILED_VIA_API), 0) AS FAILED_VIA_API,
  Coalesce(Sum(logins.FAILED_VIA_SIP), 0) AS FAILED_VIA_SIP,
  Coalesce(Sum(logins.FAILED_VIA_OPAC), 0) AS FAILED_VIA_OPAC,
  Coalesce(Sum(logins.LOCKED_OUT), 0) AS LOCKED_OUT,
  Coalesce(Sum(logins.RECOVERED_BEFORE_LOCKOUT), 0) AS RECOVERED_BEFORE_LOCKOUT,
  Coalesce(Sum(logins.PASWORD_CHANGED_TOTAL), 0) AS PASWORD_CHANGED_TOTAL,
  Coalesce(Sum(logins.CHANGED_VIA_STAFF), 0) AS CHANGED_VIA_STAFF,
  Coalesce(Sum(logins.CHANGED_VIA_API), 0) AS CHANGED_VIA_API,
  Coalesce(Sum(logins.CHANGED_VIA_SIP), 0) AS CHANGED_VIA_SIP,
  Coalesce(Sum(logins.CHANGED_VIA_OPAC), 0) AS CHANGED_VIA_OPAC
From
  branches Left Join
  (
    Select
      Coalesce(borrowers.branchcode, deletedborrowers.branchcode, 'No brach') As BRANCHCODE,
      Case
          When action_logs.action = 'SUCCESS'
          Then '1'
          Else '0'
      End As SUCCESSFUL_LOGINS,
      Case
          When action_logs.action = 'SUCCESS' And action_logs.interface = 'intranet'
          Then '1'
          Else '0'
      End As SUCCESSFUL_VIA_STAFF,
      Case
          When action_logs.action = 'SUCCESS' And action_logs.interface = 'opac'
          Then '1'
          Else '0'
      End As SUCCESSFUL_VIA_OTHER,
      Case
          When action_logs.info Like '%login_attempts%' And action_logs.info Not Like '%"after" : "0"%'
          Then '1'
          Else '0'
      End As FAILED_LOGIN_ATTEMPTS,
      Case
          When action_logs.interface = 'intranet' And action_logs.info Like '%login_attempts%' And
              action_logs.info Not Like '%"after" : "0"%'
          Then '1'
          Else '0'
      End As FAILED_VIA_STAFF,
      Case
          When action_logs.interface = 'api' And action_logs.info Like '%login_attempts%' And
              action_logs.info Not Like '%"after" : "0"%'
          Then '1'
          Else '0'
      End As FAILED_VIA_API,
      Case
          When action_logs.interface = 'sip' And action_logs.info Like '%login_attempts%' And
              action_logs.info Not Like '%"after" : "0"%'
          Then '1'
          Else '0'
      End As FAILED_VIA_SIP,
      Case
          When action_logs.interface = 'opac' And action_logs.info Like '%login_attempts%' And
              action_logs.info Not Like '%"after" : "0"%'
          Then '1'
          Else '0'
      End As FAILED_VIA_OPAC,
      Case
          When action_logs.info Like '%login_attempts%' And action_logs.info Like '%"after" : "5"%'
          Then '1'
          Else '0'
      End As LOCKED_OUT,
      Case
          When action_logs.info Like '%login_attempts%' And action_logs.info Like '%"after" : "0"%'
          Then '1'
          Else '0'
      End As RECOVERED_BEFORE_LOCKOUT,
      Case
          When action_logs.action Like 'CHANGE PASS'
          Then '1'
          Else '0'
      End As PASWORD_CHANGED_TOTAL,
      Case
          When action_logs.interface = 'intranet' And action_logs.action Like 'CHANGE PASS'
          Then '1'
          Else '0'
      End As CHANGED_VIA_STAFF,
      Case
          When action_logs.interface = 'api' And action_logs.action Like 'CHANGE PASS'
          Then '1'
          Else '0'
      End As CHANGED_VIA_API,
      Case
          When action_logs.interface = 'sip' And action_logs.action Like 'CHANGE PASS'
          Then '1'
          Else '0'
      End As CHANGED_VIA_SIP,
      Case
          When action_logs.interface = 'opac' And action_logs.action Like 'CHANGE PASS'
          Then '1'
          Else '0'
      End As CHANGED_VIA_OPAC
    From
      action_logs Left Join
      borrowers On borrowers.borrowernumber = action_logs.object Left Join
      deletedborrowers On deletedborrowers.borrowernumber = action_logs.object
    Where
      Year(action_logs.timestamp) = Year(Now() - Interval 1 Month) And
      Month(action_logs.timestamp) = Month(Now() - Interval 1 Month) And
      (action_logs.module = 'members' Or
        action_logs.module = 'AUTH')
    Group By
      action_logs.action_id
    Order By
      BRANCHCODE
  ) logins 
    On logins.BRANCHCODE = branches.branchcode
Group By
  branches.branchcode

























