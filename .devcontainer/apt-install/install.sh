#!/bin/sh
set -e  # Exit on error

# Install basic development dependencies for Ruby & JRuby projects
apt-get update -y
apt-get install -y direnv default-jdk git zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev

# Support for PostgreSQL (commented out by default)
# apt-get install -y postgresql libpq-dev

# NOTE: Tree-sitter setup is NOT done here because the workspace is not mounted yet
# during the devcontainer build phase. Tree-sitter setup happens in postCreateCommand
# after the workspace is mounted. See devcontainer.json for details.
# This gem needs ALL grammars for top-level merging tool (handled by setup-tree-sitter.sh).

echo "Basic apt packages installed. Tree-sitter will be set up after workspace mount."

# Adds the direnv setup script to ~/.bashrc file (at the end)
echo 'eval "$(direnv hook bash)"' >> ~/.bashrc
