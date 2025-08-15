/*
R.003691

----------

Name: GHW - Action logs - fines - brute force all data
Created by: George Williams

----------

Group: -
     -

Created on: 2022-12-15 20:04:55
Modified on: 2022-12-15 21:19:59
Date last run: 2023-10-26 13:34:24

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
    SubString_Index(SubString_Index(action_logs.info, "action' =&gt; '", -1), "'", 1) Like "%$VAR1 = {%", 
    "-", 
    SubString_Index(SubString_Index(action_logs.info, "action' =&gt; '", -1), "'", 1)
  ) AS ACTION,
  If(
    SubString_Index(SubString_Index(action_logs.info, "amount' =&gt; '", -1), "'", 1) Like "%$VAR1 = {%", 
    "-", 
    SubString_Index(SubString_Index(action_logs.info, "amount' =&gt; '", -1), "'", 1)
  ) AS AMOUNT,
  If(
    SubString_Index(SubString_Index(action_logs.info, "amountoutstanding' =&gt; '", -1), "'", 1) Like "%$VAR1 = {%", 
    "-", 
    SubString_Index(SubString_Index(action_logs.info, "amountoutstanding' =&gt; '", -1), "'", 1)
  ) AS AMOUNTOUTSTANDING,
  Replace(
    Replace(
      If(
        SubString_Index(SubString_Index(action_logs.info, "borrowernumber' =&gt; ", -1), " ", 1) Like "%$VAR1%", 
        "-", 
        SubString_Index(SubString_Index(action_logs.info, "borrowernumber' =&gt; ", -1), " ", 1)
      ),
      "'", 
      ""
    ), 
    ",", 
    ""
  ) As BORROWERNUMBER,  
  If(
    SubString_Index(SubString_Index(action_logs.info, "branchcode' =&gt; '", -1), "'", 1) Like "%$VAR1 = {%", 
    "-", 
    SubString_Index(SubString_Index(action_logs.info, "branchcode' =&gt; '", -1), "'", 1)
  ) AS BRANCHCODE,
  If(
    SubString_Index(SubString_Index(action_logs.info, "created_on' =&gt; '", -1), "'", 1) Like "%$VAR1 = {%", 
    "-", 
    SubString_Index(SubString_Index(action_logs.info, "created_on' =&gt; '", -1), "'", 1)
  ) AS CREATED_ON,
  Replace(
    Replace(
      If(
        SubString_Index(SubString_Index(action_logs.info, "credit_id' =&gt; ", -1), " ", 1) Like "%$VAR1%", 
        "-", 
        SubString_Index(SubString_Index(action_logs.info, "credit_id' =&gt; ", -1), " ", 1)
      ),
      "'", 
      ""
    ), 
    ",", 
    ""
  ) As CREDIT_ID,  
  If(
    SubString_Index(SubString_Index(action_logs.info, "credit_type_code' =&gt; '", -1), "'", 1) Like "%$VAR1 = {%", 
    "-", 
    SubString_Index(SubString_Index(action_logs.info, "credit_type_code' =&gt; '", -1), "'", 1)
  ) AS CREDIT_TYPE_CODE,
  Replace(
    Replace(
      If(
        SubString_Index(SubString_Index(action_logs.info, "debit_id' =&gt; ", -1), " ", 1) Like "%$VAR1%", 
        "-", 
        SubString_Index(SubString_Index(action_logs.info, "debit_id' =&gt; ", -1), " ", 1)
      ),
      "'", 
      ""
    ), 
    ",", 
    ""
  ) As DEBIT_ID,
  If(
    SubString_Index(SubString_Index(action_logs.info, "debit_type_code' =&gt; '", -1), "'", 1) Like "%$VAR1 = {%", 
    "-", 
    SubString_Index(SubString_Index(action_logs.info, "debit_type_code' =&gt; '", -1), "'", 1)
  ) AS DEBIT_TYPE_CODE,
  If(
    SubString_Index(SubString_Index(action_logs.info, "description' =&gt; '", -1), "'", 1) Like "%$VAR1 = {%", 
    "-", 
    SubString_Index(SubString_Index(action_logs.info, "description' =&gt; '", -1), "'", 1)
  ) AS DESCRIPTION,
  Replace(
    Replace(
      If(
        SubString_Index(SubString_Index(action_logs.info, "'id' =&gt; ", -1), " ", 1) Like "%$VAR1%", 
        "-", 
        SubString_Index(SubString_Index(action_logs.info, "'id' =&gt; ", -1), " ", 1)
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
        SubString_Index(SubString_Index(action_logs.info, "itemnumber' =&gt; ", -1), " ", 1) Like "%$VAR1%", 
        "-", 
        SubString_Index(SubString_Index(action_logs.info, "itemnumber' =&gt; ", -1), " ", 1)
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
        SubString_Index(SubString_Index(action_logs.info, "manager_id' =&gt; ", -1), " ", 1) Like "%$VAR1%", 
        "-", 
        SubString_Index(SubString_Index(action_logs.info, "manager_id' =&gt; ", -1), " ", 1)
      ),
      "'", 
      ""
    ), 
    ",", 
    ""
  ) As MANAGER_ID,
  If(
    SubString_Index(SubString_Index(action_logs.info, "note' =&gt; '", -1), "'", 1) Like "%$VAR1 = {%", 
    "-", 
    SubString_Index(SubString_Index(action_logs.info, "note' =&gt; '", -1), "'", 1)
  ) AS NOTE,
  If(
    SubString_Index(SubString_Index(action_logs.info, "offsets' =&gt; [", -1), "]", 1) Like "%$VAR1 = {%", 
    "-", 
    SubString_Index(SubString_Index(action_logs.info, "offsets' =&gt; [", -1), "]", 1)
  ) AS OFFSETS,
  Replace(
    Replace(
      If(
        SubString_Index(SubString_Index(action_logs.info, "payment_type' =&gt; ", -1), " ", 1) Like "%$VAR1%", 
        "-", 
        SubString_Index(SubString_Index(action_logs.info, "payment_type' =&gt; ", -1), " ", 1)
      ),
      "'", 
      ""
    ), 
    ",", 
    ""
  ) As PAYMENT_TYPE,
  If(
    SubString_Index(SubString_Index(action_logs.info, "type' =&gt; '", -1), "'", 1) Like "%$VAR1 = {%", 
    "-", 
    SubString_Index(SubString_Index(action_logs.info, "type' =&gt; '", -1), "'", 1)
  ) AS TYPE
FROM 
  action_logs
WHERE
  action_logs.module = 'FINES'
ORDER BY 
  action_logs.action_id DESC

























