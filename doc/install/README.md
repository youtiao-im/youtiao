## 0. Important Notes

This installation guide was created for and tested on **CentOS 7** operating systems. It will not install Youtiao app, but only make a node ready for Capistrano deployment.


## 1. Add System Users

```shell
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

**Important:** `node_name` should be something like `youtiao-1`.


## 2. Install Packages / Dependencies

```shell
sudo yum update
sudo yum install epel-release
sudo yum install vim git postfix
sudo chkconfig postfilx on
```


## 3. Install Postgresql 9.4 Client

```shell
# in [base] and [updates] sections, append: exclude=postgresql*
sudo vim /etc/yum.repos.d/CentOS-Base.repo

# add postgresql repo
sudo yum localinstall http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-1.noarch.rpm

# install postgresql 9.4
sudo yum install postgresql94 postgresql94-devel
echo 'pathmunge /usr/pgsql-9.4/bin' > /etc/profile.d/pg94.sh
```


## 4. Install Ruby & Bundler

```shell
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

```shell
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

```shell
mkdir -p ~/youtiao/shared/

# add values for SECRET_KEY_BASE, DATABASE_HOST, DATABASE_PASSWORD, HASHIDS_SALT
vim ~/youtiao/shared/.env
```

**Important:** these environment variables must be kept 100% secret. Please do consult dev@youtiao.im for their values.


## 7. (Web Node Only) Install nginx

```shell
# install nginx
sudo yum install nginx

# configure nginx
sudo vim /etc/nginx/nginx.conf

# start nginx on startup
sudo chkconfig nginx on

# start nginx
sudo service nginx start
```

[Here](nginx.conf) is an example `nginx.conf`.
