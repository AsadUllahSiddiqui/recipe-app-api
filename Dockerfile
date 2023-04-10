
# NAME:IMAGE
FROM python:3.9-alpine3.13
#MAINTAINER
LABEL maintainer='Asadullah Siddiqui'
#RECOMMENTED THEN YOU ARE RUNNING PYHTON IN DOCKER CONTAINER (what it does it tel python you dont wanna buffer the output)
ENV PTYHONNUNBUFFERED 1

COPY ./requirements.txt /temp/requirements.txt
COPY ./app /app

WORKDIR /app

expose 8000

ARG DEV=false

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-build-deps \
        gcc libc-dev linux-headers postgresql-dev && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ] ; \
        then echo "--DEV BUILD--" && /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    apk del .tmp-build-deps && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user

