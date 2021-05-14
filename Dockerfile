FROM python:3.9-slim

ENV GCLOUD_SDK_PATH=/usr/lib/google-cloud-sdk/

# sys packages
RUN mkdir -p /usr/share/man/man1/ && \
    apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    default-jre \
    gnupg \
    make

# Google Cloud SDK
RUN echo "deb https://packages.cloud.google.com/apt cloud-sdk-stretch main" > /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update && apt-get install --no-install-recommends -y \
        google-cloud-sdk \
        google-cloud-sdk-datastore-emulator && \
    rm -rf /var/lib/apt/lists/* && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image
