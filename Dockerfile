# build this image with: docker build -t dev/elasticsearch .
FROM docker.elastic.co/elasticsearch/elasticsearch:5.3.1

USER root

# make the data directory for Elasticsearch
RUN mkdir -p /home/elasticsearch/data
RUN chown -R elasticsearch:elasticsearch /home/elasticsearch/data
RUN chmod 0755 /home/elasticsearch/data

# make the logging directory for Elasticsearch
RUN mkdir -p /var/log/elasticsearch
RUN chown -R elasticsearch:elasticsearch /var/log/elasticsearch
RUN chmod 0755 /var/log/elasticsearch

# copy over the config file for Elasticsearch
COPY elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
RUN chown elasticsearch:elasticsearch /usr/share/elasticsearch/config/elasticsearch.yml

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod 0755 /usr/local/bin/docker-entrypoint.sh

USER elasticsearch

EXPOSE 9200 9300

CMD ["/usr/local/bin/docker-entrypoint.sh"]