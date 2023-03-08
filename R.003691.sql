/*
R.003691

----------

Name: GHW - Action logs - fines - brute force all data
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-12-15 20:04:55
Modified on: 2022-12-15 21:19:59
Date last run: 2022-12-22 11:35:29

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  action_logs.action_id,
  action_logs.timestamp,
  action_logs.user,
  action_logs.module,
  action_logs.action,
  action_logs.object,
  action_logs.info,
  action_logs.interface,
  action_logs.script,
  If(
    SubString_Index(SubString_Index(action_logs.info, "action' => '", -1), "'", 1) Like "%$VAR1 = {%", 
    "-", 
    SubString_Index(SubString_Index(action_logs.info, "action' => '", -1), "'", 1)
  ) AS ACTION,
  If(
    SubString_Index(SubString_Index(action_logs.info, "amount' => '", -1), "'", 1) Like "%$VAR1 = {%", 
    "-", 
    SubString_Index(SubString_Index(action_logs.info, "amount' => '", -1), "'", 1)
  ) AS AMOUNT,
  If(
    SubString_Index(SubString_Index(action_logs.info, "amountoutstanding' => '", -1), "'", 1) Like "%$VAR1 = {%", 
    "-", 
    SubString_Index(SubString_Index(action_logs.info, "amountoutstanding' => '", -1), "'", 1)
  ) AS AMOUNTOUTSTANDING,
  Replace(
    Replace(
      If(
        SubString_Index(SubString_Index(action_logs.info, "borrowernumber' => ", -1), " ", 1) Like "%$VAR1%", 
        "-", 
        SubString_Index(SubString_Index(action_logs.info, "borrowernumber' => ", -1), " ", 1)
      ),
      "'", 
      ""
    ), 
    ",", 
    ""
  ) As BORROWERNUMBER,  
  If(
    SubString_Index(SubString_Index(action_logs.info, "branchcode' => '", -1), "'", 1) Like "%$VAR1 = {%", 
    "-", 
    SubString_Index(SubString_Index(action_logs.info, "branchcode' => '", -1), "'", 1)
  ) AS BRANCHCODE,
  If(
    SubString_Index(SubString_Index(action_logs.info, "created_on' => '", -1), "'", 1) Like "%$VAR1 = {%", 
    "-", 
    SubString_Index(SubString_Index(action_logs.info, "created_on' => '", -1), "'", 1)
  ) AS CREATED_ON,
  Replace(
    Replace(
      If(
        SubString_Index(SubString_Index(action_logs.info, "credit_id' => ", -1), " ", 1) Like "%$VAR1%", 
        "-", 
        SubString_Index(SubString_Index(action_logs.info, "credit_id' => ", -1), " ", 1)
      ),
      "'", 
      ""
    ), 
    ",", 
    ""
  ) As CREDIT_ID,  
  If(
    SubString_Index(SubString_Index(action_logs.info, "credit_type_code' => '", -1), "'", 1) Like "%$VAR1 = {%", 
    "-", 
    SubString_Index(SubString_Index(action_logs.info, "credit_type_code' => '", -1), "'", 1)
  ) AS CREDIT_TYPE_CODE,
  Replace(
    Replace(
      If(
        SubString_Index(SubString_Index(action_logs.info, "debit_id' => ", -1), " ", 1) Like "%$VAR1%", 
        "-", 
        SubString_Index(SubString_Index(action_logs.info, "debit_id' => ", -1), " ", 1)
      ),
      "'", 
      ""
    ), 
    ",", 
    ""
  ) As DEBIT_ID,
  If(
    SubString_Index(SubString_Index(action_logs.info, "debit_type_code' => '", -1), "'", 1) Like "%$VAR1 = {%", 
    "-", 
    SubString_Index(SubString_Index(action_logs.info, "debit_type_code' => '", -1), "'", 1)
  ) AS DEBIT_TYPE_CODE,
  If(
    SubString_Index(SubString_Index(action_logs.info, "description' => '", -1), "'", 1) Like "%$VAR1 = {%", 
    "-", 
    SubString_Index(SubString_Index(action_logs.info, "description' => '", -1), "'", 1)
  ) AS DESCRIPTION,
  Replace(
    Replace(
      If(
        SubString_Index(SubString_Index(action_logs.info, "'id' => ", -1), " ", 1) Like "%$VAR1%", 
        "-", 
        SubString_Index(SubString_Index(action_logs.info, "'id' => ", -1), " ", 1)
      ),
      "'", 
      ""
    ), 
    ",", 
    ""
  ) As ID,
  Replace(
    Replace(
      If(
        SubString_Index(SubString_Index(action_logs.info, "itemnumber' => ", -1), " ", 1) Like "%$VAR1%", 
        "-", 
        SubString_Index(SubString_Index(action_logs.info, "itemnumber' => ", -1), " ", 1)
      ),
      "'", 
      ""
    ), 
    ",", 
    ""
  ) As ITEMNUMBER,
  Replace(
    Replace(
      If(
        SubString_Index(SubString_Index(action_logs.info, "manager_id' => ", -1), " ", 1) Like "%$VAR1%", 
        "-", 
        SubString_Index(SubString_Index(action_logs.info, "manager_id' => ", -1), " ", 1)
      ),
      "'", 
      ""
    ), 
    ",", 
    ""
  ) As MANAGER_ID,
  If(
    SubString_Index(SubString_Index(action_logs.info, "note' => '", -1), "'", 1) Like "%$VAR1 = {%", 
    "-", 
    SubString_Index(SubString_Index(action_logs.info, "note' => '", -1), "'", 1)
  ) AS NOTE,
  If(
    SubString_Index(SubString_Index(action_logs.info, "offsets' => [", -1), "]", 1) Like "%$VAR1 = {%", 
    "-", 
    SubString_Index(SubString_Index(action_logs.info, "offsets' => [", -1), "]", 1)
  ) AS OFFSETS,
  Replace(
    Replace(
      If(
        SubString_Index(SubString_Index(action_logs.info, "payment_type' => ", -1), " ", 1) Like "%$VAR1%", 
        "-", 
        SubString_Index(SubString_Index(action_logs.info, "payment_type' => ", -1), " ", 1)
      ),
      "'", 
      ""
    ), 
    ",", 
    ""
  ) As PAYMENT_TYPE,
  If(
    SubString_Index(SubString_Index(action_logs.info, "type' => '", -1), "'", 1) Like "%$VAR1 = {%", 
    "-", 
    SubString_Index(SubString_Index(action_logs.info, "type' => '", -1), "'", 1)
  ) AS TYPE
FROM 
  action_logs
WHERE
  action_logs.module = 'FINES'
ORDER BY 
  action_logs.action_id DESC

























