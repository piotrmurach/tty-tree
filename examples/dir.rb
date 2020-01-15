# frozen_string_literal: true

require_relative "../lib/tty-tree"

lib = File.expand_path("../lib", __dir__)

tree = TTY::Tree.new(lib)

puts tree.render(as: :dir)
