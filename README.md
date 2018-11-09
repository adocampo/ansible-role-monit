Monit
========

Ansible role for configuring Monit. Sample usage see [example.yml](http://github.com/pgolm/ansible-playbook-monit/blob/master/example.yml).

Install
-------
Install this role with [ansible-galaxy](https://galaxy.ansible.com/pgolm/monit/).

```shell
$ ansible-galaxy install pgolm.monit
```

## Requirements
You'll need to have monit already installed; either through your system's package manager or through [Installing Monit from Source](https://github.com/jpartain89/ansible_monit_from_source)

# Role Variables

* `monit_cycle`: Time between checks in seconds. Defaults to `120`
* `monit_log_destination`: Where the log will be written. Can be a path to a file or "syslog", which will write to syslog daemon. Defaults to `/var/log/monit.log`
* `monit_state_file`: State file path. Defaults to `/var/lib/monit/state`
* `monit_id_file`: Id file path. Defaults to `/var/lib/monit/id`
* `monit_eventqueue_dir`: Event queue directory path. It is only used when this variable is defined. Defaults to `/var/lib/monit/events`
* The `monit_eventqueue_dir` is only necessary if you are going to be using [M/Monit](https://mmonit.com)
* `monit_eventqueue_slots`: Event queue slots. It is only used when `monit_eventqueue_dir` is defined. Defaults to `1000`
* `monit_mmonit_address`: The web address of your M/Monit instance to send the events to
* `monit_services`: List of hashes of services to be monitorized by monit
* `parent_monit_services`: Same list, but as a master list, if your machines share any definitions
  * `name`: Name of the process or host
  * `type`: Type of monitorization:
      * `process`
      * `process_by_name`
      * `file`
      * `fifo`
      * `host`
      * `filesystem`
      * `directory`
      * `program`
      * `network`
      * `network_by_interface`
      * `system` - This item will run a check on the `target` that you specify, not the `name`
  * `target`: Target of monitorization. Should be a pidfile, processname, an address or undefined, depending on the `type` of service
  * `start`: Command that starts the service. Optional
  * `stop`: Command that stop the service. Optional
  * `restart`: Command that restarts the service
  * `user`: Linux username of the user starting the program. Optional
  * `group`: Linux group of the user starting the program. Optional
  * `rules`: List of rules to be included in this service. Optional

For those of you who are wondering about using `depends` lines in your config files, you can write the dependency with the title in the above rule line, but then you'll need to create a new rule dictionary entry that will consequently create another file. As long as the `names` match, monit will know.

* `monit_service_delete_unlisted`: Remove existing service monitorization configurations not declared in the `services`. Defaults to `true`
* `monit_start_monitors`: Start configured `services`. Defaults to `true`.
* `monit_mail_enabled`: Enable mail alerts. Defaults to `false`
* `monit_mailserver_host`: Mailserver host address. Defaults to `localhost`
* `monit_mailserver_port`: Mailserver host port. Defaults to `25`
* `monit_mailserver_user`: Username for authentication on mailserver. Optional
* `monit_mailserver_password`: Password for authentication on mailserver Optional
* `monit_mailserver_timeout`: Timeout for mailserver connection. Defaults to `5`
* `monit_mailserver_ssl_version`: If defined, monit will use this algorithm for SSL connection to the mail server. Possible values are `SSLAUTO`, `SSLV2`, `SSLV3`, `TLSV1`, `TLSV11`, `TLSV12`
* `monit_alert_addresses`: List of mail addresses where the alerts will be sent to
* `monit_alert_mail_format`: A hash of options for mail-format
  * `from`: Sender mail address
  * `reply-to`: A reply-to mail address
  * `subject`: Mail subject
  * `message`: Mail message body
* `monit_webinterface_enabled`: Enable monit web interface. Defaults to `true`
* `monit_webinterface_bind`: IP address to bind web interface. Defaults to `0.0.0.0` (listen for external requests)
* `monit_webinterface_port`: Port for web interface. Defaults to `2812`
* `monit_webinterface_acl_rules`: List of ACL rules for the web interface, such as `localhost`, `username:password`, `@groupname`. It is only applied when defined and is empty by default. You should probably define at least one for the httpd service to start
* `monit_mailserver_password`: Password for authentication on mailserver. Optional
* `monit_mailserver_timeout`: Timeout for mailserver connection. Defaults to `5`.
* `monit_mailserver_ssl_version`: If defined, monit will use this algorithm for SSL connection to the mail server. Possible values are `SSLAUTO`, `SSLV2`, `SSLV3`, `TLSV1`, `TLSV11`, `TLSV12`.
* `monit_alert_addresses`: List of mail addresses where the alerts will be sent to.
* `monit_alert_mail_format`: A hash of options for mail-format.
  * `from`: Sender mail address.
  * `reply-to`: A reply-to mail address.
  * `subject`: Mail subject.
  * `message`: Mail message body.
* `monit_webinterface_enabled`: Enable monit web interface. Defaults to `true`.
* `monit_webinterface_bind`: IP address to bind web interface. Defaults to `0.0.0.0` (listen for external requests).
* `monit_webinterface_port`: Port for web interface. Defaults to `2812`.
* `monit_webinterface_rw_group`: Define group of users allowed to read and write on web interface. It is only applied when defined and is empty by default.
* `monit_webinterface_r_group`: Define group of users allowed to read on web interface. It is only applied when defined and is empty by default.
* `monit_webinterface_acl_rules`: List of ACL rules for the web interface, such as "localhost" or "hauk:password". It is only applied when defined and is empty by default. You should probably define at least one for the httpd service to start.

## Custom Facts
The following variables are used for the logic of the role and should not be changed by the users.

* `monit_unstartable_monitors`: Config files present in `/etc/monit/conf.d` that are not actually monitors and, as such, should no be started by our role when `monit_start_monitors` is true.

Slack Integration
-------------------

You can use a custom webhook to post alerts to slack


  `monit_slack_webhook`:  - whether or not to put up the custom slack integration
  `monit_slack_webhook_key`: '' - the webhook key generated by slack
  `monit_slack_channel`: 'general' - the channel you want to post to

Then in any monitor add a line such as:
   - "if failed port 8080 then exec '/usr/bin/ruby /etc/monit/slack.rb'"

Custom facts
------------

This role writes a `monit_services_configured` on `/etc/ansible/facts.d/monit.fact` in order to keep track of the configured monitors between different plays. This helps us removing unused monitors.

## LICENSE

MIT

## CONTRIBUTORS

The below contributors are from the prior project. Keeping the list here for posterity.

* [Amnay](https://github.com/amnay-mo)
* [Anthony Dmitriyev](https://github.com/antstorm)
* [byteshiva](http://byteshiva.github.io/)
* [Eduardo de Vera Toquero](https://github.com/etux)
* [Jordi Clariana](https://github.com/jordiclariana)
* [Manuel Tiago Pereira](http://mtpereira.github.io/)
* [Markus Klepp](https://github.com/kh0r)
* [Panagiotis Moustafellos](https://github.com/pmoust)
* [Peter Golm](https://github.com/pgolm)
* [Romain Gonord](https://github.com/astik)
* [Roozbeh Farahbod](https://github.com/roozbehf)
* [Svend Vanderveken](https://github.com/svendx4f)
* [Tom Naessens](https://github.com/Silox)
* [vkill](https://github.com/vkill)
