############################################################
# Dockerfile to build Your Website
############################################################

FROM ubuntu:20.04
# Avoid tz data prompts
ENV TZ=Europe/London
############################################################
# INSTALLS
############################################################
# Get sudo set up
RUN apt-get update && apt-get -y install sudo
# Apache is web server software, redis is a database used to save messages in job queues, supervisor runs processes
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 libapache2-mod-wsgi-py3 supervisor openssl cron \
&& sudo apt install -y redis-server python3.8-venv ffmpeg systemd python3.8 python3-pip pipenv npm && sudo mkdir /var/www/html/align-resume-app
RUN python3 -m pip install pip

#############################################################
## FILES
#############################################################
## Copy files over that come from the github repository
COPY ["run.py", "requirements.txt", "README.md", "/var/www/html/align-resume-app/"]
ADD [".", "/var/www/html/align-resume-app"]
COPY ["apache2.conf", "etc/apache2"]
COPY ["align-resume-app.conf", "/etc/apache2/sites-available"]
#ADD ["tests", "/var/www/html/align-resume-app/tests"]

# Copy over WSGI file that you must have locally
COPY "align-resume-app.wsgi" /var/www/html/align-resume-app/align-resume-app.wsgi

# Copy over Apache website config file
COPY "align-resume-app.conf" /etc/apache2/sites-available/align-resume-app.conf

## Copy over cron directory
COPY /align-resume-app-cron /etc/cron.d/align-resume-app-cron

# Copy over supervisor file - this is going to manage all the processes
#COPY "supervisor.conf" /etc/supervisor/conf.d/supervisor.conf
#---------------------------Tests---------------------------
# clone the repo from git
#RUN set -x \
#    && git clone "https://msimmon2:2d5bb54912dcf75a9e99888372994df7be77ddfc@wwwin-github.cisco.com/A-I/coral-test-automation.git" \
#    && cd coral-test-automation \
#    && git checkout $CORAL_TEST_AUTOMATION_BRANCH

# pull cypress image
#FROM cypress/browsers:node13.6.0-chrome80-ff72
## set up cypress directory for testing
## make directory inside container
#RUN mkdir /app
#WORKDIR /app
## copy cypress code from host to container
#COPY . /app
## execute the tests
#RUN npm install
#RUN $(npm bin)/cypress verify
#RUN $(npm bin)/cypress run --browser firefox
#RUN $(npm bin)/cypress run --browser chrome


#############################################################
## FLASK SET UP
#############################################################
## Set environment variable to production
ENV APP_SETTINGS=production
RUN sudo mkdir /var/www/html/align-resume-app/logs/
RUN sudo touch /var/www/html/align-resume-app/logs/align-resume-app.log
# Create python virtual environment for the web app and install dependencies
RUN python3 -m venv /var/www/html/align-resume-app/align-resume-app_env
RUN sudo pip3 install -r /var/www/html/align-resume-app/requirements.txt
## Run the test suite
#RUN cd /var/www/html/align-resume-app/; /var/www/html/align-resume-app/align-resume-app_env/bin/python3 -m pytest tests/


#############################################################
## PERMISSIONS
#############################################################
# Make sure the cron job is executable so that cron can run it otherwise exit with an error
# Give execution rights on the cron job
RUN sudo chmod 0644 /etc/cron.d/align-resume-app-cron
RUN sudo chmod +x /etc/cron.d/align-resume-app-cron
RUN sudo chmod 755 /etc/cron.d/align-resume-app-cron/script.sh

## Create the log file to be able to run tail
#RUN touch /var/log/cron.log
#
## Run the command on container startup
#CMD cron && tail -f /var/log/cron.log

# Apply cron job
RUN /usr/bin/crontab /etc/cron.d/align-resume-app-cron/crontab.txt
RUN test -x /etc/cron.d/align-resume-app-cron && exit 0 || exit 1

# Set permissions for Apache
RUN sudo chgrp -R www-data /var/www/html/align-resume-app
RUN sudo chmod -R 470 /var/www/html/align-resume-app/static

#############################################################
## APACHE SET UP
############################################################
ENV APACHE_LOG_DIR /var/log/apache2/
ENV APACHE_RUN_DIR /etc/apache2
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2/apache2$SUFFIX.pid

RUN sudo a2enmod wsgi
RUN sudo a2dissite 000-default.conf
# Enables the site in Apache2
RUN sudo a2ensite align-resume-app.conf
RUN sudo a2enmod headers

# HTTP HTTPS REDIS
EXPOSE 80
# 443 6379

#############################################################
##                    E X E C U T E                         #
#############################################################
RUN echo "ServerName localhost:80" >> /etc/apache2/apache2.conf
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
