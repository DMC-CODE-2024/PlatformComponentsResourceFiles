source ~/.bash_profile
commonConfigurationFile=$commonConfigurationFilePath
dbDecryptPassword=$(java -jar  ${APP_HOME}/encryption_utility/PasswordDecryptor-0.1.jar spring.datasource.password)

mysql  -h$dbIp -P$dbPort -u$dbUsername -p${dbDecryptPassword} $appdbName <<EOFMYSQL

CREATE TABLE IF NOT EXISTS notification (
  id int NOT NULL AUTO_INCREMENT,
  channel_type varchar(20) DEFAULT '',
  created_on timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  feature_id int DEFAULT '0',
  feature_name varchar(50) DEFAULT '',
  feature_txn_id varchar(20) DEFAULT '',
  msg_lang varchar(3) DEFAULT '',
  message varchar(1000) DEFAULT '',
  modified_on timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  receiver_user_type varchar(30) DEFAULT '',
  refer_table varchar(50) DEFAULT '',
  retry_count int DEFAULT '0',
  role_type varchar(30) DEFAULT '',
  status int DEFAULT '0',
  sub_feature varchar(50) DEFAULT '',
  subject varchar(255) DEFAULT '',
  user_id int DEFAULT '0',
  notification_sent_time timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  operator_name varchar(20) DEFAULT '',
  msisdn varchar(20) DEFAULT '',
  email varchar(100) DEFAULT '',
  corelation_id varchar(20) DEFAULT '',
  delivery_status int DEFAULT '0',
  delivery_time timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  send_sms_interface varchar(20) DEFAULT '',
  authority_status int DEFAULT '0',
  check_imei_id int DEFAULT '0',
  attachment varchar(250) DEFAULT '',
  PRIMARY KEY (id)
) ;


CREATE TABLE IF NOT EXISTS cfg_feature_alert (
  id int NOT NULL AUTO_INCREMENT,
  created_on timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  modified_on timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  alert_id varchar(20) DEFAULT '',
  description varchar(250) DEFAULT '',
  feature varchar(30) DEFAULT '',
  PRIMARY KEY (id),
  UNIQUE KEY UNI_CFA (alert_id)
);


 CREATE TABLE IF NOT EXISTS operator_series (
  id int NOT NULL AUTO_INCREMENT,
  series_start int DEFAULT '0',
  series_end int DEFAULT '0',
  series_type varchar(10) DEFAULT '',
  operator_name varchar(20) DEFAULT '',
  user_id int DEFAULT '0',
  created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modified_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  length varchar(10) DEFAULT NULL,
  remarks varchar(250) DEFAULT NULL,
  PRIMARY KEY (id)
);

 CREATE TABLE  IF NOT EXISTS sys_generated_alert (
  id int NOT NULL AUTO_INCREMENT,
  created_on timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  modified_on timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  alert_id varchar(20) DEFAULT '',
  description varchar(250) DEFAULT '',
  status int DEFAULT '0',
  user_id int DEFAULT '0',
  username varchar(50) DEFAULT '',
  ip varchar(20) DEFAULT '',
  priority varchar(20) DEFAULT '',
  feature_name varchar(20) DEFAULT '',
  remarks varchar(250) DEFAULT '',
  server_name varchar(20) DEFAULT '',
  txn_id varchar(50) DEFAULT '',
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS file_to_sync (
  id int NOT NULL AUTO_INCREMENT,
  copy_end_on timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  copy_start_on timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  created_on timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  retry_count int DEFAULT '0',
  status int DEFAULT '0',
  txn_id varchar(50) DEFAULT '',
  source_server_name varchar(50) NOT NULL DEFAULT '',
  source_file_path varchar(255) NOT NULL DEFAULT '',
  source_file_name varchar(70) NOT NULL DEFAULT '',
  dest_server_name varchar(50) NOT NULL DEFAULT '',
  dest_file_path varchar(255) NOT NULL DEFAULT '',
  app_name varchar(70) NOT NULL DEFAULT '',
  server_name varchar(50) DEFAULT '',
  remarks varchar(255) DEFAULT '',
  PRIMARY KEY (id)
);


 CREATE TABLE IF NOT EXISTS aud.modules_audit_trail (
  id int NOT NULL AUTO_INCREMENT,
  created_on timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  modified_on timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  execution_time varchar(50) DEFAULT NULL,
  status_code int DEFAULT '0',
  status varchar(10) DEFAULT '',
  error_message varchar(1000) DEFAULT NULL,
  module_name varchar(50) DEFAULT '',
  feature_name varchar(50) DEFAULT '',
  action varchar(20) DEFAULT '',
  count bigint DEFAULT '0',
  info varchar(255) DEFAULT '',
  server_name varchar(30) DEFAULT '',
  count2 int DEFAULT '0',
  failure_count int DEFAULT '0',
  PRIMARY KEY (id),
  KEY createdOn_idx (created_on),
  KEY module_idx (module_name)
);

CREATE TABLE IF NOT EXISTS aud.audit_trail (
  id int NOT NULL AUTO_INCREMENT,
  browser varchar(255) DEFAULT '',
  created_on timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  details varchar(255) DEFAULT '',
  feature_id int DEFAULT '0',
  feature_name varchar(30) DEFAULT '',
  j_session_id varchar(255) DEFAULT '',
  modified_on timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  public_ip varchar(30) DEFAULT '',
  role_type varchar(30) DEFAULT '',
  sub_feature varchar(50) DEFAULT '',
  txn_id varchar(20) DEFAULT '',
  user_id int DEFAULT '0',
  user_name varchar(50) DEFAULT '',
  user_type varchar(30) DEFAULT '',
  user_type_id int DEFAULT '0',
  PRIMARY KEY (id)
);


alter table file_to_sync rename column remarks to remark;
alter table sys_generated_alert rename column remarks to remark;
alter table notification drop column feature_id ,drop column feature_name ,drop column receiver_user_type,drop column refer_table,drop column role_type  , drop column sub_feature ,drop column user_id,drop column authority_status ,add column  delivery_date_time timestamp  DEFAULT CURRENT_TIMESTAMP ;

  alter table operator_series rename column remarks to remark;

alter table notification add column feature_name varchar(50) DEFAULT '';
EOFMYSQL

