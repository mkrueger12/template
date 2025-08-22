# Dockerfile for a base development image with Neovim, Node.js, and AI tools.
# This image is configured to run as a non-root user for security.

# Use Bun Slim base image
FROM oven/bun:slim

# Create a non-root user
RUN groupadd -r devuser && useradd -r -g devuser -m -s /bin/bash devuser

# 1. INSTALL SYSTEM-WIDE DEPENDENCIES & TOOLS
# Using a single RUN layer to reduce image size.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    # SSL certificates for HTTPS connections
    ca-certificates \
    # Core dependencies for Neovim and installation scripts
    neovim \
    git \
    curl \
    bash \
    zsh \
    unzip \
    # Common, fast dependencies for Telescope plugin (part of LazyVim)
    ripgrep \
    fd-find \
    # Build toolchain for compiling native Neovim plugins (e.g., treesitter)
    build-essential \
    # Clean up apt cache to reduce image size
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    # Update CA certificates
    && update-ca-certificates

# Install CLI tools separately to handle PATH issues
RUN runuser -l devuser -c 'curl -fsSL https://claude.ai/install.sh | bash' && \
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> /home/devuser/.bashrc && \
    runuser -l devuser -c 'curl -fsSL https://opencode.ai/install | bash'

# Set PATH environment variable for containers
ENV PATH="/home/devuser/.local/bin:/home/devuser/.opencode/bin:$PATH"

# Set locale environment variables
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Add lazyvim alias
RUN echo 'alias lazyvim="nvim"' >> /home/devuser/.bashrc

# 2. INSTALL LAZYVIM FOR DEVUSER
# Clone the LazyVim starter config into the devuser's config directory.
# This pre-configures Neovim for any subsequent image layers.
RUN git clone https://github.com/LazyVim/starter /home/devuser/.config/nvim && \
    rm -rf /home/devuser/.config/nvim/.git

# 3. CLONE TEMPLATE REPO AND COPY OPENCODE CONFIG
RUN git clone https://github.com/mkrueger12/template.git /tmp/template && \
    mkdir -p /home/devuser/.config/opencode && \
    cp -r /tmp/template/opencode/* /home/devuser/.config/opencode/ && \
    rm -rf /tmp/template

# 4. COPY LOCAL AUTH AND CONFIG FILES
RUN mkdir -p /home/devuser/.local/share/opencode
COPY auth.json /home/devuser/.local/share/opencode/auth.json
COPY .claude.json /home/devuser/.claude.json

# 5. INSTALL OH-MY-ZSH FOR DEVUSER
RUN runuser -l devuser -c 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended'

# 6. COPY ZSH CONFIG FILES
COPY .zshrc /home/devuser/.zshrc
COPY .zshenv /home/devuser/.zshenv

# 7. SET PROPER OWNERSHIP AND PERMISSIONS
RUN chown -R devuser:devuser /home/devuser

# 8. SWITCH TO NON-ROOT USER
USER devuser

# 9. SET THE DEFAULT WORKING DIRECTORY
WORKDIR /home/devuser

# NOTE: This base image intentionally omits a CMD or ENTRYPOINT.
# The final command should be defined in the Dockerfile that inherits from this one.