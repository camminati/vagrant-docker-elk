FROM sebp/elk


## install jmx plugin
WORKDIR ${LOGSTASH_HOME}
RUN gosu logstash bin/logstash-plugin install logstash-input-jmx

# add logstash configuration
COPY elk/config/logstash/05-jmx.conf  /etc/logstash/conf.d/05-jmx.conf
COPY elk/config/logstash/jmx.conf.json /opt/config/logstash/jmx.conf
COPY elk/vendor/jar/jboss-cli-client.jar  /opt/logstash/vendor/jruby/lib/jboss-cli-client.jar


