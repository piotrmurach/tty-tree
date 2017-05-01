# encoding: utf-8
# frozen_string_literal: true

RSpec.describe TTY::Tree, '#new' do
  it "exposes [] as instance creation & accepts Dir" do
    tree = TTY::Tree[::File.join(Dir.pwd, 'lib')]

    expect(tree.nodes).to_not be_empty
  end

  it "exposes [] as instance creation & accepts Pathname" do
    tree = TTY::Tree[Pathname.pwd.join('lib')]

    expect(tree.nodes).to_not be_empty
  end

  it "provides DSL for creating tree" do
    tree = TTY::Tree.new do
      node 'dir1' do
        node 'config.dat'
        node 'dir2' do
          node 'dir3' do
            leaf 'file3-1.txt'
          end
          leaf 'file2-1.txt'
        end
        node 'file1-1.txt'
        leaf 'file1-2.txt'
      end
    end

    expect(tree.nodes).to eq([
      TTY::Tree::Node.new('dir1', Pathname.new(''), '', 0),
      TTY::Tree::Node.new('config.dat', Pathname.new('dir1'), '', 1),
      TTY::Tree::Node.new('dir2', Pathname.new('dir1'), '', 1),
      TTY::Tree::Node.new('dir3', Pathname.new('dir1/dir2'), ':pipe', 2),
      TTY::Tree::LeafNode.new('file3-1.txt', Pathname.new('dir1/dir2/dir3'), ':pipe:pipe', 3),
      TTY::Tree::LeafNode.new('file2-1.txt', Pathname.new('dir1/dir2'), ':pipe', 2),
      TTY::Tree::Node.new('file1-1.txt', Pathname.new('dir1'), '', 1),
      TTY::Tree::LeafNode.new('file1-2.txt', Pathname.new('dir1'), '', 1),
    ])
  end

  it "provides DSL for creating orphaned tree" do
    tree = TTY::Tree.new do
      node 'orphan_dir' do
        node 'a.txt'
        node 'b.txt'
        leaf 'data' do
          node 'data1.bin'
          node 'data2.sql'
          leaf 'data3.inf'
        end
      end
    end

    expect(tree.nodes).to eq([
      TTY::Tree::Node.new("orphan_dir", Pathname.new(''), '', 0),
      TTY::Tree::Node.new("a.txt", Pathname.new('orphan_dir'), '', 1),
      TTY::Tree::Node.new("b.txt", Pathname.new('orphan_dir'), '', 1),
      TTY::Tree::LeafNode.new("data", Pathname.new('orphan_dir'), '',  1),
      TTY::Tree::Node.new("data1.bin", Pathname.new('orphan_dir/data'), ':space', 2),
      TTY::Tree::Node.new("data2.sql", Pathname.new('orphan_dir/data'), ':space', 2),
      TTY::Tree::LeafNode.new("data3.inf", Pathname.new('orphan_dir/data'), ':space', 2)
    ])
  end

  it "yields current node to DSL tree node" do
    yielded = []

    TTY::Tree.new do
      node 'dir1' do |dir1|
        yielded << dir1
        node 'dir2' do |dir2|
          yielded << dir2
        end
      end
    end

    expect(yielded).to eq([
      TTY::Tree::Node.new("dir1", Pathname.new(''), '', 0),
      TTY::Tree::Node.new("dir2", Pathname.new('dir1'), '', 1),
    ])
  end
end
