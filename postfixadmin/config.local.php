
<?php
// Basic configuration.
$CONF['configured'] = true;
$CONF['postfix_admin_url'] = "/postfixadmin";
$CONF['default_language'] = "en";
$CONF['database_type'] = "mysqli";
$CONF['database_host'] = "localhost";
$CONF['database_user'] = "vmailadmin";
$CONF['database_password'] = "BGKeeM8sm3s0KuLg2MmFJxLxGydkhc";                      # <- REPLACE THIS PASSWORD.
$CONF['database_name'] = "vmail";
$CONF['smtp_server'] = "127.0.0.1";

$CONF['domain_path'] = "YES";
$CONF['domain_in_mailbox'] = "NO";
$CONF['quota'] = "YES";
$CONF['quota_multiplier'] = 1;
$CONF['transport'] = "YES";
$CONF['transport_options'] = array ('dovecot', 'virtual', 'local', 'relay');
$CONF['transport_default'] = "dovecot";

// Enable alias domain.
$CONF['alias_domain'] = 'YES';

// Disable features we don't have.
$CONF['backup'] = "NO";
$CONF['fetchmail'] = "NO";
$CONF['sendmail'] = "NO";
$CONF['show_footer_text'] = "NO";
$CONF['emailcheck_resolve_domain'] = "NO";

// Disable PostfixAdmin style vacation. We use managesieve service instead.
$CONF['vacation_control'] = "NO";
$CONF['vacation_control_admin'] = "NO";
$CONF['admin_email'] = "www@example.com";
?>
