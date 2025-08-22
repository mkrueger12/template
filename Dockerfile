# Dockerfile for a base development image with Neovim, Node.js, and AI tools.
# This image is configured to run as the root user.

# Use the minimal, security-focused Wolfi base image
FROM cgr.dev/chainguard/wolfi-base

# 1. INSTALL SYSTEM-WIDE DEPENDENCIES & TOOLS
# Using a single RUN layer to reduce image size.
RUN apk update && \
    apk add --no-cache \
    # Core dependencies for Neovim and installation scripts
    neovim \
    git \
    curl \
    bash \
    zsh \
    # Node.js and npm for Language Servers and other tools
    nodejs \
    npm \
    # Common, fast dependencies for Telescope plugin (part of LazyVim)
    ripgrep \
    fd \
    # Build toolchain for compiling native Neovim plugins (e.g., treesitter)
    build-base \
    libstdc++-dev \
    linux-headers

# Install CLI tools separately to handle PATH issues
RUN curl -fsSL https://claude.ai/install.sh | bash && \
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> /root/.bashrc && \
    curl -fsSL https://opencode.ai/install | bash

# Set PATH environment variable for containers
ENV PATH="/root/.local/bin:/root/.opencode/bin:$PATH"

# Add lazyvim alias
RUN echo 'alias lazyvim="nvim"' >> /root/.bashrc

# 2. INSTALL LAZYVIM FOR ROOT
# Clone the LazyVim starter config into the root user's config directory.
# This pre-configures Neovim for any subsequent image layers.
RUN git clone https://github.com/LazyVim/starter /root/.config/nvim && \
    rm -rf /root/.config/nvim/.git

# 3. CLONE TEMPLATE REPO AND COPY OPENCODE CONFIG
RUN git clone https://github.com/mkrueger12/template.git /tmp/template && \
    mkdir -p /root/.config/opencode && \
    cp -r /tmp/template/opencode/* /root/.config/opencode/ && \
    rm -rf /tmp/template

# 4. COPY LOCAL OPENCODE AUTH FILE
RUN mkdir -p /root/.local/share/opencode
COPY auth.json /root/.local/share/opencode/auth.json

# 5. COPY ZSH CONFIG FILES
COPY .zshrc /root/.zshrc
COPY .zshenv /root/.zshenv

# 6. SET THE DEFAULT WORKING DIRECTORY
# Sets the working directory for any subsequent Dockerfile that uses this as a base.
WORKDIR /root

# NOTE: This base image intentionally omits a CMD or ENTRYPOINT.
# The final command should be defined in the Dockerfile that inherits from this one.