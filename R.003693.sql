/*
R.003693

----------

Name: GHW - Create stub accounts for staff
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-12-28 15:30:50
Modified on: 2022-12-28 16:39:49
Date last run: 2022-12-28 16:40:21

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  Concat_Ws(
    '',
    If(
      branches.branchcode = 'ATCHISON',
      '2824476600',
      If(
        branches.branchcode = 'BALDWIN',
        '2253946000',
        If(
          branches.branchcode = 'BASEHOR',
          '2273467000',
          If(
            branches.branchcode = 'BERN',
            '2376000000',
            If(
              branches.branchcode = 'BONNERSPGS',
              '2666377747',
              If(
                branches.branchcode = 'BURLINGAME',
                '2875464263',
                If(
                  branches.branchcode = 'CARBONDALE',
                  '2272663253',
                  If(
                    branches.branchcode = 'CENTRALIA',
                    '2368725420',
                    If(
                      branches.branchcode = 'CORNING',
                      '2676464000',
                      If(
                        branches.branchcode = 'DIGITAL',
                        '3444825000',
                        If(
                          branches.branchcode = 'DONIELWD',
                          '3664359300',
                          If(
                            branches.branchcode = 'DONIHIGH',
                            '3664444400',
                            If(
                              branches.branchcode = 'DONITROY',
                              '3664876900',
                              If(
                                branches.branchcode = 'DONIWATH',
                                '3664928400',
                                If(
                                  branches.branchcode = 'EFFINGHAM',
                                  '3334644260',
                                  If(
                                    branches.branchcode = 'EUDORA',
                                    '3836720000',
                                    If(
                                      branches.branchcode = 'EVEREST',
                                      '3837378000',
                                      If(
                                        branches.branchcode = 'HIAWATHA',
                                        '4429284200',
                                        If(
                                          branches.branchcode = 'HIGH_CC',
                                          '4444022000',
                                          If(
                                            branches.branchcode = 'HOLTON',
                                            '4658660000',
                                            If(
                                              branches.branchcode = 'HORTON',
                                              '4678660000',
                                              If(
                                                branches.branchcode = 'LANSING',
                                                '5267464000',
                                                If(
                                                  branches.branchcode = 'LEAVENWRTH',
                                                  '5328369784',
                                                  If(
                                                    branches.branchcode = 'LINWOOD',
                                                    '5469663000',
                                                    If(
                                                      branches.branchcode = 'LOUISBURG',
                                                      '5684728740',
                                                      If(
                                                        branches.branchcode = 'LYNDON',
                                                        '5963660000',
                                                        If(
                                                          branches.branchcode = 'MCLOUTH',
                                                          '6256884000',
                                                          If(
                                                            branches.branchcode = 'MERIDEN',
                                                            '6374336000',
                                                            If(
                                                              branches.branchcode = 'NEKLS',
                                                              '6355700000',
                                                              If(
                                                                branches.branchcode = 'NORTONVLLE',
                                                                '6678668553',
                                                                If(
                                                                  branches.branchcode = 'OSAGECITY',
                                                                  '6724324890',
                                                                  If(
                                                                    branches.branchcode = 'OSAWATOMIE',
                                                                    '6729286643',
                                                                    If(
                                                                      branches.branchcode = 'OSKALOOSA',
                                                                      '6752566720',
                                                                      If(
                                                                        branches.branchcode = 'OTTAWA',
                                                                        '6882920000',
                                                                        If(
                                                                          branches.branchcode = 'OVERBROOK',
                                                                          '6837276650',
                                                                          If(
                                                                            branches.branchcode = 'PAOLA',
                                                                            '7265200000',
                                                                            If(
                                                                              branches.branchcode = 'PERRY',
                                                                              '7377900000',
                                                                              If(
                                                                                branches.branchcode = 'PHAXTELL',
                                                                                '7429835500',
                                                                                If(
                                                                                  branches.branchcode = 'PHSES',
                                                                                  '7473700000',
                                                                                  If(
                                                                                    branches.branchcode = 'PHSHS',
                                                                                    '7474700000',
                                                                                    If(
                                                                                      branches.branchcode = 'PHSMS',
                                                                                      '7476700000',
                                                                                      If(
                                                                                        branches.branchcode = 'PHWAC',
                                                                                        '7492200000',
                                                                                        If(
                                                                                          branches.branchcode = 'POMONA',
                                                                                          '7666620000',
                                                                                          If(
                                                                                            branches.branchcode = 'RICHMOND',
                                                                                            '7424666300',
                                                                                            If(
                                                                                              branches.branchcode = 'ROSSVILLE',
                                                                                              '7677845530',
                                                                                              If(
                                                                                                branches.branchcode = 'SABETHA',
                                                                                                '7223842000',
                                                                                                If(
                                                                                                  branches.branchcode = 'SENECA',
                                                                                                  '7363220000',
                                                                                                  If(
                                                                                                    branches.branchcode = 'SILVERLAKE',
                                                                                                    '7458375253',
                                                                                                    If(
                                                                                                      branches.branchcode = 'TONGANOXIE',
                                                                                                      '8664266943',
                                                                                                      If(
                                                                                                        branches.branchcode = 'VALLEYFALL',
                                                                                                        '8255393255',
                                                                                                        If(
                                                                                                          branches.branchcode = 'WELLSVILLE',
                                                                                                          '9355784553',
                                                                                                          If(
                                                                                                            branches.branchcode = 'WETMORE',
                                                                                                            '9386673000',
                                                                                                            If(
                                                                                                              branches.branchcode = 'WILLIAMSBG',
                                                                                                              '9455426724',
                                                                                                              If(
                                                                                                                branches.branchcode = 'WINCHESTER',
                                                                                                                '9462437837',
                                                                                                                '0'
                                                                                                              )
                                                                                                            )
                                                                                                          )
                                                                                                        )
                                                                                                      )
                                                                                                    )
                                                                                                  )
                                                                                                )
                                                                                              )
                                                                                            )
                                                                                          )
                                                                                        )
                                                                                      )
                                                                                    )
                                                                                  )
                                                                                )
                                                                              )
                                                                            )
                                                                          )
                                                                        )
                                                                      )
                                                                    )
                                                                  )
                                                                )
                                                              )
                                                            )
                                                          )
                                                        )
                                                      )
                                                    )
                                                  )
                                                )
                                              )
                                            )
                                          )
                                        )
                                      )
                                    )
                                  )
                                )
                              )
                            )
                          )
                        )
                      )
                    )
                  )
                )
              )
            )
          )
        )
      )
    ),
    numberss.NUMBERS
  ) AS cardnumber,
  branches.branchcode AS surname,
  Concat('Empty staff acct - ', numberss.NUMBERS) AS firstname,
  Concat('Staff member at ', branches.branchname) AS othernames,
  If(
    branches.branchaddress2 IS NULL,
    branches.branchaddress1,
    branches.branchaddress2
  ) AS address,
  branches.branchcity AS city,
  branches.branchstate AS state,
  Left(Trim(branches.branchzip), 5) AS zipcode,
  branches.branchphone AS phone,
  Concat('01/01/1900') AS dateofbirth,
  branches.branchcode,
  Concat('STAFF') AS categorycode,
  Concat('12/31/2022') AS dateenrolled,
  Concat('12/31/2050') AS dateexpiry,
  Concat_Ws(
    '',
    If(
      branches.branchcode = 'ATCHISON',
      '2824476600',
      If(
        branches.branchcode = 'BALDWIN',
        '2253946000',
        If(
          branches.branchcode = 'BASEHOR',
          '2273467000',
          If(
            branches.branchcode = 'BERN',
            '2376000000',
            If(
              branches.branchcode = 'BONNERSPGS',
              '2666377747',
              If(
                branches.branchcode = 'BURLINGAME',
                '2875464263',
                If(
                  branches.branchcode = 'CARBONDALE',
                  '2272663253',
                  If(
                    branches.branchcode = 'CENTRALIA',
                    '2368725420',
                    If(
                      branches.branchcode = 'CORNING',
                      '2676464000',
                      If(
                        branches.branchcode = 'DIGITAL',
                        '3444825000',
                        If(
                          branches.branchcode = 'DONIELWD',
                          '3664359300',
                          If(
                            branches.branchcode = 'DONIHIGH',
                            '3664444400',
                            If(
                              branches.branchcode = 'DONITROY',
                              '3664876900',
                              If(
                                branches.branchcode = 'DONIWATH',
                                '3664928400',
                                If(
                                  branches.branchcode = 'EFFINGHAM',
                                  '3334644260',
                                  If(
                                    branches.branchcode = 'EUDORA',
                                    '3836720000',
                                    If(
                                      branches.branchcode = 'EVEREST',
                                      '3837378000',
                                      If(
                                        branches.branchcode = 'HIAWATHA',
                                        '4429284200',
                                        If(
                                          branches.branchcode = 'HIGH_CC',
                                          '4444022000',
                                          If(
                                            branches.branchcode = 'HOLTON',
                                            '4658660000',
                                            If(
                                              branches.branchcode = 'HORTON',
                                              '4678660000',
                                              If(
                                                branches.branchcode = 'LANSING',
                                                '5267464000',
                                                If(
                                                  branches.branchcode = 'LEAVENWRTH',
                                                  '5328369784',
                                                  If(
                                                    branches.branchcode = 'LINWOOD',
                                                    '5469663000',
                                                    If(
                                                      branches.branchcode = 'LOUISBURG',
                                                      '5684728740',
                                                      If(
                                                        branches.branchcode = 'LYNDON',
                                                        '5963660000',
                                                        If(
                                                          branches.branchcode = 'MCLOUTH',
                                                          '6256884000',
                                                          If(
                                                            branches.branchcode = 'MERIDEN',
                                                            '6374336000',
                                                            If(
                                                              branches.branchcode = 'NEKLS',
                                                              '6355700000',
                                                              If(
                                                                branches.branchcode = 'NORTONVLLE',
                                                                '6678668553',
                                                                If(
                                                                  branches.branchcode = 'OSAGECITY',
                                                                  '6724324890',
                                                                  If(
                                                                    branches.branchcode = 'OSAWATOMIE',
                                                                    '6729286643',
                                                                    If(
                                                                      branches.branchcode = 'OSKALOOSA',
                                                                      '6752566720',
                                                                      If(
                                                                        branches.branchcode = 'OTTAWA',
                                                                        '6882920000',
                                                                        If(
                                                                          branches.branchcode = 'OVERBROOK',
                                                                          '6837276650',
                                                                          If(
                                                                            branches.branchcode = 'PAOLA',
                                                                            '7265200000',
                                                                            If(
                                                                              branches.branchcode = 'PERRY',
                                                                              '7377900000',
                                                                              If(
                                                                                branches.branchcode = 'PHAXTELL',
                                                                                '7429835500',
                                                                                If(
                                                                                  branches.branchcode = 'PHSES',
                                                                                  '7473700000',
                                                                                  If(
                                                                                    branches.branchcode = 'PHSHS',
                                                                                    '7474700000',
                                                                                    If(
                                                                                      branches.branchcode = 'PHSMS',
                                                                                      '7476700000',
                                                                                      If(
                                                                                        branches.branchcode = 'PHWAC',
                                                                                        '7492200000',
                                                                                        If(
                                                                                          branches.branchcode = 'POMONA',
                                                                                          '7666620000',
                                                                                          If(
                                                                                            branches.branchcode = 'RICHMOND',
                                                                                            '7424666300',
                                                                                            If(
                                                                                              branches.branchcode = 'ROSSVILLE',
                                                                                              '7677845530',
                                                                                              If(
                                                                                                branches.branchcode = 'SABETHA',
                                                                                                '7223842000',
                                                                                                If(
                                                                                                  branches.branchcode = 'SENECA',
                                                                                                  '7363220000',
                                                                                                  If(
                                                                                                    branches.branchcode = 'SILVERLAKE',
                                                                                                    '7458375253',
                                                                                                    If(
                                                                                                      branches.branchcode = 'TONGANOXIE',
                                                                                                      '8664266943',
                                                                                                      If(
                                                                                                        branches.branchcode = 'VALLEYFALL',
                                                                                                        '8255393255',
                                                                                                        If(
                                                                                                          branches.branchcode = 'WELLSVILLE',
                                                                                                          '9355784553',
                                                                                                          If(
                                                                                                            branches.branchcode = 'WETMORE',
                                                                                                            '9386673000',
                                                                                                            If(
                                                                                                              branches.branchcode = 'WILLIAMSBG',
                                                                                                              '9455426724',
                                                                                                              If(
                                                                                                                branches.branchcode = 'WINCHESTER',
                                                                                                                '9462437837',
                                                                                                                '0'
                                                                                                              )
                                                                                                            )
                                                                                                          )
                                                                                                        )
                                                                                                      )
                                                                                                    )
                                                                                                  )
                                                                                                )
                                                                                              )
                                                                                            )
                                                                                          )
                                                                                        )
                                                                                      )
                                                                                    )
                                                                                  )
                                                                                )
                                                                              )
                                                                            )
                                                                          )
                                                                        )
                                                                      )
                                                                    )
                                                                  )
                                                                )
                                                              )
                                                            )
                                                          )
                                                        )
                                                      )
                                                    )
                                                  )
                                                )
                                              )
                                            )
                                          )
                                        )
                                      )
                                    )
                                  )
                                )
                              )
                            )
                          )
                        )
                      )
                    )
                  )
                )
              )
            )
          )
        )
      )
    ),
    numberss.NUMBERS
  ) AS userid,
  Concat(
    SUBSTR(MD5(RAND()), 1, 20),
    Upper(SUBSTR(MD5(RAND()), 1, 4))
  ) AS password,
  Concat('2') AS privacy
FROM branches,
  (
    SELECT 
      LPad(Day(action_logs.timestamp), 4, 0) AS NUMBERS
    FROM 
      action_logs
    WHERE 
      action_logs.module = 'CRONJOBS'
        AND 
      Day(action_logs.timestamp) < 21
    GROUP BY 
      LPad(Day(action_logs.timestamp), 4, 0),
      Day(action_logs.timestamp),
      action_logs.module
  ) numberss
ORDER BY 
  surname,
  cardnumber





















