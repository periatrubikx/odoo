FROM python:3.7
RUN apt-get update
RUN apt-get install -y libsasl2-dev python-dev libldap2-dev libssl-dev python-psycopg2 libpq-dev libxslt1-dev zlib1g-dev python-ldap nodejs npm
ADD . /usr/src/app
RUN pip3 install -r /usr/src/app/requirements.txt
ENV PYTHONUNBUFFERED 1