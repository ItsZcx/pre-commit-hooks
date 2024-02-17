# Stage 1: Build stage
FROM python:3.10 AS builder

# Set non-interactive frontend
ENV DEBIAN_FRONTEND="noninteractive"

# Install system dependencies
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update && \
    apt-get install --no-install-recommends -qqy curl git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Haskell Stack
RUN curl -sSL https://get.haskellstack.org/ | sh

# Create a non-root user before installing Haskell tools
RUN useradd -m myuser
USER myuser

RUN stack update && \
    stack install hlint fourmolu

# Stage 2: Final stage
FROM python:3.10

# Set non-interactive frontend
ENV DEBIAN_FRONTEND="noninteractive"

# Copy necessary files and directories from the builder stage
COPY --from=builder /home/myuser/.local/bin/hlint /usr/local/bin/
COPY --from=builder /home/myuser/.local/bin/fourmolu /usr/local/bin/

# Remove unnecessary packages and cleanup
RUN apt-get update && \
    apt-get install --no-install-recommends -qqy cppcheck clang-format && \
    apt-get remove -qqy curl && \
    apt-get autoremove -qqy && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip and install pre-commit
RUN pip install --no-cache-dir --quiet --upgrade pip && \
    pip install --no-cache-dir --quiet pre-commit

# Create a non-root user and set working directory
RUN useradd -m myuser && \
    mkdir -p /code && \
    chown -R myuser:myuser /code
WORKDIR /code

# Add pre-commit script, give permissions, and configure Git
COPY pre-commit.sh /code/
RUN chmod +x /code/pre-commit.sh && \
    git config --global --add safe.directory /code

# Switch to non-root user
USER myuser

# Set PATH environment variable
ENV PATH="${PATH:+${PATH}:}/home/myuser/.local/bin"

# Default command
ENTRYPOINT ["bash", "-c", "./pre-commit.sh docker"]
