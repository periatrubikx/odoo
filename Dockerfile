FROM python:3.7
RUN apt-get update
RUN apt-get install -y libsasl2-dev python-dev libldap2-dev libssl-dev python-psycopg2 libpq-dev libxslt1-dev zlib1g-dev python-ldap nodejs npm lsb-release
# install latest postgresql-client
RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main' > /etc/apt/sources.list.d/pgdg.list \
    && GNUPGHOME="$(mktemp -d)" \
    && export GNUPGHOME \
    && repokey='B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8' \
    && gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "${repokey}" \
    && gpg --batch --armor --export "${repokey}" > /etc/apt/trusted.gpg.d/pgdg.gpg.asc \
    && gpgconf --kill all \
    && rm -rf "$GNUPGHOME" \
    && apt-get update  \
    && apt-get install --no-install-recommends -y postgresql-client \
    && rm -f /etc/apt/sources.list.d/pgdg.list \
    && rm -rf /var/lib/apt/lists/*
ADD . /usr/src/app
RUN pip3 install -r /usr/src/app/requirements.txt
ENV PYTHONUNBUFFERED 1