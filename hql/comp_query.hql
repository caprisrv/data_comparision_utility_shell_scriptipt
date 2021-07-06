drop table if exists productreporting_qa.qa_std_retro_offer_data;
create table productreporting_qa.qa_std_retro_offer_data as
select 
report_date
,offer_identifier
,app_identifier
,consumer_identifier
,offer_type_code
,offer_type_description
,promo_identifier
,product_identifier
,sub_product_identifier
,accepted_offer_flag
,offer_good_until_date
,rescindable_days
,rescinded_date
,amount
,rate
,origination_fee_amount
,origination_fee_rate
,account_number
,account_num_assigned_date_time
,annual_fee_amount
,annual_fee_waived_mm
,late_fee_percent
,late_fee_minimum_amount
,offer_date_time
,period_id
,first_payment_due_date
,contract_date
,account_expiration_date from productreporting_qa.pankaj_nov_std_retro_t_argus_offer_data where report_date='2018-11-01' order by consumer_identifier;


alter table productreporting_qa.qa_std_retro_offer_data set tblproperties('serialization.null.format'='null');
drop table if exists productreporting_qa.dev_std_retro_offer_data;
create table productreporting_qa.dev_std_retro_offer_data as 
select report_date
,offer_identifier
,app_identifier
,consumer_identifier
,offer_type_code
,offer_type_description
,promo_identifier
,product_identifier
,sub_product_identifier
,accepted_offer_flag
,offer_good_until_date
,rescindable_days
,rescinded_date
,amount
,rate
,origination_fee_amount
,origination_fee_rate
,account_number
,account_num_assigned_date_time
,annual_fee_amount
,annual_fee_waived_mm
,late_fee_percent
,late_fee_minimum_amount
,offer_date_time
,period_id
,first_payment_due_date
,contract_date
,account_expiration_date from cobrand.cbpr_rpt_offer_level_data_fnl_36mon_lowes where report_date='2018-11-01' order by consumer_identifier;


alter table productreporting_qa.dev_t_argus_offer_data set tblproperties('serialization.null.format'='null');
DROP TABLE IF EXISTS productreporting_qa.test_std_offer_result_1;CREATE  TABLE productreporting_qa.test_std_offer_result_1 as SELECT a.consumer_identifier, 
IF ((a.report_date) != (b.report_date), (a.report_date), '=') report_date_1 , IF ((a.report_date )!= (b.report_date),(b.report_date), '=') report_date_2 ,
IF ((a.offer_identifier) != (b.offer_identifier), (a.offer_identifier), '=') offer_identifier_1 , IF ((a.offer_identifier )!= (b.offer_identifier),(b.offer_identifier), '=') offer_identifier_2 ,
IF ((a.app_identifier) != (b.app_identifier), (a.app_identifier), '=') app_identifier_1 , IF ((a.app_identifier )!= (b.app_identifier),(b.app_identifier), '=') app_identifier_2 ,
IF ((a.consumer_identifier) != (b.consumer_identifier), (a.consumer_identifier), '=') consumer_identifier_1 , IF ((a.consumer_identifier )!= (b.consumer_identifier),(b.consumer_identifier), '=') consumer_identifier_2 ,
IF ((a.offer_type_code) != (b.offer_type_code), (a.offer_type_code), '=') offer_type_code_1 , IF ((a.offer_type_code )!= (b.offer_type_code),(b.offer_type_code), '=') offer_type_code_2 ,
IF ((a.offer_type_description) != (b.offer_type_description), (a.offer_type_description), '=') offer_type_description_1 , IF ((a.offer_type_description )!= (b.offer_type_description),(b.offer_type_description), '=') offer_type_description_2 ,
IF ((a.promo_identifier) != (b.promo_identifier), (a.promo_identifier), '=') promo_identifier_1 , IF ((a.promo_identifier )!= (b.promo_identifier),(b.promo_identifier), '=') promo_identifier_2 ,
IF ((a.product_identifier) != (b.product_identifier), (a.product_identifier), '=') product_identifier_1 , IF ((a.product_identifier )!= (b.product_identifier),(b.product_identifier), '=') product_identifier_2 ,
IF ((a.sub_product_identifier) != (b.sub_product_identifier), (a.sub_product_identifier), '=') sub_product_identifier_1 , IF ((a.sub_product_identifier )!= (b.sub_product_identifier),(b.sub_product_identifier), '=') sub_product_identifier_2 ,
IF ((a.accepted_offer_flag) != (b.accepted_offer_flag), (a.accepted_offer_flag), '=') accepted_offer_flag_1 , IF ((a.accepted_offer_flag )!= (b.accepted_offer_flag),(b.accepted_offer_flag), '=') accepted_offer_flag_2 ,
IF ((a.offer_good_until_date) != (b.offer_good_until_date), (a.offer_good_until_date), '=') offer_good_until_date_1 , IF ((a.offer_good_until_date )!= (b.offer_good_until_date),(b.offer_good_until_date), '=') offer_good_until_date_2 ,
IF ((a.rescindable_days) != (b.rescindable_days), (a.rescindable_days), '=') rescindable_days_1 , IF ((a.rescindable_days )!= (b.rescindable_days),(b.rescindable_days), '=') rescindable_days_2 ,
IF ((a.rescinded_date) != (b.rescinded_date), (a.rescinded_date), '=') rescinded_date_1 , IF ((a.rescinded_date )!= (b.rescinded_date),(b.rescinded_date), '=') rescinded_date_2 ,
IF ((a.amount) != (b.amount), (a.amount), '=') amount_1 , IF ((a.amount )!= (b.amount),(b.amount), '=') amount_2 ,
IF ((a.rate) != (b.rate), (a.rate), '=') rate_1 , IF ((a.rate )!= (b.rate),(b.rate), '=') rate_2 ,
IF ((a.origination_fee_amount) != (b.origination_fee_amount), (a.origination_fee_amount), '=') origination_fee_amount_1 , IF ((a.origination_fee_amount )!= (b.origination_fee_amount),(b.origination_fee_amount), '=') origination_fee_amount_2 ,
IF ((a.origination_fee_rate) != (b.origination_fee_rate), (a.origination_fee_rate), '=') origination_fee_rate_1 , IF ((a.origination_fee_rate )!= (b.origination_fee_rate),(b.origination_fee_rate), '=') origination_fee_rate_2 ,
IF ((a.account_number) != (b.account_number), (a.account_number), '=') account_number_1 , IF ((a.account_number )!= (b.account_number),(b.account_number), '=') account_number_2 ,
IF ((a.account_num_assigned_date_time) != (b.account_num_assigned_date_time), (a.account_num_assigned_date_time), '=') account_num_assigned_date_time_1 , IF ((a.account_num_assigned_date_time )!= (b.account_num_assigned_date_time),(b.account_num_assigned_date_time), '=') account_num_assigned_date_time_2 ,
IF ((a.annual_fee_amount) != (b.annual_fee_amount), (a.annual_fee_amount), '=') annual_fee_amount_1 , IF ((a.annual_fee_amount )!= (b.annual_fee_amount),(b.annual_fee_amount), '=') annual_fee_amount_2 ,
IF ((a.annual_fee_waived_mm) != (b.annual_fee_waived_mm), (a.annual_fee_waived_mm), '=') annual_fee_waived_mm_1 , IF ((a.annual_fee_waived_mm )!= (b.annual_fee_waived_mm),(b.annual_fee_waived_mm), '=') annual_fee_waived_mm_2 ,
IF ((a.late_fee_percent) != (b.late_fee_percent), (a.late_fee_percent), '=') late_fee_percent_1 , IF ((a.late_fee_percent )!= (b.late_fee_percent),(b.late_fee_percent), '=') late_fee_percent_2 ,
IF ((a.late_fee_minimum_amount) != (b.late_fee_minimum_amount), (a.late_fee_minimum_amount), '=') late_fee_minimum_amount_1 , IF ((a.late_fee_minimum_amount )!= (b.late_fee_minimum_amount),(b.late_fee_minimum_amount), '=') late_fee_minimum_amount_2 ,
IF ((a.offer_date_time) != (b.offer_date_time), (a.offer_date_time), '=') offer_date_time_1 , IF ((a.offer_date_time )!= (b.offer_date_time),(b.offer_date_time), '=') offer_date_time_2 ,
IF ((a.period_id) != (b.period_id), (a.period_id), '=') period_id_1 , IF ((a.period_id )!= (b.period_id),(b.period_id), '=') period_id_2 ,
IF ((a.first_payment_due_date) != (b.first_payment_due_date), (a.first_payment_due_date), '=') first_payment_due_date_1 , IF ((a.first_payment_due_date )!= (b.first_payment_due_date),(b.first_payment_due_date), '=') first_payment_due_date_2 ,
IF ((a.contract_date) != (b.contract_date), (a.contract_date), '=') contract_date_1 , IF ((a.contract_date )!= (b.contract_date),(b.contract_date), '=') contract_date_2 ,
IF ((a.account_expiration_date) != (b.account_expiration_date), (a.account_expiration_date), '=') account_expiration_date_1 , IF ((a.account_expiration_date )!= (b.account_expiration_date),(b.account_expiration_date), '=') account_expiration_date_2 
FROM productreporting_qa.qa_std_retro_offer_data a JOIN productreporting_qa.dev_std_retro_offer_data b on a.consumer_identifier = b.consumer_identifier WHERE 
 (a.report_date) <> (b.report_date) OR 
 (a.offer_identifier) <> (b.offer_identifier) OR 
 (a.app_identifier) <> (b.app_identifier) OR 
 (a.consumer_identifier) <> (b.consumer_identifier) OR 
 (a.offer_type_code) <> (b.offer_type_code) OR 
 (a.offer_type_description) <> (b.offer_type_description) OR 
 (a.promo_identifier) <> (b.promo_identifier) OR 
 (a.product_identifier) <> (b.product_identifier) OR 
 (a.sub_product_identifier) <> (b.sub_product_identifier) OR 
 (a.accepted_offer_flag) <> (b.accepted_offer_flag) OR 
 (a.offer_good_until_date) <> (b.offer_good_until_date) OR 
 (a.rescindable_days) <> (b.rescindable_days) OR 
 (a.rescinded_date) <> (b.rescinded_date) OR 
 (a.amount) <> (b.amount) OR 
 (a.rate) <> (b.rate) OR 
 (a.origination_fee_amount) <> (b.origination_fee_amount) OR 
 (a.origination_fee_rate) <> (b.origination_fee_rate) OR 
 (a.account_number) <> (b.account_number) OR 
 (a.account_num_assigned_date_time) <> (b.account_num_assigned_date_time) OR 
 (a.annual_fee_amount) <> (b.annual_fee_amount) OR 
 (a.annual_fee_waived_mm) <> (b.annual_fee_waived_mm) OR 
 (a.late_fee_percent) <> (b.late_fee_percent) OR 
 (a.late_fee_minimum_amount) <> (b.late_fee_minimum_amount) OR 
 (a.offer_date_time) <> (b.offer_date_time) OR 
 (a.period_id) <> (b.period_id) OR 
 (a.first_payment_due_date) <> (b.first_payment_due_date) OR 
 (a.contract_date) <> (b.contract_date) OR 
 (a.account_expiration_date) <> (b.account_expiration_date)  
; SET hive.cli.print.header=true;select * from productreporting_qa.test_std_offer_result_1;
