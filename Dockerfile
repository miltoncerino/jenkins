FROM jenkinsci/blueocean

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

COPY setup-files/security.groovy /usr/share/jenkins/ref/init.groovy.d/security.groovy

COPY setup-files/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

COPY setup-files/thinBackup.xml /var/jenkins_home/
