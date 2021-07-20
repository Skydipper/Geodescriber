FROM python:3.7
MAINTAINER Vizzuality Science Team info@vizzuality.com

ENV NAME geodescriber
ENV USER geodescriber
RUN addgroup $USER
RUN useradd -ms /bin/bash -g $USER $USER

RUN pip install --upgrade pip
RUN pip install gunicorn gevent setuptools

RUN mkdir -p /opt/$NAME
RUN cd /opt/$NAME
COPY requirements.txt /opt/$NAME/requirements.txt
RUN cd /opt/$NAME && pip install -r requirements.txt

COPY entrypoint.sh /opt/$NAME/entrypoint.sh
COPY main.py /opt/$NAME/main.py
COPY gunicorn.py /opt/$NAME/gunicorn.py

# Copy the application folder inside the container
WORKDIR /opt/$NAME

COPY ./$NAME /opt/$NAME/$NAME
COPY ./microservice /opt/$NAME/microservice
RUN chown $USER:$USER /opt/$NAME

# Tell Docker we are going to use this ports
EXPOSE 4501
USER $USER

# Launch script
ENTRYPOINT ["./entrypoint.sh"]

