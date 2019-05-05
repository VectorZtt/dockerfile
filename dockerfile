FROM python:3.7
ADD ./jdk1.8.tar.gz /home/java_jdk
ADD ./andriod_sdk.tar /home/andriod_sdk

# Set java env
ENV JAVA_HOME /home/java_jdk/jdk1.8.0_211
ENV PATH $JAVA_HOME/bin:$PATH
ENV PATH $JAVA_HOME/jre:$PATH

# Set android sdk env
ENV ANDROID_HOME /home/andriod_sdk/adt-bundle-linux/sdk
ENV PATH $ANDROID_HOME/platform-tools:$PATH
ENV PATH $ANDROID_HOME/build-tools/android-4.4W:$PATH
ENV PATH $ANDROID_HOME/tools:$PATH
# Solve no adb command 
RUN apt-get update \
	&& apt-get install -y \
	libc6-i386 \ 
	lib32stdc++6 \ 
	lib32gcc1 \
	lib32ncurses5 \
    lib32z1

# install nodejs npm 
# Use npm install appium and appium-doctor
RUN apt-get install curl \
	&& curl -sL https://deb.nodesource.com/setup_12.x | bash - \
	&& apt-get install nodejs \
	&& apt-get install gcc g++ make \
	&& update-alternatives --install /usr/bin/python python /usr/bin/python2 100 \
	&& update-alternatives --install /usr/bin/python python /usr/bin/python3 150 \
	&& npm install -g cnpm --registry=https://registry.npm.taobao.org \
	&& cnpm install appium -g \
	&& cnpm install appium-doctor -g \
	&& rm -rf /var/lib/apt/list/*


# install chrome and chromedriver
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' \
    && sh -c 'echo "203.208.39.224 dl.google.com" >> /etc/hosts' \
    && apt-get update \
    && apt-get -y install google-chrome-stable --allow-unauthenticated \
	&& wget -N http://npm.taobao.org/mirrors/chromedriver/74.0.3729.6/chromedriver_linux64.zip \
	&& unzip chromedriver_linux64.zip \
	&& mv -f chromedriver /usr/local/share/chromedriver \
	&& ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver \
	&& ln -s /usr/local/share/chromedriver /usr/bin/chromedriver \
	&& rm chromedriver_linux64.zip

# install python packages
RUN pip3 install virtualenv \
	&& pip3 install mysqlclient \
	&& pip3 install uwsgi \
	&& pip3 install Django \
	&& pip3 install selenium \
	&& pip3 install SQLAlchemy \
	&& pip3 install Flask-SQLAlchemy \
	&& pip3 install Flask-RESTful \
	&& pip3 install selenium 

# install mysql
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -q -y install mysql-server 






