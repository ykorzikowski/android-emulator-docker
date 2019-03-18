# This Dockerfile creates a android enviroment prepared to run integration tests
from debian:buster

RUN apt-get update && apt-get install gnupg -y

# Install java 8
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list \
&& echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list \
&& apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 \
&& echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
&& apt-get update && apt-get install oracle-java8-installer oracle-java8-set-default -y

# Install another dependencies
RUN apt-get install gnupg2 git wget unzip gcc-multilib libglu1 xz-utils -y

#Install Android
ENV ANDROID_HOME /opt/android
RUN wget -O android-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip --show-progress \
&& unzip android-tools.zip -d $ANDROID_HOME && rm android-tools.zip
ENV PATH $PATH:$ANDROID_HOME/tools/bin

#Install Android Tools
RUN yes | sdkmanager --update --verbose
RUN yes | sdkmanager "platform-tools" --verbose
RUN yes | sdkmanager "platforms;android-27" --verbose
RUN yes | sdkmanager "platforms;android-28" --verbose
RUN yes | sdkmanager "build-tools;27.0.0" --verbose
RUN yes | sdkmanager "build-tools;28.0.3" --verbose
RUN yes | sdkmanager "extras;android;m2repository" --verbose
RUN yes | sdkmanager "extras;google;m2repository" --verbose

# Add platform-tools and emulator to path
ENV PATH $PATH:$ANDROID_HOME/platform-tools
ENV PATH $PATH:$ANDROID_HOME/emulator

# Install Flutter
ENV FLUTTER_HOME /opt/flutter
RUN wget -O flutter_linux_v1.2.1-stable.tar.xz https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.2.1-stable.tar.xz --show-progress \
 && tar xf flutter_linux_v1.2.1-stable.tar.xz -C /opt && rm flutter_linux_v1.2.1-stable.tar.xz
ENV PATH $PATH:$FLUTTER_HOME/bin

#Install latest android emulator system images
RUN yes | sdkmanager "system-images;android-24;google_apis;x86_64" --verbose
RUN yes | sdkmanager "system-images;android-25;google_apis;x86_64" --verbose
RUN yes | sdkmanager "system-images;android-26;google_apis;x86_64" --verbose
RUN yes | sdkmanager "system-images;android-27;google_apis;x86" --verbose
RUN yes | sdkmanager "system-images;android-28;google_apis;x86_64" --verbose

# Copy Qt library files to system folder
RUN cp -a /opt/android/emulator/lib64/qt/lib/. /usr/lib/x86_64-linux-gnu/

ADD start_emulator.sh /bin/start_emulator
RUN chmod +x /bin/start_emulator

ADD wait_emulator_boot.sh /bin/wait_emulator
RUN chmod +x /bin/wait_emulator

ADD unlock_emulator.sh /bin/unlock_emulator
RUN chmod +x /bin/unlock_emulator

#Label
MAINTAINER Yannik Korzikowski <docker@korzikowski.de>
LABEL Version="0.1.3" \
      Description="Android SDK and emulator environment with flutter"
