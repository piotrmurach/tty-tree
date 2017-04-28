# encoding: utf-8
# frozen_string_literal: true

module TTY
  class Tree
    class NumberRenderer
      def initialize(nodes, options = {})
        @indent = options.fetch(:indent, 4)
        @nodes = nodes
      end

      def render
        mark = ' ' * @indent

        @nodes.each_with_index.reduce([]) do |acc, (node, i)|
          acc << node.prefix.gsub(/:pipe|:space/, mark)
          if !node.root?
            acc << "#{node.level}.#{i} "
          end
          acc << node.name.to_s + "\n"
        end.join
      end
    end # NumberRenderer
  end # Tree
end # TTY
