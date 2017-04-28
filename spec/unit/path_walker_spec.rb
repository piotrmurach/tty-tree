# encoding: utf-8
# frozen_string_literal: true

RSpec.describe TTY::Tree::PathWalker do
  it "walks path tree and collects nodes" do
    walker = TTY::Tree::PathWalker.new

    within_dir(fixtures_path) do
      walker.traverse('dir1')
    end

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

  it "walks path tree and collects nodes" do
    walker = TTY::Tree::PathWalker.new(max_level: 2)

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
    walker = TTY::Tree::PathWalker.new(max_level: 2)

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
