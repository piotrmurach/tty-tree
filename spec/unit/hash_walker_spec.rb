# encoding: utf-8
# frozen_string_literal: true

RSpec.describe TTY::Tree::HashWalker do
  it "walks hash data and collects nodes" do
    data = {
      dir1: [
        'config.dat',
        { dir2: [
          { dir3: [ 'file3-1.txt' ] },
          'file2-1.txt'
          ]
        },
        'file1-1.txt',
        'file1-2.txt'
      ]
    }

    walker = TTY::Tree::HashWalker.new

    walker.traverse(data)

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

  it "walks path tree and collects nodes up to max level" do
    data = {
      dir1: [
        'config.dat',
        { dir2: [
          { dir3: [ 'file3-1.txt' ] },
          'file2-1.txt'
          ]
        },
        'file1-1.txt',
        'file1-2.txt'
      ]
    }

    walker = TTY::Tree::HashWalker.new(max_level: 2)

    walker.traverse(data)

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
    data = {
      dir1: [
        'config.dat',
        { dir2: [
          { dir3: [ 'file3-1.txt' ] },
          'file2-1.txt'
          ]
        },
        'file1-1.txt',
        'file1-2.txt'
      ]
    }
    walker = TTY::Tree::HashWalker.new

    walker.traverse(data)

    expect(walker.files_count).to eq(5)

    expect(walker.dirs_count).to eq(2)
  end
end
