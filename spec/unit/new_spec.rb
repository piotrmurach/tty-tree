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
end
