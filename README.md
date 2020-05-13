sshd
====

Ansible role to install ssh server and manage its configuration. It is likely that the role will work on any Debian,
RedHat or Archlinux based operating systems, however at the moment it was tested only on:

- Debian 9.x
- CentOS 7.x
- ArchLinux 20200505

## <a name="variables"></a> Role Variables
All variable names in fact duplicate ones from sshd_config file. However, sshd does not understand booleans, so all
values must be submitted as strings (except lists). Make sure to properly quote them

### General sshd settings:
| Name                | Default value | Description             |
| ------------------- | ------------- | ----------------------- |
| sshd_listen_address | 0.0.0.0       | An address to listen on |
| sshd_port           | 22            | Port to listen on       |
| sshd_log_level      | INFO          | Level of verbosity. Supports QUIET, FATAL, ERROR, INFO, VERBOSE, DEBUG, DEBUG1, DEBUG2, and DEBUG3 |

### Encryption related setting:
| Name                     | Default value                        | Description                            |
| ------------------------ | ------------------------------------ | -------------------------------------- |
| sshd_ciphers             | \[ 'chacha20-poly1305@openssh.com', 'aes256-gcm@openssh.com' \] | List of accepted Ciphers |
| sshd_kex_algorithms      | \[ 'curve25519-sha256@libssh.org' \] | List of accepted KEX algorithms        |
| sshd_host_key_algorithms | \[ 'ssh-ed25519', 'ssh-rsa' \]       | List of accepted Host Key algorithms   |
| sshd_pubkey_accepted_key_types | [ 'ssh-ed25519', 'ssh-rsa'     | List of accpeted Client Key algorithms |

### Authentication related settings:
| Name                           | Default value  | Description                |
| ------------------------------ | -------------- | -------------------------- |
| sshd_login_grace_time          | '30'           | LoginGraceTime value       |
| sshd_client_alive_interval     | '300'          | ClientAliveInterval value  |
| sshd_client_alive_countMax     | '0'            | ClientAliveCountMax value  |
| sshd_allow_tcp_forwarding      | 'no'           | AllowTcpForwarding value. Might be useful for bastion hosts |
| sshd_allow_agent_forwarding    | 'no'           | AllowAgentForwarding value |
| sshd_permit_empty_passwords    | 'no'           | PermitEmptyPasswords value |
| sshd_max_auth_tries            | '3'            | MaxAuthTries value         |
| sshd_challenge_response_authentication | 'no'   | Whether or not challenge password authentication should be enabled |
| sshd_permit_root_login         | 'no'           | Whether or not login as root is permitted |
| sshd_pubkey_authentication     | 'yes'          | Whether or not public key based authentication should be enabled |
| sshd_password_authentication   | 'no'           | Whether or not password authentication should be enabled |
| sshd_host_based_authentication | 'no'           | Whether or not host based authentication should be enabled |
| sshd_permit_user_environment   | 'no'           | Whether or not permit users to pass their environment variables |
| sshd_max_startups              | '3'            | MaxStartups value          |
| sshd_max_sessions              | '1'            | MaxSessions value          |
| sshd_ignore_rhosts             | 'yes'          | Whether or not ignore rhosts files |
| sshd_allow_users               | \[\]           | List of users allowed to connect |
| sshd_allow_groups              | \[\]           | List of group allowed to connect |
| sshd_deny_users                | \[ 'nobody' \] | List of users explicitly prohibited from connecting |
| sshd_deny_groups               | \[ 'root', 'daemon' \] | List of groups explicitly prohibited from connecting |
| sshd_use_pam                   | 'yes'          | Whether or not to use PAM  |
| sshd_login_banner_content      | <<HEREDOC      | A text being displayed when user tries to authenticate against a server |

### Libwrap relationship
The role supports managing /etc/hosts.allow and /etc/hosts.deny if sshd is compiled with libwrap. Use following variables
to address the issue:

| Name             | Default value  | Description                |
| ---------------- | -------------- | -------------------------- |
| sshd_hosts_allow | \[\]           | Hosts and network to allow |
| sshd_hosts_deny  | \[\]           | Hosts and network to deny. Usually set to "ALL" |

## <a name="dependencies"></a> Dependencies
This role does not have any specific dependencies

## <a name="example"></a> Playbook Example
```yaml
- hosts: bastion
  become: true
  roles:
    - role: sshd
      vars:
        sshd_allow_tcp_forwarding: 'yes'
      tags:
        - sshd
        - ssh
```

## <a name="license"></a> License
The role is distributed under [MIT License](LICENSE.txt). Please make sure you have read, understood and agreed to it
terms and conditions

## <a name="author"></a> Author Information
Vladimir Tiukhtin <vladimir.tiukhtin@hippolab.ru>
