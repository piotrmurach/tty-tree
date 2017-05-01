# encoding: utf-8
# frozen_string_literal: true

RSpec.describe TTY::Tree::PathWalker do
  it "walks path tree and collects nodes" do
    walker = TTY::Tree::PathWalker.new

    within_dir(fixtures_path) do
      walker.traverse('dir1')
    end

    expect(walker.nodes).to eq([
      TTY::Tree::Node.new('dir1', Pathname.new(''), '', 0),
      TTY::Tree::Node.new('dir1/config.dat', Pathname.new('dir1'), '', 1),
      TTY::Tree::Node.new('dir2', Pathname.new('dir1'), '', 1),
      TTY::Tree::Node.new('dir3', Pathname.new('dir1/dir2'), ':pipe', 2),
      TTY::Tree::LeafNode.new('dir1/dir2/dir3/file3-1.txt', Pathname.new('dir1/dir2/dir3'), ':pipe:pipe', 3),
      TTY::Tree::LeafNode.new('dir1/dir2/file2-1.txt', Pathname.new('dir1/dir2'), ':pipe', 2),
      TTY::Tree::Node.new('dir1/file1-1.txt', Pathname.new('dir1'), '', 1),
      TTY::Tree::LeafNode.new('dir1/file1-2.txt', Pathname.new('dir1'), '', 1),
    ])

    expect(walker.nodes.map(&:full_path).map(&:to_s)).to eq([
      "dir1",
      "dir1/config.dat",
      "dir1/dir2",
      "dir1/dir2/dir3",
      "dir1/dir2/dir3/file3-1.txt",
      "dir1/dir2/file2-1.txt",
      "dir1/file1-1.txt",
      "dir1/file1-2.txt",
    ])
  end

  it "walks orphaned path tree and collects nodes" do
    walker = TTY::Tree::PathWalker.new

    within_dir(fixtures_path) do
      walker.traverse('orphan_dir')
    end

    expect(walker.nodes).to eq([
      TTY::Tree::Node.new("orphan_dir", Pathname.new(''), '', 0),
      TTY::Tree::Node.new("orphan_dir/a.txt", Pathname.new('orphan_dir'), '', 1),
      TTY::Tree::Node.new("orphan_dir/b.txt", Pathname.new('orphan_dir'), '', 1),
      TTY::Tree::LeafNode.new("data", Pathname.new('orphan_dir'), '',  1),
      TTY::Tree::Node.new("orphan_dir/data/data1.bin", Pathname.new('orphan_dir/data'), ':space', 2),
      TTY::Tree::Node.new("orphan_dir/data/data2.sql", Pathname.new('orphan_dir/data'), ':space', 2),
      TTY::Tree::LeafNode.new("orphan_dir/data/data3.inf", Pathname.new('orphan_dir/data'), ':space', 2)
    ])

    expect(walker.nodes.map(&:full_path).map(&:to_s)).to eq([
      "orphan_dir",
      "orphan_dir/a.txt",
      "orphan_dir/b.txt",
      "orphan_dir/data",
      "orphan_dir/data/data1.bin",
      "orphan_dir/data/data2.sql",
      "orphan_dir/data/data3.inf"
    ])
  end

  it "walks path tree and collects nodes limited by the level" do
    walker = TTY::Tree::PathWalker.new(level: 2)

    within_dir(fixtures_path) do
      walker.traverse('dir1')
    end

    expect(walker.nodes.map(&:full_path).map(&:to_s)).to eq([
      "dir1",
      "dir1/config.dat",
      "dir1/dir2",
      "dir1/dir2/file2-1.txt",
      "dir1/file1-1.txt",
      "dir1/file1-2.txt",
    ])
  end

  it "counts files & dirs" do
    walker = TTY::Tree::PathWalker.new

    within_dir(fixtures_path) do
      walker.traverse('dir1')
    end

    expect(walker.files_count).to eq(5)

    expect(walker.dirs_count).to eq(2)
  end

  it "counts files & dirs including max level limit" do
    walker = TTY::Tree::PathWalker.new(level: 2)

    within_dir(fixtures_path) do
      walker.traverse('dir1')
    end

    expect(walker.files_count).to eq(4)

    expect(walker.dirs_count).to eq(1)
  end

  it "raises when walking non-directory" do
    walker = TTY::Tree::PathWalker.new

    expect {
      walker.traverse('unknown-dir')
    }.to raise_error(ArgumentError, /unknown-dir is not a directory path/)
  end
end
