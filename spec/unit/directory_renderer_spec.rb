# encoding: utf-8
# frozen_string_literal: true

RSpec.describe TTY::Tree::DirectoryRenderer do
  it "renders directory as path" do
    tree = within_dir(fixtures_path) do
      TTY::Tree.new('dir1')
    end

    expect(tree.render).to eq([
      "dir1\n",
      "├── config.dat\n",
      "├── dir2\n",
      "│   ├── dir3\n",
      "│   │   └── file3-1.txt\n",
      "│   └── file2-1.txt\n",
      "├── file1-1.txt\n",
      "└── file1-2.txt\n",
    ].join)
  end

  it "correctly renders orphaned directory as path" do
    tree = within_dir(fixtures_path) do
      TTY::Tree.new('orphan_dir')
    end

    expect(tree.render).to eq([
      "orphan_dir\n",
      "├── a.txt\n",
      "├── b.txt\n",
      "└── data\n",
      "    ├── data1.bin\n",
      "    ├── data2.sql\n",
      "    └── data3.inf\n",
    ].join)
  end

  it "renders directory as path" do
    tree = within_dir(fixtures_path) do
      TTY::Tree.new('dir1')
    end

    expect(tree.render(indent: 0)).to eq([
      "dir1\n",
      "├── config.dat\n",
      "├── dir2\n",
      "│├── dir3\n",
      "││└── file3-1.txt\n",
      "│└── file2-1.txt\n",
      "├── file1-1.txt\n",
      "└── file1-2.txt\n",
    ].join)
  end
end
