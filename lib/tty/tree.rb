# encoding: utf-8
# frozen_string_literal: true

require_relative 'tree/directory_renderer'
require_relative 'tree/number_renderer'
require_relative 'tree/hash_walker'
require_relative 'tree/path_walker'
require_relative 'tree/version'

module TTY
  class Tree
    # Create a Tree
    #
    # @param [String,Dir,Hash] data
    #
    # @api public
    def initialize(data)
      @data   = data.dup.freeze
      @walker = select_walker

      @walker.traverse(data)
    end

    # @api public
    def render(options = {})
      as = options.delete(:as) || :dir
      renderer = select_renderer(as).new(@walker.nodes, options)
      renderer.render
    end

    private

    # @api private
    def select_walker
      if @data.is_a?(Hash)
        HashWalker.new
      else
        @data ||= Dir.pwd
        PathWalker.new
      end
    end

    def select_renderer(as)
      case as
      when :dir, :directory then DirectoryRenderer
      when :num, :number then NumberRenderer
      end
    end
  end # Tree
end # TTY
