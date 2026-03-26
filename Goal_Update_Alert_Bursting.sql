SELECT DISTINCT
       PERSON_ID
           KEY,
       'REPORT'
           TEMPLATE,
       'en-US'
           LOCALE,
       'html'
           OUTPUT_FORMAT,
       'EMAIL'
           DEL_CHANNEL,
      EMP_EMAILID PARAMETER1,
      'Email Address'
          PARAMETER3,
       'An Update Was Made to Your Goals in Oracle HCM'
           PARAMETER4,
       NULL
           PARAMETER5,
       'false'
           PARAMETER6

  FROM (SELECT DISTINCT
               papf.person_number,
               papf.person_id,
               per_email.email_address                  emp_emailid,
               panf.first_name || ' ' || panf.last_name emp_full_name,
               panf.first_name
          FROM per_all_people_f     papf,
               hrg_goals            hg,
               per_person_names_f   panf,
               per_email_addresses  per_email
         WHERE     1 = 1
               AND papf.person_id = panf.person_id
               AND papf.person_id = hg.person_id
               AND hg.last_modified_by <> hg.person_id
               AND hg.last_update_date BETWEEN  SYSDATE - 1
                                                   AND SYSDATE
			   AND hg.GOAL_VERSION_TYPE_CODE NOT IN ('FROZEN') --SR824940
               AND panf.name_type = 'GLOBAL'
               AND papf.person_id = per_email.person_id(+)
               AND per_email.email_type(+) = 'W1'
               AND TRUNC (SYSDATE) BETWEEN papf.effective_start_date
                                       AND papf.effective_end_date
               AND TRUNC (SYSDATE) BETWEEN panf.effective_start_date
                                       AND panf.effective_end_date
			   AND TRUNC (SYSDATE) BETWEEN per_email.date_from(+)
                               AND NVL (per_email.date_to(+), TRUNC (SYSDATE))
               AND papf.person_id IN
                       (SELECT DISTINCT ppsvl.person_id
                          FROM per_person_secured_list_v ppsvl
                         WHERE TRUNC (SYSDATE) BETWEEN TRUNC (
                                                           ppsvl.effective_start_date)
                                                   AND TRUNC (
                                                           ppsvl.effective_end_date)))