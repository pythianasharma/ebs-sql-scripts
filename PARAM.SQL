select fcpl.user_concurrent_program_name
    , fcp.concurrent_program_name
    , fcp.concurrent_program_id
    , fav.application_short_name
    , fav.application_name
    , fav.application_id
    , fdfcuv.end_user_column_name
    , fdfcuv.form_left_prompt prompt
    , fdfcuv.enabled_flag
    , fdfcuv.required_flag
    , fdfcuv.display_flag
from   fnd_concurrent_programs fcp
    , fnd_concurrent_programs_tl fcpl
    , fnd_descr_flex_col_usage_vl fdfcuv
    , fnd_application_vl fav
where  fcp.concurrent_program_id = fcpl.concurrent_program_id
and    fcpl.user_concurrent_program_name = ''
and    fav.application_id=fcp.application_id
and    fcpl.language = 'US'
and    fdfcuv.descriptive_flexfield_name = '$SRS$.' || fcp.concurrent_program_name;


select fcpl.user_concurrent_program_name
     , fcp.concurrent_program_name
     , fav.application_short_name
     , fav.application_name
     , fav.application_id
     , fdfcuv.end_user_column_name
     , fdfcuv.form_left_prompt prompt
     , fdfcuv.enabled_flag
     , fdfcuv.required_flag
     , fdfcuv.display_flag
     , fdfcuv.flex_value_set_id
     , ffvs.flex_value_set_name
     , flv.meaning default_type
     , fdfcuv.default_value
from   fnd_concurrent_programs fcp
     , fnd_concurrent_programs_tl fcpl
     , fnd_descr_flex_col_usage_vl fdfcuv
     , fnd_flex_value_sets ffvs
     , fnd_lookup_values flv
     , fnd_application_vl fav
where  fcp.concurrent_program_id = fcpl.concurrent_program_id
and    fcpl.user_concurrent_program_name = ''
and    fcpl.language = 'us'
and    fav.application_id=fcp.application_id
and    fdfcuv.descriptive_flexfield_name = '$SRS$.' || fcp.concurrent_program_name
and    ffvs.flex_value_set_id = fdfcuv.flex_value_set_id
and    flv.lookup_type(+) = 'flex_default_type'
and    flv.lookup_code(+) = fdfcuv.default_type
and    flv.language(+) = userenv ('lang');
