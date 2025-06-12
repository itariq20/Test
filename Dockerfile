FROM python:3.10-slim-buster
ARG JFROG_USERNAME
ARG JFROG_PASSWORD

COPY ./requirements.txt /app/requirements.txt

WORKDIR /app

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY . /app
COPY box_config.json /app/src/config/box_config.json


ENTRYPOINT ["python3"]