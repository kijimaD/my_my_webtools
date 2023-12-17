FROM fluent/fluentd:v1.16.2-debian-1.0 AS fluentd
USER root
RUN gem uninstall -I elasticsearch && \
    gem install elasticsearch -v 7.17.0 && \
    fluent-gem install fluent-plugin-elasticsearch
USER fluent

FROM docker.elastic.co/beats/metricbeat:8.11.3 AS metricbeat
COPY metricbeat.yml /usr/share/metricbeat/metricbeat.yml
USER root
RUN chown root /usr/share/metricbeat/metricbeat.yml

FROM docker.elastic.co/beats/heartbeat:8.11.3 AS heartbeat
COPY heartbeat.yml /usr/share/heartbeat/heartbeat.yml
USER root
RUN chown root /usr/share/heartbeat/heartbeat.yml
RUN chmod go-w /usr/share/heartbeat/heartbeat.yml # metricbeatではいらないんだけどな…
