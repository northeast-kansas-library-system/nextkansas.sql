/*
R.003692

----------

Name: GHW - Quick backup for upgrade testing
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-12-22 14:39:41
Modified on: 2022-12-22 14:43:39
Date last run: 2022-12-22 14:44:01

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>See Northeast Kansas Library Sytem/system_preference_backup on Github for full instructions</p>
<p></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3692">Click here to download as a csv file</a></p>
<p class= "notetags" style="display: none;">#backups #monthly #sysprefs</p>
</div>

----------
*/



Select Concat(
    If(
      Length(systempreferences.value) > 30000,
      "PRODUCTION_XX.",
      "PRODUCTION_SP."
    ),
    Replace(systempreferences.variable, ":", "_")
  ) As FILE_NAME,
  Concat_Ws(
    "",
    "/*",
    Char(13),
    Char(10),
    Concat(
      If(
        Length(systempreferences.value) > 30000,
        "XX.",
        "SP."
      ),
      systempreferences.variable,
      ".js"
    ),
    Char(13),
    Char(10),
    Char(13),
    Char(10),
    "----------",
    Char(13),
    Char(10),
    Char(13),
    Char(10),
    "Preference name: ",
    systempreferences.variable,
    Char(13),
    Char(10),
    Char(13),
    Char(10),
    "Type: ",
    systempreferences.type,
    Char(13),
    Char(10),
    Char(13),
    Char(10),
    "Options: ",
    systempreferences.options,
    Char(13),
    Char(10),
    Char(13),
    Char(10),
    "----------",
    Char(13),
    Char(10),
    Char(13),
    Char(10),
    "Preference value: ",
    Char(13),
    Char(10),
    Char(13),
    Char(10),
    "*/"
  ) As INFO,
  SubString(
    systempreferences.value
    From 1 For 30000
  ) As PART_ONE,
  If(
    Length(systempreferences.value) > 30000,
    "||AAAAA||",
    ""
  ) As SEP_ONE,
  SubString(
    systempreferences.value
    From 30001 For 30000
  ) As PART_TWO,
  If(
    Length(systempreferences.value) > 60000,
    "||AAAAA||",
    ""
  ) As SEP_TWO,
  SubString(
    systempreferences.value
    From 60001 For 30000
  ) As PART_THREE,
  If(
    Length(systempreferences.value) > 90000,
    "||AAAAA||",
    ""
  ) As SEP_THREE,
  SubString(
    systempreferences.value
    From 90001 For 30000
  ) As PART_FOUR,
  If(
    Length(systempreferences.value) > 120000,
    "||AAAAA||",
    ""
  ) As SEP_FOUR,
  SubString(
    systempreferences.value
    From 120001 For 30000
  ) As PART_FIVE
From systempreferences
Where (
    systempreferences.variable Like "%UserJS%"
    Or systempreferences.variable Like "%UserCSS%"
  )
Group By systempreferences.variable

























