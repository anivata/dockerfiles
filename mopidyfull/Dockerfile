FROM mopidy:latest
COPY ./mopidyconfig/mopidy.conf /mopidy_default.conf
COPY mopidy1.sh /usr/local/bin/mopidy.sh
USER root
RUN mkdir /tmp/snapcast
RUN touch /tmp/snapcast/snapfifo
RUN chmod -R 777 /tmp/snapcast
RUN chown -R mopidy /tmp/snapcast
# USER mopidy

EXPOSE 6600 6680
ENTRYPOINT ["/usr/local/bin/mopidy.sh"]
