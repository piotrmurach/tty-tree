# encoding: utf-8
# frozen_string_literal: true

module TTY
  class Tree
    # A representation of tree node
    #
    # @api private
    class Node
      attr_reader :name,
                  :parent,
                  :prefix,
                  :level

      def initialize(name, parent, prefix, level)
        @name   = name
        @parent = parent
        @prefix = prefix
        @level  = level
      end

      def full_path
        parent.join(name)
      end

      def root?
        parent.to_s.empty?
      end

      def leaf?
        false
      end

      def to_s
        @name
      end
    end # Node

    class LeafNode < Node
      def leaf?
        true
      end
    end
  end # Tree
end # TTY
