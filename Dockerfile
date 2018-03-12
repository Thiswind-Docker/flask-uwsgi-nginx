FROM nginx:1.13

ENV DEBIAN_FRONTEND=noninteractive

# install python
RUN apt-get update
RUN apt-get install -y python-pip
RUN pip install uwsgi

##### for debug
RUN apt-get -y install vim \
	tmux \
	git \
	wget \
	zsh \
	locales \
	curl


RUN wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | zsh || true

# set locale for tmux
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment \
	&& echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
	&& echo "LANG=en_US.UTF-8" > /etc/locale.conf \
	&& locale-gen en_US.UTF-8

##### end of for debug


# install webapp
COPY ./webapp /webapp
WORKDIR /webapp
RUN pip install -r requirements.txt

# inject uwsgi config file into webapp/
COPY ./uwsgi_config.ini /webapp/uwsgi_config.ini
COPY ./uwsgi.nginx.template /webapp/uwsgi.nginx.template
COPY ./install_uwsgi_nginx.sh /webapp/install_uwsgi_nginx.sh

RUN bash /webapp/install_uwsgi_nginx.sh

# inject start.sh into webapp/
COPY ./start.sh /webapp/start.sh

# start
CMD ["/bin/bash", "/webapp/start.sh"]
