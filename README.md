# TTY::Tree [![Gitter](https://badges.gitter.im/Join%20Chat.svg)][gitter]

[![Gem Version](https://badge.fury.io/rb/tty-tree.svg)][gem]
[![Build Status](https://secure.travis-ci.org/piotrmurach/tty-tree.svg?branch=master)][travis]
[![Build status](https://ci.appveyor.com/api/projects/status/4cguoiah5dprbq7n?svg=true)][appveyor]
[![Code Climate](https://codeclimate.com/github/piotrmurach/tty-tree/badges/gpa.svg)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/github/piotrmurach/tty-tree/badge.svg)][coverage]
[![Inline docs](http://inch-ci.org/github/piotrmurach/tty-tree.svg?branch=master)][inchpages]

[gitter]: https://gitter.im/piotrmurach/tty
[gem]: http://badge.fury.io/rb/tty-tree
[travis]: http://travis-ci.org/piotrmurach/tty-tree
[appveyor]: https://ci.appveyor.com/project/piotrmurach/tty-tree
[codeclimate]: https://codeclimate.com/github/piotrmurach/tty-tree
[coverage]: https://coveralls.io/github/piotrmurach/tty-tree
[inchpages]: http://inch-ci.org/github/piotrmurach/tty-tree

> Print directory or structured data in a tree like format.

**TTY::Prompt** provides independent directory or hash data rendering component for [TTY](https://github.com/piotrmurach/tty) toolkit.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tty-tree'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tty-tree

## Contents

* [1. Usage](#1-usage)
* [2. Interface](#2-interface)
  * [2.1 options](#21-options)

## 1. Usage

`TTY::Tree` accepts as input a directory path:

```ruby
tree = TTY::Tree.new(Dir.pwd)
tree = TTY::Tree.new('dir-name')
```

or can be given as its input a `hash` data structure with keys representing directories and values as `array`s representing directory contents:

```ruby
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

tree = TTY::Tree.new(data)
```

The `TTY::Tree` can print the content in various formats. By default, a directory format is used by invoking `render`:

```ruby
puts tree.render
# =>
# dir1
# ├── config.dat
# ├── dir2,
# │   ├── dir3\n",
# │   │   └── file3-1.txt\n",
# │   └── file2-1.txt\n",
# ├── file1-1.txt\n",
# └── file1-2.txt\n",
```

The `render` call returns a string and leaves it up to api consumer how to handle the tree like output.

## 2. Interface

### 2.1 Options

### :max_level

The maximum level of depth for this tree when parsing directory. The initial directory is treated as index `0`.

```ruby
tree = TTY::Tree.new(max_level: 2)
# => parse directories as deep as 2 levels
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/piotrmurach/tty-tree. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Copyright

Copyright (c) 2017 Piotr Murach. See LICENSE for further details.

