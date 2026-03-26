SELECT DISTINCT
       papf.person_number,
       papf.person_id,
       ppnf.full_name,
       hg.goal_name,
       hg.last_updated_by,
       ppnf_lub.full_name
           AS last_updated_by_name,
       TO_CHAR (hg.last_update_date,
                'dd-mon-yyyy hh24:mi:ss ',
                'nls_date_language = american')
           AS last_update_date,
       peaw.email_address
           AS email
  FROM hrg_goals            hg,
       per_all_people_f     papf,
       per_person_names_f   ppnf,
       per_person_names_f   ppnf_lub,
       per_email_addresses  peaw
 WHERE     1 = 1
       AND papf.person_id = hg.person_id
       AND hg.last_modified_by <> hg.person_id
       AND hg.last_update_date BETWEEN SYSDATE - 1
                                           AND SYSDATE
	   AND hg.GOAL_VERSION_TYPE_CODE NOT IN ('FROZEN') 
       AND papf.person_id = ppnf.person_id
       AND ppnf.name_type = 'GLOBAL'
       AND hg.last_modified_by = ppnf_lub.person_id
       AND ppnf_lub.name_type = 'GLOBAL'
       AND hg.last_modified_by = peaw.person_id(+)
       AND peaw.email_type(+) = 'W1'
       AND TRUNC (SYSDATE) BETWEEN peaw.date_from(+)
                               AND NVL (peaw.date_to(+), TRUNC (SYSDATE))
	   AND TRUNC (SYSDATE) BETWEEN papf.effective_start_date AND papf.effective_end_date
       AND TRUNC(SYSDATE) BETWEEN TRUNC(ppnf.EFFECTIVE_START_DATE) AND TRUNC(ppnf.EFFECTIVE_END_DATE)
       AND TRUNC(SYSDATE) BETWEEN TRUNC(ppnf_lub.EFFECTIVE_START_DATE) AND TRUNC(ppnf_lub.EFFECTIVE_END_DATE)