FROM fluent/fluentd:v1.16.2-debian-1.0 AS fluentd
USER root
RUN gem uninstall -I elasticsearch && \
    gem install elasticsearch -v 7.17.0 && \
    fluent-gem install fluent-plugin-elasticsearch
USER fluent
