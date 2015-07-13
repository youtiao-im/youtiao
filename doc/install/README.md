## 0. Important Notes

This installation guide was created for and tested on **CentOS 7** operating systems.


## 1. Add System Users

```
# run as root!

# add user deploy
useradd deploy
passwd deploy

# add deploy to sudoer
vim /etc/sudoers

# run following commands as deploy
su deploy

# generate ssh key pair
ssh-keygen -C deploy@<node_name>

# add authorized ssh keys
vim ~/.ssh/authorized_keys
chmod 644 ~/.ssh/authorized_keys

# copy paste public key to Github Deploy Keys
cat ~/.ssh/id_rsa.pub
```


## 2. Install Packages / Dependencies

```
sudo yum update
sudo yum install epel-release
sudo yum install vim git
```


## 3. Install Postgresql 9.4 Client

```
# in [base] and [updates] sections, append: exclude=postgresql*
sudo vim /etc/yum.repos.d/CentOS-Base.repo

# add postgresql repo
sudo yum localinstall http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-1.noarch.rpm

# install postgresql 9.4
sudo yum install postgresql94 postgresql94-devel
echo 'pathmunge /usr/pgsql-9.4/bin' > /etc/profile.d/pg94.sh
```


## 4. Install Ruby & Bundler

```
# install rvm
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
source ~/.profile

# install ruby
rvm list known
rvm install 2.2.2
/bin/bash --login
rvm use 2.2.2
ruby --version
gem --version

# change gem source
gem source --add https://ruby.taobao.org
gem source --remove https://rubygems.org/

# install bundler
gem install bundler
bundle --version
```


## 5. Install Node.js, npm & bower

```
# install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.25.4/install.sh | bash
source ~/.bashrc

# install node.js
nvm ls-remote
nvm install stable
nvm alias default stable
node --version
npm --version

# install bower
npm install -g bower
bower --version
```


## 6. Create Environment Variables

```
mkdir -p ~/youtiao_production/shared/

# add values for SECRET_KEY_BASE, YOUTIAO_DATABASE_HOST, YOUTIAO_DATABASE_PASSWORD
vim ~/youtiao_production/shared/.env
```


## 7. Add Systemd Script

```
[Unit]
Description=Youtiao Production Unicorn Server

[Service]
User=deploy
WorkingDirectory=/home/deploy/apps/youtiao_production/current
Environment=RAILS_ENV=production
SyslogIdentifier=youtiao-production-unicorn
PIDFile=/home/deploy/apps/youtiao_production/shared/tmp/pids/unicorn.pid

ExecStart=/usr/bin/bundle exec "unicorn_rails -c /home/deploy/apps/youtiao_production/current/config/unicorn.rb -E production"
ExecStop=/usr/bin/kill -QUIT $MAINPID
ExecReload=/usr/bin/kill -USR2 $MAINPID

[Install]
WantedBy=multi-user.target
```


## 6. Install and Configure Nginx

```
server {
    listen 80;
    server_name youtiao.im;
    root /home/deploy/apps/youtiao_production/current/public;
    try_files $uri/index.html $uri.html $uri @youtiao;

    location @youtiao {
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_redirect off;
        proxy_pass http://localhost:8080;
    }
}
```
