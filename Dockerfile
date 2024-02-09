FROM python:3.10

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update && \
    apt-get install --no-install-recommends -qqy curl git && \
    apt-get install --no-install-recommends -qqy cppcheck clang-format && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir --quiet --upgrade pip && \
    pip install --no-cache-dir --quiet pre-commit

RUN mkdir -p /code
COPY pre-commit.sh /code/
WORKDIR /code

RUN git config --global --add safe.directory /code

RUN chmod +x pre-commit.sh

ENTRYPOINT ["bash", "-c", "./pre-commit.sh docker"]
