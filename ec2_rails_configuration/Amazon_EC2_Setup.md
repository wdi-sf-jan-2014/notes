# Ruby on Rails on EC2 - Getting Started

------

###Create an Instance

Go to the AWS management console and create a new EC2 instance.  We will be using ubuntu and, for the sake of learning, an instance in the free tier.  When the instance is being created, __download the security key__.  In the example below, the key is called __myinstance.pem__.  You may call it anything you like.

```
chmod 600 ~/myinstance.pem
ssh -i ~/myinstance.pem ubuntu@ec2-x-x-x-x.compute-1.amazonaws.com 
sudo apt-get update
sudo apt-get install ruby-full build-essential

ruby -v

sudo apt-get install rubygems

```

Add following line to ~/.gemrc to avoid installing gem doc files with `vim ~/.gemrc`

```
gem: --no-ri --no-rdoc
```

Then back to the command line, keep installing

```
sudo gem install rails
sudo apt-get install nodejs npm
sudo apt-get install libsqlite3-dev
sudo gem install sqlite3
```

#### Postgresql: Install and configure

```

sudo apt-get install postgresql
sudo apt-get install libpq-dev
sudo gem install pg

sudo -u postgres createuser --superuser $USER
sudo -u postgres psql postgres

\password ubuntu
\q
createdb $USER
```

Make changes to /etc/postgresql/9.1/main/pg_hba.conf (authetification methods).  Scroll all the way to the bottom and look under the line that mentions IPV4.  

```
*Edit this line*
host    all         all       127.0.0.1/32       md5

*To look like this*
host    all         all       127.0.0.1/32       trust
```
Now restart postgres to pick up the configuration change:

```
sudo service postgresql restart
```

###Start a rails project

```
cd /var
mkdir www
sudo chown ubuntu:ubuntu www

rails new blog -d postgresql
rails g controller Blog index --no-test-framework
```
Also add the root route to ```config/routes.rb```

```
root 'blog#index'
```

Next ```cd``` into the newly created app directory and configure the database.  The user for the database will need to be changed to ubuntu

```
vim config/database.yml
```
Also, you must create the database for production in postgres

```
psql
create database blog_production
\q
```

Update ~/.bash_profile to use production environment

```
export RAILS_ENV=production
```

Use ```source``` to update the currently running environment with the changes in ~/.bash_profile

```
source ~/.bash_profile
```

Veryify that ```RAILS_ENV``` exists in your environment:

```
echo $RAILS_ENV
```

Start rails!

```
rails s
```
Verify that the server is up and running:

```
curl localhost:3000
```
This should return the default ruby on rails splash page.  In order to get the website visible to the public, a little more work is needed.


------

###Server Setup
There are two main open source servers that are popular.  Apache and Nginx.  This guide will use Nginx.  Setup steps are similar for Apache.

```
sudo apt-get install nginx
```

Configure a vhost in /etc/nginx/sites-available. 

__Note__ ec2-x-x-x-x.compute-1.amazonaws.com must be replaced with your instance's domain name

```
sudo vim /etc/nginx/sites-available/ec2-x-x-x-x.compute-1.amazonaws.com
```

Copy the following configuration into the newly created file:

```
upstream myblog {
        server  127.0.0.1:3000;
}
server {
        listen  80;
        server_name     ec2-x-x-x-x.compute-1.amazonaws.com;
        access_log      /var/www/blog/log/access.log;
        error_log       /var/www/blog/log/error.log;
        root            /var/www/blog/public;
        index           index.html;

        location / {
                proxy_set_header  X-Real-IP  $remote_addr;
                proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header  Host $http_host;
                proxy_redirect  off;
                try_files /system/maintenance.html $uri $uri/index.html $uri.html @ruby;
        }

        location @ruby {
                proxy_pass http://myblog;
        }
}
```

__NOTE__: In a production setup with a real domain, you will replace all instances of __ec2-x-x-x-x.compute-1.amazonaws.com__ with __www.yourproductiondomain.com__.  That includes the file name that was created.



Next, create a symbolic link to the config file in the enabled sites directory:


```
sudo ln -nfs /etc/nginx/sites-available/ec2-x-x-x-x.compute-1.amazonaws.com /etc/nginx/sites-enabled/ec2-x-x-x-x.compute-1.amazonaws.com

sudo service nginx start
```

Adjust EC2 security group to allow port 80 (normal http)


```
http://ec2-x-x-x-x.compute-1.amazonaws.com:80/
```

And then start rails to see if it works!

```
rails s
```

When ready for production, run it as a daemon and log out

```
rails s -d
```


----

Nginx log files are located in /var/log/nginx/error.log

To find your rails processes and end the daemon:

```
ps aux | grep rails
```

which might return a line that looks something like this:

```
ubuntu   23174  0.0  7.1 195556 43428 ?        Sl   16:20   0:00 /usr/bin/ruby1.9.1 script/rails
```

The number right after ubuntu (23174) is your server process id.  To end it,

```
sudo kill -9 23174
```

## Deploying an Existing Application

The process for deploying an existing application is very similar to the steps above.  The main difference is that the app needs to be cloned from the git repo into EC2.

```
sudo apt-get install git
cd /var/www
git clone <project repo>
```
You will most likely have a production branch that should be checked out and used in a production deployment.  The steps after this point are largely similar.  Just replace the blog app with your own app.

#####Exercise

Clone a repo from an existing project.  Get it working on EC2.

## Capistrano

Capistrano helps automate the deployment process.  The process described above contains some manual steps that are error prone.  Instead, you can let capistrano manage the deployment for you and keep track of versioning.



------

#Resources
#####Rails on Ubuntu
- [http://www.frontcoded.com/rails-on-amazon-ec2-ubuntu.html](http://www.frontcoded.com/rails-on-amazon-ec2-ubuntu.html)
- [http://docs.aws.amazon.com/opsworks/latest/userguide/workinglayers-rails.html](http://docs.aws.amazon.com/opsworks/latest/userguide/workinglayers-rails.html)

#####PostgreSQL
- [http://xtremekforever.blogspot.com/2011/05/setup-rails-project-with-postgresql-on.html](http://xtremekforever.blogspot.com/2011/05/setup-rails-project-with-postgresql-on.html)

#####NginX
- [http://kvz.io/blog/2010/09/21/ruby-with-nginx-on-ubuntu-lucid/](http://kvz.io/blog/2010/09/21/ruby-with-nginx-on-ubuntu-lucid/)
- [https://www.digitalocean.com/community/articles/how-to-install-rails-and-nginx-with-passenger-on-ubuntu](https://www.digitalocean.com/community/articles/how-to-install-rails-and-nginx-with-passenger-on-ubuntu)

#####Capistrano
* [Capistrano Documentation](http://capistranorb.com/)
* [Beanstalk Guide on Deploying with Capistrano](http://guides.beanstalkapp.com/deployments/deploy-with-capistrano.html)
* [Rails 4 Capistrano Deployment Steps](http://robmclarty.com/blog/how-to-deploy-a-rails-4-app-with-git-and-capistrano)


