<?php

// SQL DATABASE
$config['db_dsnw'] = 'mysqli://roundcube:5CxgEu109zOEdRIHTbU6WkQvkxmRHm@127.0.0.1/roundcubemail';

// LOGGING
$config['log_driver'] = 'syslog';
$config['syslog_facility'] = LOG_MAIL;

// IMAP
$config['default_host'] = '127.0.0.1';
$config['default_port'] = 143;
$config['imap_auth_type'] = 'LOGIN';
$config['imap_delimiter'] = '/';

// SMTP
$config['smtp_server'] = 'tls://127.0.0.1';
$config['smtp_port'] = 587;
$config['smtp_user'] = '%u';
$config['smtp_pass'] = '%p';
$config['smtp_auth_type'] = 'LOGIN';

// SYSTEM
$config['force_https'] = true;
$config['login_autocomplete'] = 2;
$config['ip_check'] = true;
$config['des_key'] = 'N7Uq709YifYtuS4rih2kvQR9';
$config['useragent'] = 'Roundcube Webmail'; // Hide version number
//$config['username_domain'] = 'test.com.local';
$config['mime_types'] = '/etc/mime.types';

// USER INTERFACE
$config['create_default_folders'] = true;
$config['quota_zero_as_unlimited'] = true;

// USER PREFERENCES
$config['default_charset'] = 'UTF-8';
//$config['addressbook_sort_col'] = 'name';
$config['draft_autosave'] = 60;
$config['preview_pane'] = true;
$config['autoexpand_threads'] = 2;
$config['check_all_folders'] = true;

// PLUGINS
$config['plugins'] = array('managesieve', 'password');

