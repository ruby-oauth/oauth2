# frozen_string_literal: true

# Loading the library, which every process that uses it pays once
duel_process "boot: require oauth2", ruby: %(require "oauth2")
