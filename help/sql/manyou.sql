SELECT
      rownum rn,
      t.*
    FROM
      (
        WITH gsm_table AS (
          SELECT
            hm_prov_cd || '-' || vstd_prov_cd cd,
            Sum(rm_chg) rm_chg
          FROM
            (
              SELECT
                hm_prov_cd,
                vstd_prov_cd,
                rm_chg
              FROM
                gsmdba.sttl_prov_daily
              WHERE
                1 = 1
              AND hm_prov_cd <> 2
              AND vstd_prov_cd <> 2
              AND dt = to_date ('2018-09-10', 'yyyy-mm-dd')
              UNION ALL
                SELECT
                  hm_prov_cd,
                  vstd_prov_cd,
                  rm_chg
                FROM
                  gsmdba.sttl_prov_daily_vd
                WHERE
                  1 = 1
                AND dt = to_date ('2018-09-10', 'yyyy-mm-dd')
                UNION ALL
                  SELECT
                    hm_prov_cd,
                    vstd_prov_cd,
                    rm_chg
                  FROM
                    gsmspdba.sttl_prov_daily_sp
                  WHERE
                    1 = 1
                  AND serv_cd IN (
                    '0003',
                    '0009',
                    '0012',
                    '0007',
                    '0008',
                    '0011',
                    '0103',
                    '0109',
                    '0004',
                    '0010',
                    '0110',
                    '0013'
                  )
                  AND dt = to_date ('2018-09-10', 'yyyy-mm-dd')
            )
          GROUP BY
            hm_prov_cd,
            vstd_prov_cd
        ),
        iot_table AS (
          SELECT
            hm_prov_cd || '-' || vstd_prov_cd cd,
            Sum(rm_chg) rm_chg
          FROM
            (
              SELECT
                hm_prov_cd,
                vstd_prov_cd,
                rm_chg
              FROM
                gsmdba.sttl_prov_daily
              WHERE
                1 = 1
              AND (
                hm_prov_cd = 2
                OR vstd_prov_cd = 2
              )
              AND dt = to_date ('2018-09-10', 'yyyy-mm-dd')
            )
          GROUP BY
            hm_prov_cd,
            vstd_prov_cd
        ),
        vlt_table AS (
          SELECT
            hm_prov_cd || '-' || vstd_prov_cd cd,
            Sum(rm_chg / 1000) rm_chg
          FROM
            (
              SELECT
                hm_prov_cd,
                vstd_prov_cd,
                rm_chg
              FROM
                vltdba.sttl_prov_daily@volte
              WHERE
                1 = 1
              AND dt = to_date ('2018-09-10', 'yyyy-mm-dd')
            )
          GROUP BY
            hm_prov_cd,
            vstd_prov_cd
        ) SELECT
          prov_nm,
          gsm_pay_tax,
          gsm_pay_chg,
          vlt_pay_tax,
          vlt_pay_chg,
          iot_pay_tax,
          iot_pay_chg,
          gsm_get_tax,
          gsm_get_chg,
          vlt_get_tax,
          vlt_get_chg,
          iot_get_tax,
          iot_get_chg,
          gsm_get_chg + vlt_get_chg + iot_get_chg - gsm_pay_chg - vlt_pay_chg - iot_pay_chg sttl
        FROM
          (
            SELECT
              prov_nm,
              gsm_pay_tax,
              gsm_pay_chg,
              vlt_pay_tax,
              vlt_pay_chg,
              iot_pay_tax,
              iot_pay_chg,
              Decode(
                prov_nm,
                '??',
                gsm_get_tax + Sum(gsm_pay_tax) OVER () - sum(gsm_get_tax) over (),
                gsm_get_tax
              ) gsm_get_tax,
              Decode(
                prov_nm,
                '??',
                gsm_get_chg + Sum(gsm_pay_chg) OVER () - sum(gsm_get_chg) over (),
                gsm_get_chg
              ) gsm_get_chg,
              Decode(
                prov_nm,
                '??',
                vlt_get_tax + Sum(vlt_pay_tax) OVER () - sum(vlt_get_tax) over (),
                vlt_get_tax
              ) vlt_get_tax,
              Decode(
                prov_nm,
                '??',
                vlt_get_chg + Sum(vlt_pay_chg) OVER () - sum(vlt_get_chg) over (),
                vlt_get_chg
              ) vlt_get_chg,
              Decode(
                prov_nm,
                '??',
                iot_get_tax + Sum(iot_pay_tax) OVER () - sum(iot_get_tax) over (),
                iot_get_tax
              ) iot_get_tax,
              Decode(
                prov_nm,
                '??',
                iot_get_chg + Sum(iot_pay_chg) OVER () - sum(iot_get_chg) over (),
                iot_get_chg
              ) iot_get_chg
            FROM
              (
                SELECT
                  prov_nm,
                  sum(gsm_pay_tax) gsm_pay_tax,
                  sum(gsm_pay_chg) gsm_pay_chg,
                  sum(vlt_pay_tax) vlt_pay_tax,
                  sum(vlt_pay_chg) vlt_pay_chg,
                  sum(iot_pay_tax) iot_pay_tax,
                  sum(iot_pay_chg) iot_pay_chg,
                  sum(gsm_get_tax) gsm_get_tax,
                  sum(gsm_get_chg) gsm_get_chg,
                  sum(vlt_get_tax) vlt_get_tax,
                  sum(vlt_get_chg) vlt_get_chg,
                  sum(iot_get_tax) iot_get_tax,
                  sum(iot_get_chg) iot_get_chg,
                  sum(sttl) sttl
                FROM
                  (
                    SELECT
                      prov_nm,
                      nm,
                      hm_prov_cd,
                      tsort1,
                      gsm_pay_chg - Round(gsm_pay_chg /(1 + 0.1), 2) gsm_pay_tax,
                      gsm_pay_chg,
                      vlt_pay_chg - Round(vlt_pay_chg /(1 + 0.11), 2) vlt_pay_tax,
                      vlt_pay_chg,
                      iot_pay_chg - Round(iot_pay_chg /(1 + 0.1), 2) iot_pay_tax,
                      iot_pay_chg,
                      gsm_get_chg - Round(gsm_get_chg /(1 + 0.1), 2) gsm_get_tax,
                      gsm_get_chg,
                      vlt_get_chg - Round(vlt_get_chg /(1 + 0.11), 2) vlt_get_tax,
                      vlt_get_chg,
                      iot_get_chg - Round(iot_get_chg /(1 + 0.1), 2) iot_get_tax,
                      iot_get_chg,
                      gsm_get_chg + vlt_get_chg + iot_get_chg - gsm_pay_chg - vlt_pay_chg - iot_pay_chg sttl
                    FROM
                      (
                        SELECT
                          prov.hm_prov_cd,
                          prov.vstd_prov_cd,
                          prov.prov_nm,
                          prov.nm,
                          prov.tsort1,
                          prov.tsort2,
                          round(nvl(gsm_pay.rm_chg, 0), 2) gsm_get_chg,
                          round(nvl(gsm_get.rm_chg, 0), 2) gsm_pay_chg,
                          round(nvl(iot_pay.rm_chg, 0), 2) iot_get_chg,
                          round(nvl(iot_get.rm_chg, 0), 2) iot_pay_chg,
                          round(nvl(vlt_pay.rm_chg, 0), 2) vlt_get_chg,
                          round(nvl(vlt_get.rm_chg, 0), 2) vlt_pay_chg
                        FROM
                          gsm_table gsm_get,
                          gsm_table gsm_pay,
                          iot_table iot_get,
                          iot_table iot_pay,
                          vlt_table vlt_get,
                          vlt_table vlt_pay,
                          (
                            SELECT
                              *
                            FROM
                              (
                                SELECT
                                  a.prov_cd hm_prov_cd,
                                  b.prov_cd vstd_prov_cd,
                                  a.prov_nm,
                                  b.prov_nm nm,
                                  a.prov_cd || '-' || b.prov_cd getcd,
                                  b.prov_cd || '-' || a.prov_cd paycd,
                                  a.tsort tsort1,
                                  b.tsort tsort2
                                FROM
                                  (
                                    SELECT
                                      *
                                    FROM
                                      (
                                        SELECT
                                          p.prov_cd,
                                          p.prov_nm,
                                          0 tsort
                                        FROM
                                          mcbdba.provinces p
                                        UNION ALL
                                          SELECT
                                            To_number (e.enum_key),
                                            e.enum_value,
                                            1 tsort
                                          FROM
                                            gsmdba.enum e
                                          WHERE
                                            e.enum_attr = 'IOT_PROV_TYPE'
                                      )
                                    ORDER BY
                                      tsort,
                                      prov_cd
                                  ) a,
                                  (
                                    SELECT
                                      *
                                    FROM
                                      (
                                        SELECT
                                          p.prov_cd,
                                          p.prov_nm,
                                          0 tsort
                                        FROM
                                          mcbdba.provinces p
                                        UNION ALL
                                          SELECT
                                            To_number (e.enum_key),
                                            e.enum_value,
                                            1 tsort
                                          FROM
                                            gsmdba.enum e
                                          WHERE
                                            e.enum_attr = 'IOT_PROV_TYPE'
                                      )
                                    ORDER BY
                                      tsort,
                                      prov_cd
                                  ) b
                                WHERE
                                  a.prov_cd <> b.prov_cd
                              )
                            ORDER BY
                              tsort1,
                              hm_prov_cd,
                              tsort2,
                              vstd_prov_cd
                          ) prov
                        WHERE
                          1 = 1
                        AND prov.getcd = gsm_get.cd (+)
                        AND prov.paycd = gsm_pay.cd (+)
                        AND prov.getcd = iot_get.cd (+)
                        AND prov.paycd = iot_pay.cd (+)
                        AND prov.getcd = vlt_get.cd (+)
                        AND prov.paycd = vlt_pay.cd (+)
                      )
                  )
                GROUP BY
                  tsort1,
                  hm_prov_cd,
                  prov_nm
                ORDER BY
                  tsort1,
                  hm_prov_cd,
                  prov_nm
              )
          )
      ) t
  