FROM registry.access.redhat.com/ubi8/ubi:8.2-343

RUN dnf -y --disableplugin=subscription-manager module enable ruby:2.5 && \
    dnf -y --disableplugin=subscription-manager --setopt=tsflags=nodocs install \
    # ruby 2.5 via module
    ruby-devel \
    # build utilities
    gcc-c++ git make redhat-rpm-config && \

    dnf clean all

ENV WORKDIR /opt/catalog-api-minion/
ENV RAILS_ROOT $WORKDIR
WORKDIR $WORKDIR

COPY . $WORKDIR
COPY docker-assets/entrypoint /usr/bin
COPY docker-assets/run_catalog_minion /usr/bin

RUN echo "gem: --no-document" > ~/.gemrc && \
    gem install bundler --conservative --without development:test && \
    bundle install --jobs 2 --retry 3 && \
    find $(gem env gemdir)/gems/ | grep "\.s\?o$" | xargs rm -rvf && \
    rm -rvf $(gem env gemdir)/cache/* && \
    rm -rvf /root/.bundle/cache

RUN chgrp -R 0 $WORKDIR && \
    chmod -R g=u $WORKDIR

ENTRYPOINT ["entrypoint"]
CMD ["run_catalog_minion"]
