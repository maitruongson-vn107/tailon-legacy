FROM alpine:3.7 as base

COPY tailon /home/tailon
COPY requirements-dev.txt /home/tailon/requirements.txt

ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools \
    && pip3 install -r /home/tailon/requirements.txt \
    && echo -e "#!/bin/sh \n python3 __main__.py -c '/home/tailon/config/config.yml'" > home/tailon/run.sh \
    && chmod 755 /home/tailon/run.sh

WORKDIR /home/tailon

CMD ["sh", "run.sh"] 