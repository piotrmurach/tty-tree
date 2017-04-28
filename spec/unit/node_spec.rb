# encoding: utf-8
# frozen_string_literal: true

RSpec.describe TTY::Tree::Node do
  it "provides directory stats" do
    dir = fixtures_path('dir1')
    node = TTY::Tree::Node.new(dir, '', '',  0)

    expect(node.directory?).to eq(true)
    expect(node.file?).to eq(false)
    expect(node.symlink?).to eq(false)
    expect(node.socket?).to eq(false)
    expect(node.pipe?).to eq(false)
  end

  it "informs if node is hidden" do
    file = fixtures_path('hidden', 'dir1', '.file1.2')
    node = TTY::Tree::Node.new(file, '', '', 0)

    expect(node.hidden?).to eq(true)
  end
end
