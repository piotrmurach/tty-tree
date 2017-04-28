# encoding: utf-8
# frozen_string_literal: true

require 'pathname'

require_relative 'node'

module TTY
  class Tree
    # Walk and collect nodes from directory.
    #
    # @api public
    class PathWalker
      attr_reader :nodes

      attr_reader :files_count

      attr_reader :dirs_count

      # Create a PathWalker
      #
      # @api public
      def initialize(options = {})
        @files_count = 0
        @dirs_count  = 0
        @nodes       = []
        @max_level   = options.fetch(:max_level) { -1 }
      end

      # Traverse given path recursively
      #
      # @param [String] path
      #   the path to traverse
      #
      # @api public
      def traverse(path)
        root_path  = Pathname.new(path)
        empty_path = Pathname.new('')

        unless root_path.directory?
          raise ArgumentError, "#{root_path} is not a directory path"
        end

        @nodes << Node.new(root_path, empty_path, '', 0)

        walk(root_path, root_path.children, '', 1)
      end

      private

      # Filter paths
      def filter(files)
        files
      end

      # Walk paths recursively
      def walk(parent_path, files, prefix, level)
        if files.empty? || (@max_level != -1 && @max_level < level)
          return
        else
          processed_paths = filter(files).sort
          last_path_index = processed_paths.size - 1

          processed_paths.each_with_index do |path, i|
            sub_path = path.relative_path_from(parent_path)

            node = last_path_index == i ? LeafNode : Node

            if path.directory?
              next if @max_level != -1 && level + 1 > @max_level

              @nodes << node.new(sub_path, parent_path, prefix, level)
              @dirs_count += 1

              postfix = ':pipe'
              postfix = ':space' if i == last_path_index

              walk(path, path.children, prefix + postfix, level + 1)
            elsif path.file?
              @nodes << node.new(path.basename, parent_path, prefix, level)
              @files_count += 1
            end
          end
        end
      end
    end # PathWalker
  end # Tree
end # TTY
