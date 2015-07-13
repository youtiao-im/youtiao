## 0. Important Notes

This installation guide was created for and tested on **CentOS 7** operating systems.


## 1. Install Packages / Dependencies

```
# run as root!
yum update
yum install epel-release
yum install vim git
```


## 2. Install Postgresql 9.4 Client


```
vim /etc/yum.repos.d/CentOS-Base.repo
# in [base] and [updates] sections, append: exclude=postgresql*
yum localinstall http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-1.noarch.rpm
yum list postgres*
yum install postgresql94 postgresql94-devel
```


## 3. Add System Users

```
# run as root!
adduser deploy
su deploy
```


## 3. Install Ruby

The recommended way to install Ruby is through [rbenv](https://github.com/sstephenson/rbenv).

```
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable
```

Restart your shell so that PATH changes take effect.

```
rbenv install 2.2.2
rbenv local 2.2.2
```


## 4. Install Bower


## 4. Create Environment Variables


## 5. Add Github Deploy Keys




## 7. Add Systemd Script

```
[Unit]
Description=Youtiao Unicorn Server

[Service]
User=deploy
WorkingDirectory=/home/deploy/apps/youtiao/current
Environment=RAILS_ENV=production
SyslogIdentifier=youtiao-unicorn
PIDFile=/home/deploy/apps/youtiao/shared/tmp/pids/unicorn.pid

ExecStart=/usr/bin/bundle exec "unicorn_rails -c /home/deploy/apps/youtiao/current/config/unicorn.rb -E production"
ExecStop=/usr/bin/kill -QUIT $MAINPID
ExecReload=/usr/bin/kill -USR2 $MAINPID

[Install]
WantedBy=multi-user.target
```

## 8. Deploy


## 6. Install and Configure Nginx

```
server {
    listen 3000;
    server_name youtiao.im;
    root /home/deploy/apps/youtiao/current/public;
    try_files $uri/index.html $uri.html $uri @unicorn;
    location @unicorn {
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_redirect off;
        proxy_pass http://localhost:8080;
    }
}
```
